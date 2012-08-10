From: Neeraj <neerajm@yahoo.com>
Subject: Re: Installing GIT Server
Date: Fri, 10 Aug 2012 14:27:15 -0400
Message-ID: <56EB230F-C97C-4EF2-9CFE-F962DC75372A@yahoo.com>
References: <41E7B95B-70F0-4DCD-ADCE-213BCE4B2FAC@YAHOO.COM> <CAM9Z-nkPU6YP6_hvwLNmnjDymWXVgyeVD+TBW3sLK8-+V26msg@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Andrew Keller <andrew@kellerfarm.com>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 20:33:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szu1Y-0004GB-9O
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 20:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758045Ab2HJSdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 14:33:23 -0400
Received: from nm23-vm0.bullet.mail.sp2.yahoo.com ([98.139.91.224]:21049 "EHLO
	nm23-vm0.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759544Ab2HJSdW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 14:33:22 -0400
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Aug 2012 14:33:22 EDT
Received: from [72.30.22.78] by nm23.bullet.mail.sp2.yahoo.com with NNFMP; 10 Aug 2012 18:27:21 -0000
Received: from [98.139.91.21] by tm12.bullet.mail.sp2.yahoo.com with NNFMP; 10 Aug 2012 18:27:21 -0000
Received: from [127.0.0.1] by omp1021.mail.sp2.yahoo.com with NNFMP; 10 Aug 2012 18:27:21 -0000
X-Yahoo-Newman-Id: 557685.65821.bm@omp1021.mail.sp2.yahoo.com
Received: (qmail 50972 invoked from network); 10 Aug 2012 18:27:20 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=DKIM-Signature:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:Received:References:In-Reply-To:Mime-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Cc:X-Mailer:From:Subject:Date:To;
  b=x/t7ZuoRLo3k6T6rWhCMyvBi7+MhOdT9IgWaqHY86XOX5Hq5hJZIN9W+R9SM0Rjm6eM0oFv2PPosSIw8+SpSNgCi/iKg1rJKiiXt7vZY9z0f0HUoDNuQx2mHofcknadXloW4uhf1AbkBY9JLWw6yJ39vtpn2GgehiqrV+H5wIMQ=  ;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1344623240; bh=zTuI1SmSFhhxnhkemU8Oc9UQ+fZL0rXfqEVTr7zx3V0=; h=X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:Received:References:In-Reply-To:Mime-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Cc:X-Mailer:From:Subject:Date:To; b=HCdpzBUYj7I1OEg7ZXzDwoVqGZthn4lNqkbcCVNsxse+CombYRfISQiJ94TFEwox5WJy2SLh/UN3SujIpeCEM7nPmyZ7NoVBlA8ZLkruUrSW27LyGi7C1SQQLJ7vvYcR+29pYmGeAAzFP8gQQpJlhydr8wiO/NNjIQfYQ7fpWNo=
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: mWZ0HaIVM1lMbNz5FTDtk4wcLt7P2vu8nNSEbEUyvHQNVaL
 aJwm3KVtPvrspjd95g_2zKae_cyreAEAtSlc2iIE7uzd2bHNU5Npw1rUKfvQ
 hMU_mW2M_Hx9JNZ9nkCy8ZBES_FBj5R3yWfAwnyLl9abX7PksMhP_o4_nRel
 kgcl68UOPhE0V8FgJdkcS2yTIL1Q_o8N3L4lCFInt6kxS3p93hHInIgwO5RQ
 ibAJmHyvKlwMeIwHBGqgg8l1NYVjRnaD839gQl56tHehGM8UTN7xtz.wSkox
 QFjVcHZH78q1nllBSO4epycR2ZaMeTWFTCNEd8jvd.gM1Yh14nRVaI9ZQczV
 ia4EhW.2ZRp.wAMNXfbFg7Sl4eBfXrZDK_WMQuX8ZarHsV8Uuz7JmGffGPG3
 DrPufsGjCB1Hfqvy8M9gn2yxO.r5nM1gHCCYDrhun5iraDsG4_h13snKJe1r
 cW5bmvLHdlXJeZT9HGdg6musbL.UsVRRTfuk8Sws_ti1hiU5uPH8fEPmhnYU
 Vs0TjR0d0j.7Akkw1
X-Yahoo-SMTP: 9h86oVqswBD1bcjl0kRC4YvPKUo-
Received: from [192.168.1.4] (neerajm@173.59.3.177 with xymcookie)
        by smtp103-mob.biz.mail.gq1.yahoo.com with SMTP; 10 Aug 2012 11:27:19 -0700 PDT
In-Reply-To: <CAM9Z-nkPU6YP6_hvwLNmnjDymWXVgyeVD+TBW3sLK8-+V26msg@mail.gmail.com>
X-Mailer: iPhone Mail (9B206)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203246>

Thanks Drew, I will look into this.

Neeraj Mathawan
610-213-0673

On Aug 10, 2012, at 1:57 PM, Drew Northup <n1xim.email@gmail.com> wrote:

> On Fri, Aug 10, 2012 at 11:17 AM, Neeraj Mathawan <NEERAJM@yahoo.com> wrote:
>> Hi,
>> We have decided to use GIT for a huge government implementation, I am looking for some help with installation of GIT SERVER.
>> 
>> Few questions:-
>> 
>> 1. What platform to choose - UNIX, MAC or Windows? We have lot of windows 2008 installations, and if there are no trade off's we would love to use Windows 2008 server and install the GIT server compoent there.
>> 
>> 2. Once that is done, the client machine mostly MAC OSX development machines...will they be able to connect using SSH or file share?
>> 
>> Can someone help me with this?
> 
> Raj,
> You may find that using Gitolite [1] (and following the documentation
> that comes with it) to be a good solution to what you are trying to
> do.
> 
> (1): https://github.com/sitaramc/gitolite/
> 
> -- 
> -Drew Northup
> --------------------------------------------------------------
> "As opposed to vegetable or mineral error?"
> -John Pescatore, SANS NewsBites Vol. 12 Num. 59
