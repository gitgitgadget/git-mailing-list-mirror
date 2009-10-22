From: Sebastian Pipping <webmaster@hartwork.org>
Subject: make info failing with asciidoc 8.4.5? (git 1.6.5.1)
Date: Thu, 22 Oct 2009 21:11:10 +0200
Message-ID: <4AE0AE4E.4000006@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 21:11:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N134B-0000V6-Qz
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 21:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031AbZJVTLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 15:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755639AbZJVTLJ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 15:11:09 -0400
Received: from smtprelay09.ispgateway.de ([80.67.29.23]:45437 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbZJVTLI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 15:11:08 -0400
Received: from [85.179.158.133] (helo=[192.168.0.3])
	by smtprelay09.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1N1361-0001on-Rd
	for git@vger.kernel.org; Thu, 22 Oct 2009 21:13:13 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20091018)
X-Df-Sender: 874396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131043>

While asciidoc 8.2.6 works fine for me, with version 8.4.5 I get errors
like this from make info:


ASCIIDOC user-manual.xml
WARNING: [colophon] missing specialsections section
WARNING: [dedication] missing specialsections section
WARNING: [bibliography] missing specialsections section
WARNING: [appendix] missing specialsections section
WARNING: [preface] missing specialsections section
WARNING: [glossary] missing specialsections section
WARNING: [index] missing specialsections section
FAILED: [listdef-bulleted] missing section: [listtags-None]
make: *** [user-manual.xml] Error 1


Thought you might want to know.



Sebastian
