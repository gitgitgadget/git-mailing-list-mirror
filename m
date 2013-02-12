From: "Olsen, Alan R" <alan.r.olsen@intel.com>
Subject: Fetch and -t
Date: Tue, 12 Feb 2013 00:41:49 +0000
Message-ID: <4B2793BF110AAB47AB0EE7B9089703854FEE40B6@fmsmsx110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 12 01:42:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U53wt-0007gz-PR
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 01:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761087Ab3BLAlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 19:41:52 -0500
Received: from mga03.intel.com ([143.182.124.21]:55866 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760962Ab3BLAlv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2013 19:41:51 -0500
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 11 Feb 2013 16:41:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,646,1355126400"; 
   d="scan'208";a="255669042"
Received: from fmsmsx108.amr.corp.intel.com ([10.19.9.228])
  by azsmga001.ch.intel.com with ESMTP; 11 Feb 2013 16:41:50 -0800
Received: from fmsmsx153.amr.corp.intel.com (10.19.17.7) by
 FMSMSX108.amr.corp.intel.com (10.19.9.228) with Microsoft SMTP Server (TLS)
 id 14.1.355.2; Mon, 11 Feb 2013 16:41:49 -0800
Received: from FMSMSX110.amr.corp.intel.com ([169.254.12.199]) by
 FMSMSX153.amr.corp.intel.com ([169.254.11.105]) with mapi id 14.01.0355.002;
 Mon, 11 Feb 2013 16:41:49 -0800
Thread-Topic: Fetch and -t
Thread-Index: Ac4Iub3zTrxaYZv+T/CwQ9/5TEcQRA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.200.106]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216107>

I have found that if I add a remote and do a "git fetch -t -f remote_name" that it *only* pulls tags.

Reading the man page it seems like it should pull all the remotes and all the tags and the commits only reachable by tags.

Am I misreading this or it supposed to work this way.  I don't mind doing two fetches to get everything, but the documentation needs to be a little clearer.
