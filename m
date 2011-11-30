From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Auto update submodules after merge and reset
Date: Tue, 29 Nov 2011 16:55:09 -0800
Message-ID: <4ED57EED.4040705@qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 30 01:55:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVYSN-0007YS-GP
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 01:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756823Ab1K3AzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 19:55:22 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:47616 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269Ab1K3AzV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 19:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qualcomm.com; i=maxk@qualcomm.com; q=dns/txt;
  s=qcdkim; t=1322614521; x=1354150521;
  h=message-id:date:from:user-agent:mime-version:to:subject:
   content-type:content-transfer-encoding:x-originating-ip;
  z=Message-ID:=20<4ED57EED.4040705@qualcomm.com>|Date:=20Tu
   e,=2029=20Nov=202011=2016:55:09=20-0800|From:=20Max=20Kra
   snyansky=20<maxk@qualcomm.com>|User-Agent:=20Mozilla/5.0
   =20(X11=3B=20Linux=20x86_64=3B=20rv:8.0)=20Gecko/20111124
   =20Thunderbird/8.0|MIME-Version:=201.0|To:=20<git@vger.ke
   rnel.org>|Subject:=20Auto=20update=20submodules=20after
   =20merge=20and=20reset|Content-Type:=20text/plain=3B=20ch
   arset=3D"ISO-8859-1"=3B=20format=3Dflowed
   |Content-Transfer-Encoding:=207bit|X-Originating-IP:=20[1
   72.30.48.1];
  bh=P0BqxUfLI3B9Y+0rc6Dy+DpvbPon7JhuZKW29J2e9sE=;
  b=g7cdjVkdsawLi09nk8Kssp2PMQCLd4B9G6cO 
X-IronPort-AV: E=McAfee;i="5400,1158,6545"; a="142085620"
Received: from ironmsg04-r.qualcomm.com ([172.30.46.18])
  by wolverine01.qualcomm.com with ESMTP; 29 Nov 2011 16:55:20 -0800
X-IronPort-AV: E=Sophos;i="4.69,591,1315206000"; 
   d="scan'208";a="208855767"
Received: from nasanexhc05.na.qualcomm.com ([172.30.48.2])
  by Ironmsg04-R.qualcomm.com with ESMTP/TLS/AES128-SHA; 29 Nov 2011 16:55:20 -0800
Received: from [10.50.16.20] (172.30.48.1) by qcmail1.qualcomm.com
 (172.30.48.2) with Microsoft SMTP Server (TLS) id 14.1.339.1; Tue, 29 Nov
 2011 16:55:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111124 Thunderbird/8.0
X-Originating-IP: [172.30.48.1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186097>

Does anyone have a pointer to a thread/discussion that explains why git 
submodules are not auto
updated when the superproject is updated (merge, reset, etc) by default?

Assuming a simple and default setup where submodule update policy is set 
to "checkout".
It seems that the default and sane behavior should be to update 
(checkout) corresponding submodule
commit to track the superproject.
I can't seem to find convincing explanation why it's not the case :). 
Having to manually update
submodules after pull or reset has been error prone and confusing for 
the devs I work with.

I'm thinking about adding a config option that would enable automatic 
submodule update but wanted
to see if there is some fundamental reason why it would not be accepted.

Thanx
Max
