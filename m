From: "Matt Seitz (matseitz)" <matseitz@cisco.com>
Subject: Re: Question re. git remote repository
Date: Wed, 16 Jan 2013 23:32:09 +0000
Message-ID: <A0DB01D693D8EF439496BC8B037A0AEF322098A4@xmb-rcd-x15.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "ishchis2@gmail.com" <ishchis2@gmail.com>,
	"david@lang.hm" <david@lang.hm>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:32:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvcTB-0002s4-SG
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 00:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757479Ab3APXcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 18:32:12 -0500
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:18961 "EHLO
	rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755275Ab3APXcL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2013 18:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1113; q=dns/txt; s=iport;
  t=1358379131; x=1359588731;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=srS47VcpDPLe502nGnw7B/ABHLf9NrV+47olE3S08iY=;
  b=muypUvu9/h1gty8yInb0G1BLWOv1DDwqE2TJ3lRoKk60aeNDUxsLN3mL
   r49fhlbCBNWMbvj8qe6z23lzWpfwfKzuMapMv/yIvd1mmqx/FXOCMO7gt
   iT7/kShrb/0uJFaEoN8oGQTASYwsZ3OuOUYPKNgzRxKLsGmNcsfnwYzXT
   I=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av4EALQ391CtJXG//2dsb2JhbABEvgAWc4IgAQQ6PxIBCCIUQiYBBA4FCBKHfgEMuSmQV2EDlyiPLYJ1giQ
X-IronPort-AV: E=Sophos;i="4.84,481,1355097600"; 
   d="scan'208";a="163490342"
Received: from rcdn-core2-4.cisco.com ([173.37.113.191])
  by rcdn-iport-7.cisco.com with ESMTP; 16 Jan 2013 23:32:10 +0000
Received: from xhc-rcd-x07.cisco.com (xhc-rcd-x07.cisco.com [173.37.183.81])
	by rcdn-core2-4.cisco.com (8.14.5/8.14.5) with ESMTP id r0GNWA3t016450
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 16 Jan 2013 23:32:10 GMT
Received: from xmb-rcd-x15.cisco.com ([169.254.5.248]) by
 xhc-rcd-x07.cisco.com ([173.37.183.81]) with mapi id 14.02.0318.004; Wed, 16
 Jan 2013 17:32:10 -0600
Thread-Topic: Question re. git remote repository
Thread-Index: Ac30QapFxgO7vxkcSpqZYTWiS/u7Tw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [171.71.137.42]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213825>

"David Lang" <david@lang.hm> wrote in message news:<alpine.DEB.2.02.1301161459060.21503@nftneq.ynat.uz>...
> But if you try to have one filesystem, with multiple people running git on their 
> machines against that shared filesystem, I would expect you to have all sorts of 
> problems.

What leads you to think you will have problems?

Why would there be more of a problem on a network file system as opposed to local file system that can be accessed by multiple users?

Linus seemed to think it should work:

http://permalink.gmane.org/gmane.comp.version-control.git/122670

And "git init" specifically has a "shared" option:

--shared[=(false|true|umask|group|all|world|everybody|0xxx)] 
Specify that the git repository is to be shared amongst several users. This allows users belonging to the same group to push into that repository. When specified, the config variable "core.sharedRepository" is set so that files and directories under $GIT_DIR are created with the requested permissions. When not specified, git will use permissions reported by umask(2). 
