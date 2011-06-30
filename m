From: Shantanu Pavgi <pavgi@uab.edu>
Subject: bringing changes from one repo to other
Date: Thu, 30 Jun 2011 12:36:10 -0500
Message-ID: <F750768F-DC8E-435E-813A-C89AE9B9D89A@uab.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 30 19:36:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcLA5-0001bp-Hv
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 19:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418Ab1F3RgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 13:36:17 -0400
Received: from uabexht1.ad.uab.edu ([138.26.5.101]:1711 "EHLO
	UABEXHT1.ad.uab.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979Ab1F3RgQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2011 13:36:16 -0400
Received: from UABEXMBS5.ad.uab.edu ([138.26.5.38]) by UABEXHT1.ad.uab.edu
 ([138.26.5.101]) with mapi; Thu, 30 Jun 2011 12:36:11 -0500
Thread-Topic: bringing changes from one repo to other
Thread-Index: Acw3TDOuuefadyAERSi2bVGyWh3aUg==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176494>


Hi,

I need to bring in changes from one git repository (say repo-A) to other(say repo-B) preferably preserving the commit history. The repo-A contains few initial bad-commit points - includes files that should have been ignored (e.g temporary files generated at runtime) and large number of files got committed in one go. Also, the repo-A and repo-B don't have any common commit point with common set of files. Is there any way to get commits from repo-A to repo-B? I tried git cherry-pick, but I am not able to preserve history after resolving conflicts.  Any comments or suggestions will be really helpful. 

Thanks,
Shantanu.
