From: "Michael J. Cohen" <michaeljosephcohen@mac.com>
Subject: git-svn fetch doesn't like spaces in branch names
Date: Wed, 7 Nov 2007 19:14:22 -0500
Message-ID: <654A4D1D-712F-4978-9812-E8FA411FAE0D@mac.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 01:15:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipv30-0004gM-Na
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 01:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbXKHAO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 19:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759499AbXKHAO0
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 19:14:26 -0500
Received: from smtpoutm.mac.com ([17.148.16.72]:65489 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759479AbXKHAOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 19:14:25 -0500
Received: from mac.com (asmtp009-s [10.150.69.72])
	by smtpoutm.mac.com (Xserve/smtpout009/MantshX 4.0) with ESMTP id lA80EOBg007287
	for <git@vger.kernel.org>; Wed, 7 Nov 2007 16:14:24 -0800 (PST)
Received: from ubuntu.ho (72-17-187-154.ftl.fdn.com [72.17.187.154])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp009/MantshX 4.0) with ESMTP id lA80EMY7027055
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Wed, 7 Nov 2007 16:14:23 -0800 (PST)
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63907>

mini:TextMateBundles mjc$ git-svn fetch
Found possible branch point: http://macromates.com/svn/Bundles/trunk/Tools/Dialog 
  PlugIn => http://macromates.com/svn/Bundles/branches/Dialog PlugIn  
Completion Menu, 8089
Initializing parent: Dialog PlugIn Completion Menu@8089
Bad URL passed to RA layer: Malformed URL for repository at /opt/local/ 
bin/git-svn line 1607

looks like that might need to be %20 ?

-mjc
