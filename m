From: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Subject: git-gc --prune interferes cogito?
Date: Wed, 17 Oct 2007 16:43:27 +0200
Message-ID: <1IiA7L-1AWmmW0@fwd35.aul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 17:13:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiAaU-000241-PL
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 17:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757228AbXJQPNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 11:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758637AbXJQPNY
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 11:13:24 -0400
Received: from mailout05.sul.t-online.de ([194.25.134.82]:36949 "EHLO
	mailout05.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757121AbXJQPNX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2007 11:13:23 -0400
X-Greylist: delayed 1780 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Oct 2007 11:13:23 EDT
Received: from fwd35.aul.t-online.de 
	by mailout05.sul.t-online.com with smtp 
	id 1IiA7a-0000oB-03; Wed, 17 Oct 2007 16:43:42 +0200
Received: from localhost (X7ICnQZlYhTTPIPpIiBsmpWV13TAeo5nkOtXHVk-ZTB4p2vFzEzMyUgeoFqGcuxZe2@[172.20.101.250]) by fwd35.aul.t-online.de
	with esmtp id 1IiA7L-1AWmmW0; Wed, 17 Oct 2007 16:43:27 +0200
X-UMS: email
X-Mailer: TOI Kommunikationscenter V9-0-8
X-ID: X7ICnQZlYhTTPIPpIiBsmpWV13TAeo5nkOtXHVk-ZTB4p2vFzEzMyUgeoFqGcuxZe2@t-dialin.net
X-TOI-MSGID: 5e5ade02-6819-40a1-9592-752e53e3c984
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61381>

Hi,

I'm using git-1.5.3.2 and cogito-0.18.1.

After I did a git-gc --prune cg-status didn't show my branches anymore.
git-branch -a still showed the branches.
I think that git-gc removed all files from .git/refs/heads/ except for
origin. Git seams to be fine with the branches in 
 .git/logs/refs/heads/. 

So should git-gc not be used together with cogito?

Cheers,
Michael
