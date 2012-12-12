From: Javier Domingo <javierdo1@gmail.com>
Subject: Re: Fwd: possible Improving diff algoritm
Date: Thu, 13 Dec 2012 00:32:53 +0100
Message-ID: <CALZVapnzYBhPU1nR=eCSnm73c9-SpHq34DHu7OWCkouCQS0FxQ@mail.gmail.com>
References: <CAO54GHC4AXQO1MbU2qXMdcDO5mtUFhrXfXND5evc93kQhNfCrw@mail.gmail.com>
 <CAO54GHD3C2RKUvE5jK_XOCVbbDuE_c5xfe28rOL+DaE5anL-Wg@mail.gmail.com>
 <7vvcc73yzh.fsf@alter.siamese.dyndns.org> <CANv4PNm45xGBn2veKi1o0wB4K9NgsbtCsiymHNO4xbCDpJ5tDg@mail.gmail.com>
 <7vpq2f2az4.fsf@alter.siamese.dyndns.org> <CAH5451=4dqqMnQa-R6O4ZrHOPSpHU9joWqf2UuOkbLtU9f8bkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Morten Welinder <mwelinder@gmail.com>, Kevin <ikke@ikke.info>,
	git <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 00:33:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tivnw-0006oZ-OE
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 00:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815Ab2LLXdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 18:33:15 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:34136 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466Ab2LLXdO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 18:33:14 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so1091641qcr.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 15:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yYgApS8M5J5CZJPS5g66UW56mM56as0gw7FSxONcTgg=;
        b=RyEl8sctjzhEtJ8kBpAMJhOokZ1XTLNZ4ieIi6/FJDnG/1j5qgRhUHRHgbQ5qscrJz
         tQqb+Z18XP4vl9ksBcWYPaNhlvhgp75vxreRWajG1UmU61VBVPnlDBGUuH78fWEnfJLN
         FmviKVbO+X4gmD0fumex+Dpb6KvR657EQM9QE67ivECrrDrQnAbcs39VGgL6rF8kFXu2
         peD9Ysf1LTK3tjp2jx4Gz5rbqCQY/4S23ityFATKkR9NDOEB4dEMAbAZpmn5DVvFFGAB
         tPhaHH0SBWtRUReomt/Qk7IFBrzVR4LtAXqrbrSq1usVN6EMZnekOtqg2GN6qCgQuCdH
         Os/g==
Received: by 10.224.107.3 with SMTP id z3mr171669qao.9.1355355194074; Wed, 12
 Dec 2012 15:33:14 -0800 (PST)
Received: by 10.49.63.68 with HTTP; Wed, 12 Dec 2012 15:32:53 -0800 (PST)
In-Reply-To: <CAH5451=4dqqMnQa-R6O4ZrHOPSpHU9joWqf2UuOkbLtU9f8bkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211418>

I must say it is _quite_ helpfull having the diffs well done (natural
diffs as here named), just because when you want to review a patch on
the fly, this sort of things are annoying.

I just wanted to say my opinion. No idea on how to fix that, nor why
does it happen.

Javier Domingo


2012/12/12 Andrew Ardill <andrew.ardill@gmail.com>:
> On 13 December 2012 08:53, Junio C Hamano <gitster@pobox.com> wrote:
>> The output being "a correct patch" is not the only thing we need to
>> consider, though, as I mentioned in another response to Kevin
>> regarding the "consequences".
>
> The main benefit of picking a more 'natural' diff is a usability one.
> I know that when a chunk begins and ends one line after the logical
> break point (typically with braces in my experience) mentally parsing
> the diff becomes significantly harder. If there was a way to teach git
> where it should try and break out a chunk (potentially per filetype?)
> this is a good thing for readability, and I think would outweigh any
> temporary pain with regards to cached rerere and diff data.
>
> Regards,
>
> Andrew Ardill
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
