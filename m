From: Drew Northup <drew.northup@maine.edu>
Subject: [RFD] Gitweb: Source configuration from file separate from the CGI
	script
Date: Wed, 16 Mar 2011 10:26:22 -0400
Message-ID: <1300285582.28805.25.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 15:26:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzrgb-00022d-Rl
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 15:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107Ab1CPO0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 10:26:49 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:43643 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936Ab1CPO0r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 10:26:47 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p2GEQQu4018405
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 16 Mar 2011 10:26:31 -0400
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=1
	Fuz1=1 Fuz2=1
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p2GEQQu4018405
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1300890396.17724@29hlSZlf+rVBT2hS4lS8rg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169156>

I just upgraded my Gitweb package (I'm testing the EPEL RHEL5 latest;
I'm not too happy with them tweaking the paths) and as I should have
expected all of my Gitweb configuration is now gone. Not that it's a big
deal to put it back, but we should probably give the option of keeping
that configuration information separate from the executable in my
opinion.
Anybody else want to speak up with respect to this? I have some idea
what a prospective patch would look like, but I'd like to hear from
people before putting it together (and to let it solidify in my head for
a while first as well).

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
