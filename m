From: "Robertson, Bruce E" <bruce.e.robertson@intel.com>
Subject: RE: orphan blob or what?
Date: Fri, 9 Nov 2012 06:23:45 +0000
Message-ID: <83A029C68381A840ACDE22C814EE27492247BBB5@ORSMSX101.amr.corp.intel.com>
References: <87a9urlj23.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 07:24:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWi0X-0004qm-4g
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 07:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820Ab2KIGXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 01:23:48 -0500
Received: from mga03.intel.com ([143.182.124.21]:59966 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771Ab2KIGXr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2012 01:23:47 -0500
Received: from azsmga002.ch.intel.com ([10.2.17.35])
  by azsmga101.ch.intel.com with ESMTP; 08 Nov 2012 22:23:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,743,1344236400"; 
   d="scan'208";a="166257408"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by AZSMGA002.ch.intel.com with ESMTP; 08 Nov 2012 22:23:46 -0800
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.1.355.2; Thu, 8 Nov 2012 22:23:46 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.82]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.48]) with mapi id 14.01.0355.002;
 Thu, 8 Nov 2012 22:23:46 -0800
Thread-Topic: orphan blob or what?
Thread-Index: AQHNvhCa2yNfjOCL5k2vJl9bnpT1dZfhCMMA
In-Reply-To: <87a9urlj23.fsf@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.139]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209205>

Please excuse one inaccuracy: I did a 'git pull' not a clone. So it could be an old .idx file at my end possibly.

Thanks,
bruce

-----Original Message-----
From: Robertson, Bruce E 
Sent: Thursday, November 08, 2012 4:25 PM
To: git@vger.kernel.org
Subject: orphan blob or what?

In today's and older clones of https://github.com/mirrors/linux.git I find this object, 6fa98ea0ae40f9a38256f11e5dc270363f785aee, that I can't figure out how to eliminate^h^h^h^h^h^h^h^h^hget rid of. I don't see it in 'git fsck', 'git gc --aggressive --prune' doesn't seem to prune it, can't see it via 'git log'. And yet

linux/.git/objects/pack$ git verify-pack -v *.idx | grep 6fa98ea0ae40f9a38256f11e5dc270363f785aee
6fa98ea0ae40f9a38256f11e5dc270363f785aee blob   1519697 124840 515299673
8231eaa31ce1107c1463deb6ec33f61618aedbb9 blob   67 63 515424513 1 6fa98ea0ae40f9a38256f11e5dc270363f785aee
f21a8c1b9d47736fa4e27def66f04b9fe2b4bc53 blob   90 83 515424576 1 6fa98ea0ae40f9a38256f11e5dc270363f785aee

Thanks,
bruce
