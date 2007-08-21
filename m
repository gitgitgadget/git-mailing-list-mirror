From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: a475e8095aeb898c1ca60673b82df97d2300cc95 broken for docs
Date: Tue, 21 Aug 2007 10:51:35 -0700
Message-ID: <86odh0ojx4.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 19:51:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INXtD-0002Vq-1C
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 19:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761507AbXHURvg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 13:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761347AbXHURvg
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 13:51:36 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:36000 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761375AbXHURvf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 13:51:35 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 63AEE1DF079; Tue, 21 Aug 2007 10:51:35 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.10.11; tzolkin = 5 Chuen; haab = 19 Yaxkin
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56316>


xmlto -m callouts.xsl man git-rev-list.xml
xmlto: input does not validate (status 3)
/Volumes/UFS/MIRROR/git-GIT/Documentation/git-rev-list.xml:512: element literal: validity error : Element emphasis is not declared in literal list of possible children
/Volumes/UFS/MIRROR/git-GIT/Documentation/git-rev-list.xml:512: element literal: validity error : Element emphasis is not declared in literal list of possible children
/Volumes/UFS/MIRROR/git-GIT/Documentation/git-rev-list.xml:512: element literal: validity error : Element emphasis is not declared in literal list of possible children
Document /Volumes/UFS/MIRROR/git-GIT/Documentation/git-rev-list.xml does not validate
make[1]: *** [git-rev-list.1] Error 3
rm git-checkout.xml
make: *** [doc] Error 2


-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
