From: "Lyons, Roy" <Roy.Lyons@cmegroup.com>
Subject: deletion of branch seems to modify tag as well?
Date: Wed, 5 Jun 2013 15:26:18 +0000
Message-ID: <58EAA08AF8232344ADDB2E31D4996BFD39F271BA@SMRPEXCHIDAG2.prod.ad.merc.chicago.cme.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 05 17:32:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkFhc-0006V1-S0
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 17:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756458Ab3FEPce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 11:32:34 -0400
Received: from hygiene1b.cmegroup.com ([164.109.139.151]:45097 "EHLO
	hygiene1b.cmegroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756423Ab3FEPcc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jun 2013 11:32:32 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jun 2013 11:32:32 EDT
X-SBRS-none: None
X-IronPort-AV: E=Sophos;i="4.87,807,1363150800"; 
   d="scan'208";a="14284237"
Received: from unknown (HELO SMRPEXCHIDAG1.prod.ad.merc.chicago.cme.com) ([192.168.12.62])
  by Hygiene1b.cmegroup.com with ESMTP; 05 Jun 2013 10:26:18 -0500
Received: from SMRPEXCHIDAG2.prod.ad.merc.chicago.cme.com
 ([fe80::d06:7f7a:9be4:af24]) by SMRPEXCHIDAG1.prod.ad.merc.chicago.cme.com
 ([fe80::a085:eae:f9c4:f17c%19]) with mapi id 14.02.0309.002; Wed, 5 Jun 2013
 10:26:18 -0500
Thread-Topic: deletion of branch seems to modify tag as well?
Thread-Index: AQHOYgEGfMPxR06mwk+XS6sOjmk3WA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.3.2.130206
x-originating-ip: [10.191.27.15]
Content-ID: <2CA161FD29CE7A478E19274730E554AF@cme.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226452>

$ git push origin :ABRANCHNAME
remote: Firing Pre - receive hook
remote:
remote:
remote: Firing Post receive hook
remote:
remote: Branch is ABRANCHNAME -- not creating Trigger file since this is not _int branch
remote: error: Trying to write ref refs/tags/ABRANCHNAME!SN-BL-20130605_100513_04363 with nonexistent object 0000000000000000000000000000000000000000
remote: fatal: refs/tags/ABRANCHNAME!SN-BL-20130605_100513_04363: cannot update the ref
To ssh://git@ourgitserver/repositoryname.git
- [deleted] ABRANCHNAME


I would not expect this behavior.  Is git attempting to modify the tags associated to the HEAD commit on the branch in addition to the branch?   If so, I would like to consider this a bug report...



Thanks,

Roy Lyons
