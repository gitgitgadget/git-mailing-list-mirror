From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: [BUGLET] Makefile uses $(SCRIPT_PERL) but Documentation/Makefile uses "perl"
Date: Sun, 25 Nov 2007 12:39:49 -0800
Message-ID: <863auuoy96.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 25 21:40:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwOGv-0000Cz-Rq
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 21:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757346AbXKYUjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 15:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757036AbXKYUjv
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 15:39:51 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:14467 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757328AbXKYUju (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 15:39:50 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id B42F41DE380; Sun, 25 Nov 2007 12:39:49 -0800 (PST)
x-mayan-date: Long count = 12.19.14.15.7; tzolkin = 10 Manik; haab = 15 Ceh
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65991>


On my system, that means the two Makefiles actually use two different
Perl installations.  It'd be best if someone who is smarter at Makefiles
than I am would make them work the same.  Thanks.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
