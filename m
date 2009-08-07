From: Edke <edke.kraken@gmail.com>
Subject: problems setting gitattribute ident for a whole directory
Date: Fri, 7 Aug 2009 08:21:22 -0700 (PDT)
Message-ID: <24866724.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 07 17:21:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZRG9-0003Dd-NB
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 17:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576AbZHGPVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 11:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753535AbZHGPVW
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 11:21:22 -0400
Received: from kuber.nabble.com ([216.139.236.158]:55363 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbZHGPVV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 11:21:21 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1MZRFy-0003ga-5Z
	for git@vger.kernel.org; Fri, 07 Aug 2009 08:21:22 -0700
X-Nabble-From: edke.kraken@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125202>


Hello. 

I'm moving from SVN to Git, started just two days ago. I'm amazed with Git
so far, also using it with SVN solid.

I'm having few difficulties setting ident attribute:

1) Setting it for a whole directory. I tried .git/info/attributes,
.gitattributes in root of my project, I tried some patterns ( app/*, app/,
app* ), nothing work so far. Using app/* works for files placed in app
folder but I need to apply this attribute for a whole directory
(recursively). 

2) If applied correctly, will it work with files that already exists in
project ? 

3) What I need to do so that changes (replacing $Id$ with hash) will show in
all affected files ? I found some tutorial, where author applies this as rm
file; git checkout -- file. But how should I proceed for a whole project ? 
-- 
View this message in context: http://www.nabble.com/problems-setting-gitattribute-ident-for-a-whole-directory-tp24866724p24866724.html
Sent from the git mailing list archive at Nabble.com.
