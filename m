From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: Re: [PATCH] Test atomic git-commit --interactive
Date: Tue, 10 May 2011 14:01:48 -0700
Message-ID: <BANLkTim-LxUh=rVLD=vevvpH7KsG=3crtQ@mail.gmail.com>
References: <BANLkTikwjZkzMxksBsVTFRYdhE3L6ZQM0A@mail.gmail.com>
	<1305054751-12327-1-git-send-email-conrad.irwin@gmail.com>
	<20110510194334.GA14456@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 10 23:01:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJu42-000791-RD
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 23:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051Ab1EJVBu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2011 17:01:50 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64236 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750Ab1EJVBt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2011 17:01:49 -0400
Received: by yxs7 with SMTP id 7so2293162yxs.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PfvUqHSgk942rhmBccEL+xaKZKZJMp1RSrG+cPWrXCE=;
        b=IFVduQFtl8YZDM5ayylw5ZwIdRGkY00gyyK4D7UDKSdTVucMcKzkmukhdQKFpeWxpx
         8e11SPa4Uvi7rvoxa5G8c1nR5fv8jarORWe9NVU9RzD9Sb7nTwoNpcSBCqFnGBJvKwPX
         gjdoCW6LYsPqub3eCikubGGPCEe3tofDsxiZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xmi1nZBCR4Lj/jIqV04X8nTQR5/I75KFYAGxgPlSFIlhQgyNSVmQN1l+n+r8KYG0vH
         UYPm/g4sK9IpZMDcGLrPTLMCd/1UXUnlwIWubY3Xm+kTfGtU79Uii+YJ2giGFaKj9tYg
         ibzbCjEnH8avlYzB8+irKQEWHQV9CcI4oC0C4=
Received: by 10.236.103.138 with SMTP id f10mr10095146yhg.109.1305061308801;
 Tue, 10 May 2011 14:01:48 -0700 (PDT)
Received: by 10.236.110.176 with HTTP; Tue, 10 May 2011 14:01:48 -0700 (PDT)
In-Reply-To: <20110510194334.GA14456@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173364>

On Tue, May 10, 2011 at 12:43 PM, Jeff King <peff@peff.net> wrote:
> On Tue, May 10, 2011 at 12:12:31PM -0700, Conrad Irwin wrote:
>
>> +test_expect_success PERL \
>> + =A0 =A0 "--interactive doesn't change index if editor aborts" \
>> + =A0 =A0 "EDITOR=3Dfalse echo zoo >file && \
>
> This EDITOR bit does nothing, since it sets the value only for the
> "echo" command. The test happens to do what you want, though, since w=
e
> set EDITOR to ":" in test-lib.sh, and that is also a fine value for y=
our
> test (it's probably a better test, anyway; it simulates the user
> aborting with an empty message instead of the editor crashing).

> =A0(EDITOR=3D: && export EDITOR &&
> =A0 test_must_fail git commit --interactive)

That makes sense, I was unaware of the : command, thank you.

> You can drop the backslash-continuation on lines that end with "&&" o=
r
> "|", which makes things a bit more readable.

Good to know.

> So the result should look like:

Awesome, thanks.

Conrad
