From: Jeff Garzik <jeff@garzik.org>
Subject: Trouble importing from public CVS repo
Date: Fri, 04 Jan 2008 16:41:10 -0500
Message-ID: <477EA7F6.1010608@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthias Urlichs <smurf@smurf.noris.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 04 22:41:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAuIO-0001qW-EC
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 22:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbYADVlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 16:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753896AbYADVlO
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 16:41:14 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:49079 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753351AbYADVlN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 16:41:13 -0500
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.66 #1 (Red Hat Linux))
	id 1JAuHv-00067T-Rk; Fri, 04 Jan 2008 21:41:12 +0000
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69609>

I'm trying to convert this public repo into a git repository:

    :pserver:anonymous@cvs.lysator.liu.se:/cvsroot/unfs3

cvsps seems to produce a nice long list of patchesets for the "unfs3" 
module, and running

   cvs -d:pserver:anonymous@cvs.lysator.liu.se:/cvsroot/unfs3 co -P unfs3

works as expected.  However, running

   [jgarzik@core unfs3]$ git-cvsimport -v 
-d:pserver:anonymous@cvs.lysator.liu.se:/cvsroot/unfs3 unfs3

produces

Initialized empty Git repository in /spare/repo/unfs3/.git/
Running cvsps...
connect error: Network is unreachable
cvs rlog: Logging unfs3
cvs rlog: Logging unfs3/Config
cvs rlog: Logging unfs3/Extras
cvs rlog: Logging unfs3/contrib
cvs rlog: Logging unfs3/contrib/nfsotpclient
cvs rlog: Logging unfs3/contrib/nfsotpclient/mountclient
cvs rlog: Logging unfs3/contrib/rpcproxy
cvs rlog: Logging unfs3/doc
Fetching LICENSE   v 1.1
New LICENSE: 1416 bytes
Fetching Makefile.in   v 1.1
Unknown: error

This machines and package (git-cvs-1.5.3.3-3.fc7) work just fine with a 
large number of other CVS repositories [nice work].

	Jeff
