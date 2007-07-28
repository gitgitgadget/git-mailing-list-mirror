From: Seth Falcon <sfalcon@fhcrc.org>
Subject: suggestion for git rebase -i
Date: Fri, 27 Jul 2007 21:58:20 -0700
Message-ID: <m26445t98z.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 07:31:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEetj-0004t7-4P
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 07:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbXG1FbN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 01:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbXG1FbN
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 01:31:13 -0400
Received: from MAZZITE.FHCRC.ORG ([140.107.152.11]:51908 "EHLO
	mazzite.fhcrc.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbXG1FbM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 01:31:12 -0400
X-Greylist: delayed 1888 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Jul 2007 01:31:12 EDT
Received: from jarlite.fhcrc.org (JARLITE.FHCRC.ORG [140.107.42.11])
	by mazzite.fhcrc.org (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id l6S4xhNS028919
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 27 Jul 2007 21:59:43 -0700
Received: from jade.fhcrc.org (JADE.FHCRC.ORG [140.107.42.223])
	by jarlite.fhcrc.org (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id l6S4wM64030819
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 27 Jul 2007 21:58:22 -0700
Received: from ziti.fhcrc.org (DORMOUSE.FHCRC.ORG [140.107.170.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jade.fhcrc.org (Postfix) with ESMTP id E08A5B3DD
	for <git@vger.kernel.org>; Fri, 27 Jul 2007 21:58:21 -0700 (PDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (darwin)
X-PMX-Version: 5.3.2.304607, Antispam-Engine: 2.5.1.298604, Antispam-Data: 2007.7.27.213535
X-PMX-Version: 5.3.2.304607, Antispam-Engine: 2.5.1.298604, Antispam-Data: 2007.7.27.213535
X-FHCRC-SCANNED: Fri Jul 27 21:58:22 2007
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53994>

The tempfile used by git rebase -i is called "todo".  For those using
something like emacsclient, this is a bit too generic for the name of
a file in a pre-existing editor session.  I realize this is a small
nit, but how about renaming the file to "git-rebase-todo"?

+ seth

-- 
Seth Falcon | Computational Biology | Fred Hutchinson Cancer Research Center
BioC: http://bioconductor.org/
Blog: http://userprimary.net/user/
