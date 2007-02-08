From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: broken git-fast-import.xml
Date: Thu, 08 Feb 2007 15:09:09 -0800
Message-ID: <864ppwtffu.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 00:09:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFIOC-0007zQ-GH
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 00:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422821AbXBHXJM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 18:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422921AbXBHXJM
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 18:09:12 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:23770 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422821AbXBHXJK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 18:09:10 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id E5BE91DED82; Thu,  8 Feb 2007 15:09:09 -0800 (PST)
x-mayan-date: Long count = 12.19.14.0.17; tzolkin = 6 Caban; haab = 10 Pax
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39117>


xmlto -m callouts.xsl man git-fast-import.xml
xmlto: input does not validate (status 1)
/Volumes/UFS/MIRROR/git-GIT/Documentation/git-fast-import.xml:527: parser error : Opening and ending tag mismatch: superscript line 527 and literal
<simpara>The <literal><superscript>0</literal> suffix is necessary as gfi does n
                                              ^
/Volumes/UFS/MIRROR/git-GIT/Documentation/git-fast-import.xml:529: parser error : Opening and ending tag mismatch: literal line 529 and superscript
m</literal> command is even read from the input.  Adding <literal></superscript>
                                                                               ^
make[1]: *** [git-fast-import.1] Error 1
rm git-fast-import.xml git-diff-stages.xml


-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
