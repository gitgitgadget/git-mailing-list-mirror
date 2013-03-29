From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] cherry-pick -x: improve handling of one-liner commit messages
Date: Fri, 29 Mar 2013 10:41:17 -0700
Message-ID: <CA+sFfMet0578rLwAKBBsd8DM3thsw=8+joEAAf44TzwqUZgXzw@mail.gmail.com>
References: <20130329153818.GB27251@suse.cz>
	<7v8v56p1bl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Miklos Vajna <vmiklos@suse.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 29 18:41:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULdJE-0006ra-9p
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 18:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756221Ab3C2RlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 13:41:19 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33188 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755858Ab3C2RlT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 13:41:19 -0400
Received: by mail-wi0-f181.google.com with SMTP id hj8so82590wib.8
        for <git@vger.kernel.org>; Fri, 29 Mar 2013 10:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=1Nk2oLkEcfqPEEfOx6pFxMhF4giPcpBs5gssaXFLOpU=;
        b=tMuv848adUi53gBBdMijqCWtj892pXVHLz/Y8hySVb+meHYt8UMsTZyag2NLQfnMR1
         5HVCuqpb1sKNSScKgB+BMweb9JvsG5ZW07TBANo1vJk4PIBRDgOrNF/kzbaAV2WB/fTm
         OAWORV2HJ9A1uSAJVEEWwDwTJkFBHGY+8ZoOr4p5yYcaKZXpnQDKLYfH28iP55iGPEom
         bkmjluxhoa6fvZJ7PIsRp4+/xFXxOUVsOU0TdtDsfmFpQNenmEswnuBjz8w4+y2nWmVW
         RShns436mXhcsMhTT45cN9euyIBh0K2iujn8b6k9Bux0S+NkoX/l0YzKlyaNWcl4IL3a
         y/TQ==
X-Received: by 10.194.10.129 with SMTP id i1mr4916732wjb.21.1364578878029;
 Fri, 29 Mar 2013 10:41:18 -0700 (PDT)
Received: by 10.194.249.69 with HTTP; Fri, 29 Mar 2013 10:41:17 -0700 (PDT)
In-Reply-To: <7v8v56p1bl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219515>

On Fri, Mar 29, 2013 at 10:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Miklos Vajna <vmiklos@suse.cz> writes:
>
>> git cherry-pick -x normally just appends the "cherry picked from commit"
>> line at the end of the message, which is fine. However, in case the
>> original commit message had only one line, first append a newline,
>> otherwise the second line won't be empty, which is against
>> recommendations.
>> ---
>
> Sign-off?
>
> I think this is part of the bc/append-signed-off-by topic that is
> about to graduate to 'master'; more specifically, b971e04f54e7
> (sequencer.c: always separate "(cherry picked from" from commit
> body, 2013-02-12) does the equivalent, no?

Yeah, I think this case is already handled.

Miklos, can you check out next and see if your problem case is handled?

-Brandon
