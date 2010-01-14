From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: git-svn dcommit to multiple repositories
Date: Thu, 14 Jan 2010 18:26:29 +0100
Message-ID: <4B4F53C5.6040605@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 18:35:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVTbP-0004kG-JG
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 18:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757403Ab0ANRfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 12:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757374Ab0ANRfO
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 12:35:14 -0500
Received: from syntevo.com ([85.214.39.145]:49438 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757337Ab0ANRfN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 12:35:13 -0500
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jan 2010 12:35:13 EST
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTPSA id DCA3F608085
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137005>

AFAIU from git-svn.perl for dcommit, the repository to commit to can't
be specified. Instead dcommit automatically detects UUID and URL by
analyzing the log. This works only as long as the corresponding git
branches do not intersect. Doesn't it make sense to have --svn-remote
working for dcommit, too?

--
Best regards,
Marc Strapetz
=============
syntevo GmbH
http://www.syntevo.com
http://blog.syntevo.com
