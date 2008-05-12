From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v2 0/24] Implementation of a file tree iteration using ignore rules.
Date: Mon, 12 May 2008 22:13:18 +0200
Message-ID: <1210623222-24908-1-git-send-email-florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 22:21:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvePs-0006Zz-3Y
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbYELUNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754161AbYELUNp
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:13:45 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40102 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbYELUNm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:13:42 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id D4408DECFCE9
	for <git@vger.kernel.org>; Mon, 12 May 2008 22:13:40 +0200 (CEST)
Received: from [84.150.98.143] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JveOy-00016x-00
	for git@vger.kernel.org; Mon, 12 May 2008 22:13:40 +0200
X-Mailer: git-send-email 1.5.5.1
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1/imlVUIjjx0/vmQRtYQ3N4NBp5bzytZ3/hg+xa
	7fA7CwRGlcDE9drTg/skX76IFgy9UOsl2qMgxhbO5MZKW4SA1j
	+gg9Vlfull+07ZnMagVA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81918>


Hi

I improved the patches from last time.

That are the changes to the previos patches:
* Removed @author javadoc
* Moved iteration code into the treewalk package
* Moved code around the Rules class into a new treewalk.rules package
* Added newlines to some files
* Removed (hopefully) the trailing whitespaces using the eclipse save actions.
* Renamed Project into WorkTree
* Moved the methods from ProjectSeeker and ProjectFactory into Repository and made them static.
* Moved the constants into the Constants class.
* Renamed my FileTreeIterator into LightFileTreeIterator in order to avoid nameconflict, as they are now in th
e same package.
* Renamed StarPattern into FNMatchPattern, improved it, and moved it into the lib package.
* Improved the javadoc.
* Replaced the AddCommandFileIterableFactory with a AddRulesFactory which creates Rules instances instead of Iterators. The advantage of this move is that the factory is now iterator independent.

Maybe I missed something... I would need some patch-tree version control system which tracks changes in the patch tree ;).

Best regards,
Florian
