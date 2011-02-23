From: Justin Mattock <justinmattock@gmail.com>
Subject: Re: gitk with the latest branch makes the system unusable for some time
Date: Wed, 23 Feb 2011 09:37:34 -0800
Message-ID: <2E3AD768-C697-4945-AAEA-9897709E011E@gmail.com>
References: <AANLkTim3MW0PmD5_tra4nmRapfgHJ9K_usJWGVK3AOUC@mail.gmail.com> <4D64EF70.9060600@drmicha.warpmail.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 23 18:37:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsIev-0007pE-N9
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 18:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430Ab1BWRhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 12:37:39 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48763 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460Ab1BWRhh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 12:37:37 -0500
Received: by pzk35 with SMTP id 35so480904pzk.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 09:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        bh=87W4gg7n9ZLICYNoPY3l0TikAEy+RKT/r5CvWWsuui0=;
        b=jj+iSRqp5bZ+MydqzcMmAO4zzHSchnHrFwwnafADmq0ASz29ltbdZARMSUqUUNldLI
         qTgWJI0diCX5tz4792TNH4G/kwwcBE2b0Pxcn4ykcG6o3pySeaGGPdZ3Y0lkwVmDUBZB
         HYii5yW5UxPaZ9r/YH5zIjRhp177LynmnzsVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=EjupgQyWB1B/eCgi+JLv3dkJ1HLBrXhWGnbUWk0Y0F3Um1RuQ/0/ct71jUT6u80HSh
         XTCoqYBoXQc4EO54HCSJJBDbzupfG6qbGlmBuyIgA8PVFiKbuHNOil2G8sEl3U5/9LLb
         Eb2kABVJ+VcKK2EN9qOerZHmU52EWf4offIIM=
Received: by 10.142.107.6 with SMTP id f6mr3437918wfc.142.1298482656913;
        Wed, 23 Feb 2011 09:37:36 -0800 (PST)
Received: from [172.29.71.32] (cpe-76-94-2-152.socal.res.rr.com [76.94.2.152])
        by mx.google.com with ESMTPS id 25sm11057414wfb.22.2011.02.23.09.37.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Feb 2011 09:37:35 -0800 (PST)
In-Reply-To: <4D64EF70.9060600@drmicha.warpmail.net>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167707>


On Feb 23, 2011, at 3:28 AM, Michael J Gruber wrote:

> Justin Mattock venit, vidit, dixit 23.02.2011 00:53:
>> not sure if there is any reports of this or not, basically using gitk
>> on my macbookpro2,2 makes the system extremely slow and unusable
>> (after a while can finally use the system)
>
> ..and "the latest branch" is master,next or pu from when?
>

latest Mainline 2.6.38-rc5

> Is that gitk on the (which) kernel repo?

the git version is 1.6.5.2.180.gc5b3e

>
> I have no trouble with gitk (today's next) on git.git (nor on the
> LibreOffice beast).
>

yeah over here its very slow

>> in dmesg I am seeing this:
>>
>> [ 6089.363045] NetworkManager invoked oom-killer: gfp_mask=0x84d0,
>> order=0, oom_adj=0, oom_score_adj=0
>> [ 6089.363050] Pid: 2107, comm: NetworkManager Not tainted
>> 2.6.38-rc5-00101-gebad2c2 #2
>> [ 6089.363052] Call Trace:
>> [ 6089.363062]  [<ffffffff810c563c>] ? T.547+0x6a/0x180
>> [ 6089.363066]  [<ffffffff810c5799>] ? T.544+0x47/0x24c
>> [ 6089.363070]  [<ffffffff810c5beb>] ? out_of_memory+0x24d/0x2f8
>> [ 6089.363074]  [<ffffffff810c9142>] ? __alloc_pages_nodemask+0x55c/ 
>> 0x696
>> [ 6089.363079]  [<ffffffff810dc985>] ? handle_pte_fault+0x2cd/0x73f
>> [ 6089.363084]  [<ffffffff8104e522>] ? pte_alloc_one+0x1e/0x3c
>> [ 6089.363088]  [<ffffffff810c8406>] ? __free_pages+0x1b/0x24
>> [ 6089.363091]  [<ffffffff810ddfc1>] ? __pte_alloc+0x1d/0xcd
>> [ 6089.363094]  [<ffffffff810de185>] ? handle_mm_fault+0x114/0x164
>> [ 6089.363099]  [<ffffffff8144973d>] ? do_page_fault+0x3dc/0x401
>> [ 6089.363104]  [<ffffffff81112eef>] ? mntput_no_expire+0x8d/0x13f
>> [ 6089.363108]  [<ffffffff81112fc2>] ? mntput+0x21/0x23
>> [ 6089.363112]  [<ffffffff810fb8dc>] ? fput+0x20e/0x21d
>> [ 6089.363116]  [<ffffffff81446a25>] ? page_fault+0x25/0x30
>
> So you think gitk took down your Networkmanager?
>
> Michael


yeah I was streaming music, then all hell broke loose..
maybe I should update git to the latest(didn't think to do so)

Justin P. Mattock
