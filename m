From: Simon C <simonchu.web@gmail.com>
Subject: How to push changes from clone back to master
Date: Fri, 8 Jan 2010 13:28:07 -0800 (PST)
Message-ID: <1262986087967-4275010.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 22:28:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTMNU-0007y1-8w
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 22:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131Ab0AHV2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 16:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754095Ab0AHV2K
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 16:28:10 -0500
Received: from kuber.nabble.com ([216.139.236.158]:38934 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975Ab0AHV2I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 16:28:08 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1NTMNL-0002D8-VS
	for git@vger.kernel.org; Fri, 08 Jan 2010 13:28:07 -0800
X-Nabble-From: Simon C <simonchu.web@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136479>



I created master branch in git:

mkdir git_master;
cd git_master
git init
git add .
git commit

create a clone
git clone . ../git_clone1
create newfile
git add newfile
git commit .

then try to propagate changes to master
git push

it gave me some warning, and subsequent git push says everything is up to
date.
but I do not see the new file under git_master
-- 
View this message in context: http://n2.nabble.com/How-to-push-changes-from-clone-back-to-master-tp4275010p4275010.html
Sent from the git mailing list archive at Nabble.com.
