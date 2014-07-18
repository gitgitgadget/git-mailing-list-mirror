From: "Armbruster Joachim (BEG/EMS1)" <Joachim.Armbruster@de.bosch.com>
Subject: Why is git submodule slow under windows
Date: Fri, 18 Jul 2014 10:14:12 +0000
Message-ID: <18956e25b6c14091a64af5a65ce5d13c@FE-MBX1009.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 18 12:14:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X85Bi-0003c9-1w
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 12:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934564AbaGRKO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 06:14:29 -0400
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:43183 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934246AbaGRKO1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jul 2014 06:14:27 -0400
X-Greylist: delayed 3623 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Jul 2014 06:14:27 EDT
Received: from vsmta13.fe.internet.bosch.com (unknown [10.4.98.53])
	by imta23.fe.bosch.de (Postfix) with ESMTP id 0B7641580201
	for <git@vger.kernel.org>; Fri, 18 Jul 2014 12:14:26 +0200 (CEST)
Received: from localhost (vsgw21.fe.internet.bosch.com [10.4.98.19])
	by vsmta13.fe.internet.bosch.com (Postfix) with SMTP id DEFF1600572
	for <git@vger.kernel.org>; Fri, 18 Jul 2014 12:14:25 +0200 (CEST)
Received: from FE-MBX1010.de.bosch.com (10.3.230.68) by si-hub05.de.bosch.com
 (10.3.153.47) with Microsoft SMTP Server (TLS) id 8.3.348.2; Fri, 18 Jul 2014
 12:14:14 +0200
Received: from FE-MBX1009.de.bosch.com (10.3.230.67) by
 FE-MBX1010.de.bosch.com (10.3.230.68) with Microsoft SMTP Server (TLS) id
 15.0.847.32; Fri, 18 Jul 2014 12:14:12 +0200
Received: from FE-MBX1009.de.bosch.com ([fe80::4cbc:b233:78d1:f025]) by
 FE-MBX1009.de.bosch.com ([fe80::4cbc:b233:78d1:f025%22]) with mapi id
 15.00.0847.030; Fri, 18 Jul 2014 12:14:12 +0200
Thread-Topic: Why is git submodule slow under windows
Thread-Index: Ac+iaJhiIJ+XQI9uTIugm9Zpb4SA3wACFXxw
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.44.78.100]
X-TM-AS-MML: disable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253809>

Hello,

We split a monolithic repository into ~50 submodules. The stored data has the same size. In the 1:1 comparison to the monolithic repository, the submodule handling is very slow. Under Linux everything remains fast, but windows is slow.

So, why is git getting slow when it has to deal with a lot of submodules?
I read something about the lack of the underlying cygwin to handle NTFS in a efficient way. Is this the root cause, or are there other causes also?
