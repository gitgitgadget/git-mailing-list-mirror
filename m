From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Mon, 10 Jun 2013 00:06:15 -0500
Message-ID: <CAMP44s3p1atFz52-mKaKpZkLGp+Uoehc1ovTUQAN-raxWzWd8Q@mail.gmail.com>
References: <20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
	<CALkWK0mu2_9M5aTczcEkv37eLaAg5_mGDZ_W9nqQFoesB4wc3g@mail.gmail.com>
	<20130609180437.GB810@sigill.intra.peff.net>
	<CALkWK0kkhDOSSdF=E4PvO24hg++_FpP3YFaGRD3yq80XG0TRJA@mail.gmail.com>
	<20130609184553.GG810@sigill.intra.peff.net>
	<7vppvvnetw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 07:06:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UluJB-0001G3-Hu
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 07:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961Ab3FJFGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 01:06:17 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:40174 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab3FJFGR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 01:06:17 -0400
Received: by mail-la0-f43.google.com with SMTP id gw10so5341962lab.16
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 22:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FirER7Mj3Z9cLxbhzBo9xrDKaLpB0Nl1PMd8dsOnN9I=;
        b=prtpR0pHKvK8qSau2MmlYd9OBoHQMQxVJwt33ZCJ+31yKtwnuVc5S9lWAk5/stEobv
         bL1R9I/zDcmWZ6TUnImQQrO98jmvppWyn9IbMtDKucuKX1EyfixfBkkQemDTMMzUL5bW
         h/TbnTtKMTAY15m+wW9KuqWhoW0vTPHl7Ry1IKtER9oH44NxLLAt0iRGBlafSzS9nAIf
         bRTfab7JR3PTEmj9fAc3CAMRa/C5VQbjU3pRPYzKTu0hrb+bZPqQakxDVZBNqJIdtY9/
         igfmc1SIgHSChS80MRZT+lUnMrMUpxYwWON/McjG8d+zsdkQWrv/bF2abFRrLxm4Bre8
         Tl6A==
X-Received: by 10.152.5.7 with SMTP id o7mr679834lao.43.1370840775574; Sun, 09
 Jun 2013 22:06:15 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 22:06:15 -0700 (PDT)
In-Reply-To: <7vppvvnetw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227234>

On Sun, Jun 9, 2013 at 4:39 PM, Junio C Hamano <gitster@pobox.com> wrote:

> One example of killing the entire thread is when I see "This patch
> will not be applied" by Felipe in a thread started with his patch.
> I understand that it is his way to say "this patch is retracted"
> without having to explicitly say that he now understands that
> reviews showed why the patch was wrong or that he thanks the
> reviewer for enlightening him.

You are wrong. There's nothing wrong with the patch.

> The patch will come back, with corrections as necessary, if it has
> merit, so we do not lose anything of value anyway by discarding the
> thread.

Wrong again. It seems nobody is interested in improving 'git rebase',
specially not to reduce the number of forks, and use C code instead
(git cherry-pick). Instead, people want to complain about the number
of forks, but not lift a finger about it, not even to review patches.
Good luck getting them to actually do something about it.

But thanks for letting me know, I'm dropping right now this series of
perfectly good 36 patches that move us forward towards our ideal; more
C code, less script code, improves 'git cherry-pick', simplifies and
fixes 'git rebase', and makes it more consistent.

I thought you understood that code should speak, but apparently you don't.

-- 
Felipe Contreras
