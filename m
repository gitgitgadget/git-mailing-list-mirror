From: Andy Neitzke <neitzke@ias.edu>
Subject: "git log -5 --follow" returns too few commits
Date: Tue, 17 Jun 2008 07:21:23 -0400
Message-ID: <200806170721.23950.neitzke@ias.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 13:51:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8ZiF-0005eI-Nn
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 13:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371AbYFQLuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 07:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755359AbYFQLuF
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 07:50:05 -0400
Received: from smtp2.ias.edu ([192.16.204.102]:59749 "EHLO smtp2.ias.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755272AbYFQLuE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 07:50:04 -0400
X-Greylist: delayed 1655 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Jun 2008 07:50:04 EDT
X-IAS: Institute for Advanced Study
Received: from pps2 (pps2.ias.edu [172.16.12.132])
	by smtp2.ias.edu (8.13.4/8.13.4) with ESMTP id m5HBMNMp014636
	for <git@vger.kernel.org>; Tue, 17 Jun 2008 07:22:27 -0400 (EDT)
Received: from iris.sns.ias.edu (iris.sns.ias.edu [172.16.17.15])
	by pps2.ias.edu (8.14.1/8.14.1) with ESMTP id m5HBMMJF027970
	for <git@vger.kernel.org>; Tue, 17 Jun 2008 07:22:22 -0400
X-SNS: School of Natural Sciences
Received: from [192.168.11.3] ([157.82.237.102])
	(authenticated bits=0)
	by iris.sns.ias.edu (8.13.1/8.13.1) with ESMTP id m5HBMIIx021218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 17 Jun 2008 07:22:22 -0400
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7160:2.4.4,1.2.40,4.0.166 definitions=2008-06-17_03:2008-06-16,2008-06-17,2008-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0805090000 definitions=main-0806170040
X-IAS-PPS-SPAM: NO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85293>

Hi,

Using either git 1.5.5.4 or the current master, on my system the command

git log -5 --follow some-file

often returns fewer than 5 commits, even when

git log --follow some-file

returns more than 5.  This behavior occurs even for some files which have 
never been renamed.  Is this a bug, or is this the expected behavior for some 
reason?

Best wishes and thanks,

-Andy
