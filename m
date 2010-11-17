From: Christoph Bartoschek <bartoschek@gmx.de>
Subject: Git-Svn-Bridge
Date: Wed, 17 Nov 2010 15:56:34 +0100
Organization: =?UTF-8?B?VW5pdmVyc2l0w6R0?= Bonn
Message-ID: <227dr7-3nl.ln1@burns.bruehl.pontohonk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 17 15:57:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIjRb-0001Be-CC
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 15:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419Ab0KQO5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 09:57:01 -0500
Received: from lo.gmane.org ([80.91.229.12]:52054 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932295Ab0KQO5A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 09:57:00 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PIjRT-000164-M3
	for git@vger.kernel.org; Wed, 17 Nov 2010 15:56:59 +0100
Received: from bg-1.or.uni-bonn.de ([131.220.141.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Nov 2010 15:56:59 +0100
Received: from bartoschek by bg-1.or.uni-bonn.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Nov 2010 15:56:59 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: bg-1.or.uni-bonn.de
User-Agent: KNode/4.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161617>

Hi,

we would like to use a Git-Svn-Bridge as it is described in Jon Loeliger's 
book. However there are some open questions:

We have the bridge repository and the bare repository created. 

a) Are the developers supposed to work on a branch that follows  master from 
the bare repository or on a branch that follows svn/trunk on the master? I 
assume they follow the master.

b) How do we get changes from the bare repository to the bridge repository? 
Should there be a new branch for the changes or should one use master from 
the bridge?

c) How do we get changes from subversion to the bare repository?

d) Are the changes from subversion applied to the bare repository master or 
only to the svn/* branches?


Thanks
Christoph
