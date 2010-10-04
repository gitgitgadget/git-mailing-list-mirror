From: suvayu ali <fatkasuvayu+linux@gmail.com>
Subject: Re: Command specific pager settings
Date: Mon, 4 Oct 2010 16:07:09 -0700
Message-ID: <AANLkTikDQfQPmk1i1vuydVf0yMAN45x+Q+q-yUr6i0=Y@mail.gmail.com>
References: <AANLkTimLt0ERrB5b9p+_7fZBWfK3PHJkydmouiGfnurz@mail.gmail.com> <20101004135312.GA11237@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 05 01:07:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2u8N-0008IV-HL
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 01:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757346Ab0JDXHq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 19:07:46 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:46989 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125Ab0JDXHp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 19:07:45 -0400
Received: by wwe15 with SMTP id 15so15739wwe.1
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 16:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=jkE7zWZb2g18JHFajSlMX5idq2GRNeIjawb7jqVzX6U=;
        b=ADM36ljka0jJwceX1p6D4s6NVU6ZQv9GvUgfmE51jNeOcIU9ZpRWtMuXZ49zfCyaVL
         /TWG4i3jkP8GRigUWbAJa3826kNTJMPX3uJQ+6DHAjTnsrHAfWGZOFS2SCS4eqQ+gKMH
         9epnVA7ZUItK2HuMWDHw6+tSMjBwedlvU/5Jw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=sVccsRKpt/zuM5XlSSFqzRyDha6QZZI9w3cNJaU6VkI5te2Nm1mmehD+q7KIc4N7BK
         iB30m+SxWO4cJRcpgRb7oKsaySP0KAJzbmIVsgrMYNT6zcQ4ttSEvp/RrOoapOoOJLz2
         FJQKQMjUT3RSlTrJSFgW2vxCeEA2SEFg1IpE0=
Received: by 10.216.10.11 with SMTP id 11mr250658weu.64.1286233649530; Mon, 04
 Oct 2010 16:07:29 -0700 (PDT)
Received: by 10.216.79.66 with HTTP; Mon, 4 Oct 2010 16:07:09 -0700 (PDT)
In-Reply-To: <20101004135312.GA11237@sigill.intra.peff.net>
X-Google-Sender-Auth: exexEdsHw9ClpLlY5lAYfJWlAW0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158143>

Hi Jeff,

On 4 October 2010 06:53, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 04, 2010 at 12:37:29AM -0700, suvayu ali wrote:
>
>> I wanted to set my pager to `less -iRS' when looking at patches (so
>> that would mean commands like `git diff'), but would prefer `less
>> -iFRS' or even the git default `less -FRSX' for all other things e.g
>> `git log'.
>>
>> I looked at core.pager and pager.<cmd> but I couldn't understand how=
 I
>> could set different pagers for say just one/ a subset of commands (g=
it
>> diff in my case).
>>
>> Is this possible? If not, would it be a worthwhile feature request?
>
> It's not currently possible, but this patch should do what you want,
> like:
>
> =A0git config core.pager "less -FRSX"
> =A0git config pager.diff "less -iRS"
>
> -- >8 --
> Subject: [PATCH] allow command-specific pagers in pager.<cmd>
>
> A user may want different pager settings or even a
> different pager for various subcommands (e.g., because they
> use different less settings for "log" vs "diff", or because
> they have a pager that interprets only log output but not
> other commands).
>
> This patch extends the pager.<cmd> syntax to support not
> only boolean to-page-or-not-to-page, but also to specify a
> pager just for a specific command.

This is exactly what I was hoping to achieve! However I use the git
packages for my distro (Fedora 13), I'll keep a lookout for the
updates with your patch. Thank you soo much. :)

--=20
Suvayu

Open source is the future. It sets us free.
