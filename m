From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Recursive remove
Date: Fri, 13 Jan 2006 14:21:19 +0100
Message-ID: <20060113132119.GB23655@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jan 13 13:37:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExOB2-0000qZ-Lk
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 13:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422644AbWAMMhF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 07:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422650AbWAMMhE
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 07:37:04 -0500
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:38884 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S1422648AbWAMMhC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 07:37:02 -0500
Received: (qmail 23727 invoked by uid 5842); 13 Jan 2006 13:21:19 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14625>

Hello,

A way to recursively remove a directory /Some/Dir/ is a follows:

   git ls-files -z Some/Dir >rmfiles
   git update-index -z --force-remove --stdin <rmfiles
   git commit -a -m "Remove directory Some/Dir"
   rm -rf Some/Dir

What is a better way to do it?

Regards,

Peter
