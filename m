From: Tim Ansell <mithro@mithis.com>
Subject: Git and Media repositories....
Date: Sun, 02 Nov 2008 11:50:28 -0800
Message-ID: <1225655428.11693.10.camel@vaio>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 02 21:26:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwjWr-0004DH-DR
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 21:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbYKBUZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 15:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754102AbYKBUZT
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 15:25:19 -0500
Received: from lester.mithis.com ([69.60.120.93]:36265 "EHLO lester.mithis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754068AbYKBUZS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 15:25:18 -0500
X-Greylist: delayed 2086 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Nov 2008 15:25:18 EST
Received: from [192.168.1.2] (c-24-6-172-246.hsd1.ca.comcast.net [24.6.172.246])
	by lester.mithis.com (Postfix) with ESMTP id CFEA5B28E
	for <git@vger.kernel.org>; Sun,  2 Nov 2008 14:50:30 -0500 (EST)
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99873>

Hey guys,

Last week at the gittogether I lead some discussions about how we could
make Git better support large media repositories (which is one area
where Subversion still make sense). It was suggested that I post to this
list to get a discussion going. 

The general idea is that we always clone the complete meta-data (tags,
commits and trees) and then only clone blobs when they are needed (using
something like alternates). This allows us to support shallow, narrow
and sparse checkouts while still being able to perform operations such
as committing and merging.

You can find a copy of the summary presentation at
 http://www.thousandparsec.net/~tim/media+git.pdf

I have started working on adapting git to check a remote http alternate
to provide a proof of concept.

I appreciate any help or suggestions.

Tim 'mithro' Ansell
