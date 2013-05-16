From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 7/8] remote-bzr: reorganize the way 'wanted' works
Date: Thu, 16 May 2013 18:09:53 -0500
Message-ID: <CAMP44s32kNXuijxfibejzOne+5-RsXofyr+CY85NTCy4QTOAaw@mail.gmail.com>
References: <1368693407-21267-1-git-send-email-felipe.contreras@gmail.com>
	<1368693407-21267-8-git-send-email-felipe.contreras@gmail.com>
	<7v7giy6aeh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 01:10:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud7J9-0000EU-K0
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 01:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216Ab3EPXJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 19:09:55 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:35582 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728Ab3EPXJz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 19:09:55 -0400
Received: by mail-la0-f51.google.com with SMTP id lx15so1660501lab.10
        for <git@vger.kernel.org>; Thu, 16 May 2013 16:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=rHvhEKJbQNksnDg384e5RlORvfgAdEU8k3/0O/9CKY4=;
        b=k9l4HJR4odEVR3ijpqwHGSRK3B/z6Yhm8LxZCsXwbmq+QBIuU9GMMvc+2fS3PmA/Z0
         EIdIvGwci4+0ai4TUrmvpzSb7X1Wg25X9Fg/S7yj+Vg2TaNLGmBGH+ceATTOpCrCklFx
         sj7b5YSg/SaIKtaahM37vRyujOEN7ORejVQgKJXd0D32tbDWlliR8PZj+bDTwENccbHr
         g2/p2R7YOnOaW6Oa888r8243lCaRqb2hDAS+506DV1+26MYkLELoJkZNRFHdLtl3/m2Z
         Ar5bb9QXJMp4nQp85mXP4YqjIGfiVXRkrtrAdsqirwuaRYsUodae3dD4MNhccbzHOZzO
         0EBg==
X-Received: by 10.112.166.101 with SMTP id zf5mr20696961lbb.59.1368745793893;
 Thu, 16 May 2013 16:09:53 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 16:09:53 -0700 (PDT)
In-Reply-To: <7v7giy6aeh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224629>

On Thu, May 16, 2013 at 1:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The series fails to apply (on top of the hotfix for 1.8.3 you sent
> earlier today) at this point.  It wants to remove the code added by
> the hotfix but I do not see a corresponding check for listable,
> which may make sense, as the log message says, when the user
> specified a list of branches:
>
>     If the user specified a list of branches, we ignore what the remote
>     repository lists, and simply use the branches directly. Since some
>     remotes don't report the branches correctly, this is useful.
>
> but it is unclear if the listable code needs to go somewhere else
> when the user didn't.
>
> I'll stop at 6/8 for now, as this is not urgent before the 1.8.3
> release.

I can send the conflict fix, or I can send a v2 of the 47-something
patches. I already have a few fixes on top that might make sense to
squash. Up to you.

-- 
Felipe Contreras
