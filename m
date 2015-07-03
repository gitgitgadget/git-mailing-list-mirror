From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PUB]What's cooking in git.git (Jul 2015, #01; Wed, 1)
Date: Fri, 03 Jul 2015 10:57:58 -0700
Message-ID: <xmqqlhex3yzd.fsf@gitster.dls.corp.google.com>
References: <xmqqzj3f5wtr.fsf@gitster.dls.corp.google.com>
	<vpqbnfudhuv.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 03 19:58:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZB5Dy-0002xT-RG
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 19:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755082AbbGCR6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 13:58:01 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33297 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199AbbGCR6A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 13:58:00 -0400
Received: by pdjd13 with SMTP id d13so67018494pdj.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4psR7NRXiLpTMmEKk9YqQKcdjo+5+uAhQ23JWtWgWjc=;
        b=Uxin0KnhQtlPCaU1OKca7eXGOlKdz70/Zhi7TXxDOH2QjAkR+zY04a2VtAam2oGO0I
         ZKaFEHkVSxHnvSoEe+8R9gf1iYKxXK9lpcnpWI81pZiqbx2i2r1MxNYK964akFGF6fcD
         WIEG4CRCpy4NhTXQ2qRDqfVfp0EA046WJh2bvn995XSry+7pw0XiRYXfo2hNAC/LANL/
         AuzzYz/+NsNg7WYPOsl+B/imZCvpIBItbMqgG9WjXOL84hGf/pECYcZeUP820iJZyk52
         uL40YIAAmIh9k9JQuVGf4kAZFa/z3BNoKnog3616rffL9cv9yP8KzXvx4ULR5gqC3zxh
         OSZQ==
X-Received: by 10.67.14.39 with SMTP id fd7mr57065021pad.97.1435946279552;
        Fri, 03 Jul 2015 10:57:59 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:846f:c5d0:52c9:d18a])
        by mx.google.com with ESMTPSA id bf5sm9788845pad.43.2015.07.03.10.57.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 Jul 2015 10:57:58 -0700 (PDT)
In-Reply-To: <vpqbnfudhuv.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	02 Jul 2015 11:33:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273306>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * ad/bisect-terms (2015-06-29) 10 commits
> ...
>>  The bottom part has been quite well cooked.  Perhaps split it into
>>  two topisc and merge the earlier ones to 'next' before the rest
>>  settles.  Michael's idea to make 'good/bad' more intelligent does
>>  have certain attractiveness ($gname/272867).
>
> I think it makes sense to merge the first patches soon:
>
>  - bisect: don't mix option parsing and non-trivial code
>  - bisect: simplify the addition of new bisect terms
>  - bisect: replace hardcoded "bad|good" by variables
>  - Documentation/bisect: revise overall content
>  - Documentation/bisect: move getting help section to the end
>  - bisect: correction of typo
>
> I have nothing to add on the last ones, but they can cook in pu a bit
> longer.
>
> Do you expect anything from my side?

Not at this moment.  Thanks for helping this topic move forward.
