From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/7] New remote-bzr remote helper
Date: Wed, 28 Nov 2012 03:18:27 +0100
Message-ID: <CAMP44s3t54zYFha_qsDrg0JDZ52q8=WTs7q0rJ9qZL8kVCVWKA@mail.gmail.com>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s2F9C4cr6v===M3AWHieaiUk1adigcU8txpZPL0wN81Ow@mail.gmail.com>
	<7v4nkdxawx.fsf@alter.siamese.dyndns.org>
	<CAMP44s1G3b3XQX+=5Ag2exdy83hULbz1m0Z6UFDrhZU2TGwBMg@mail.gmail.com>
	<7vehjelizc.fsf@alter.siamese.dyndns.org>
	<CAMP44s0swzsg1MkQHkPUtwZi71xaad3y4uY542jYvXAf8Ha5nQ@mail.gmail.com>
	<7vsj7ujxr2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 03:18:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdXEZ-0003kl-MW
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 03:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896Ab2K1CS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 21:18:28 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:35145 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab2K1CS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 21:18:28 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so13097870oag.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 18:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TIjJhIuTK79vU02gVfjRkrUu1zso68nFO8dECixNib0=;
        b=GSHZc+DbolgCrOv0YnvWUGLunSr1hv+rDCYPkeXDrqM+nHv+MNHIYPcsVYSCJ63pCe
         1CdJlE5peFvKAMQz3U/rSCYjFaSI9wDMzwCxkeEK2zUpyW934Ija6vMs/354mpGW1aax
         ENDXCFUKRLMQpI7N4DSxueBJLWus2wEoQH8PfaIvDh9/5rXxWxCpuLuJ1El0XMk+88cy
         zGd78HCnOrue83lcaYFlFSAAxFWBbfxEW/yId1obUlSkUdEaB6BDueKRpLvn+6KdHHfP
         ifGAfg6XMcKvYMtCasXOgRKpg3tNpD3DEUY8isEqv92sbofhp0AkftyUGhVLT8wR066g
         kXEw==
Received: by 10.182.21.135 with SMTP id v7mr1599939obe.101.1354069107579; Tue,
 27 Nov 2012 18:18:27 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 18:18:27 -0800 (PST)
In-Reply-To: <7vsj7ujxr2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210673>

On Wed, Nov 28, 2012 at 2:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> OK.  Both fc/remote-hg and fc/remote-bzr are slated for 'master'
>>> soonish, but I take the above to mean that fc/remote-hg is ready
>>> while it is better to wait for updates to fc/remote-bzr before
>>> merging it.
>>
>> I was waiting on both to be merged, let me see what I have pending and
>> would be nice to have before the merge.
>
> OK.
>
> At this point, both have been cooking for a week or more in 'next',
> there is no existing users, they are on the fringe so breakages in
> them won't negatively affect anybody anyway.  So it doesn't matter
> much if they are merged to 'master' and then fixed up with follow up
> patches after that, or fixed up with follow up patches while they
> are in 'next', as they won't be rewound and restarted from scratch.

The fixes are affecting some people, that's why I did them. Some were
reported here in the mailing list, and some in my github's clone:

https://github.com/felipec/git/issues?page=1&state=closed

I tried to minimize the changes in the last patch series I sent, I
have more, but those truly can wait.

Cheers.

-- 
Felipe Contreras
