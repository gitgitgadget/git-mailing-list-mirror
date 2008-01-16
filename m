From: Petko Manolov <petkan@nucleusys.com>
Subject: git and binary files
Date: Wed, 16 Jan 2008 12:34:31 +0200 (EET)
Message-ID: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 11:45:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF5ld-0004qc-QL
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 11:45:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbYAPKoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 05:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbYAPKoe
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 05:44:34 -0500
Received: from n152-u15.cabletel.bg ([89.253.152.15]:55975 "EHLO
	zztop.nucleusys.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751307AbYAPKod (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 05:44:33 -0500
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jan 2008 05:44:33 EST
Received: from bender.nucleusys.com ([192.168.234.2])
	by zztop.nucleusys.com with esmtp (Exim 4.63)
	(envelope-from <petkan@nucleusys.com>)
	id 1JF5cT-0006qG-7N
	for git@vger.kernel.org; Wed, 16 Jan 2008 12:35:41 +0200
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70651>

 	Hello there,

I've searched the web for an answer, but i didn't find it and decided to 
take the risk of being yelled at.  And post it here.

Some of my projects require having binary files (firmware and other stuff) 
somewhere in the tree structure.  Unfortunately these files are big - 50MB 
and more.  After a couple of new versions arrive (and get committed) i end 
up with a repository way too big than necessary.

The nature of these binary files is such that i don't care neither about 
their history nor older versions.  Hence the question:  is there an easy 
way to tell git not to bother about the history of these particular files 
and keep the most recent version only?


cheers,
Petko
