From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH v2 1/2] test: git-stash conflict sets up rerere
Date: Fri, 17 Aug 2012 13:52:07 -0400
Message-ID: <CABURp0rdZ2N6exE0gpJncSnTzGB0Hbr+RuO4G5F6zb=z8Qb0Sg@mail.gmail.com>
References: <CABURp0oXhZ5ysm4b3Z=7o+2TB+3wFdMjj4oEwxafApjD4c7ozA@mail.gmail.com>
 <1341693962-17090-1-git-send-email-hordp@cisco.com> <1341693962-17090-2-git-send-email-hordp@cisco.com>
 <7v8vetmzgz.fsf@alter.siamese.dyndns.org> <CABURp0rrTvQcjHLsVwXC5hfBOuRmFG4AzSj6ZQwM=MXn0FAUCQ@mail.gmail.com>
 <7vehn6zedz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Phil Hord <hordp@cisco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 19:52:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2Qiv-0006GP-TG
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 19:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758711Ab2HQRwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 13:52:38 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:42431 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758694Ab2HQRw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 13:52:29 -0400
Received: by qaas11 with SMTP id s11so1796369qaa.19
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ow4Ine6OBQ4LDTmwQVlvVaM6bTBSdBhtpjiOYSDDhBo=;
        b=S6JHX+7OkVN1ERJ/OHJnDqP/35FkKIj/lqmb1px2W1dRRF7s+MXHHXV60p6yCaPOQC
         H35Fbr4tbS1miUWYIHTojDagldJ+KyN8+Lt3WInEcK39fGvfRwp0PUrDSuVJaafFzTRe
         SPpsKfAEt4dbeycok76HOI2+5oPP5Jsj/am3pQv8uwvySYguY45AGrdPUFPmxf9mVLmQ
         IVRX/YwN+1LJXWNat1n4frpArbfMujQZugAacov0OYVdAI18N4c/8aIL6ufGFN9NoUeF
         zh+mUbBSSXueq2toplCqRZWGh4UfBXQ/kmVtbnyT6SBm7BDVCGGnDGtrFsIsjC7hijvh
         bowA==
Received: by 10.229.135.202 with SMTP id o10mr4403195qct.20.1345225948085;
 Fri, 17 Aug 2012 10:52:28 -0700 (PDT)
Received: by 10.229.52.77 with HTTP; Fri, 17 Aug 2012 10:52:07 -0700 (PDT)
In-Reply-To: <7vehn6zedz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203634>

On Thu, Aug 16, 2012 at 6:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Phil Hord <phil.hord@gmail.com> writes:
>
>> So, the next roll will remove the tests for MERGE_RR and will be more
>> explicit about the potential for mergetool confusion and/or the fact
>> that it is not explicitly tested here.
>>
>> I'll wait a little longer for any further comments.
>
> Mild ping to a seemingly stalled topic.

I was going to say the same thing.

Patch v3 series is here:
http://permalink.gmane.org/gmane.comp.version-control.git/201282
http://permalink.gmane.org/gmane.comp.version-control.git/201283

I assume these were missed because I sent them during some critical
point in the release cycle.  But maybe it was because I missed some
step in the submission-revision protocol.  If the latter, please let
me know and I will try to learn to do better next time.

Phil ~ resent due to missed ReplyAll button
