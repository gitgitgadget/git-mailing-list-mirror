From: Florian Lindner <mailinglists@xgm.de>
Subject: GitHub Pull Request merge commands
Date: Tue, 16 Jun 2015 10:55:07 +0200
Message-ID: <mloo9l$agl$6@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 11:20:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4n2Y-0007s6-WC
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 11:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932880AbbFPJUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 05:20:15 -0400
Received: from plane.gmane.org ([80.91.229.3]:43674 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933740AbbFPJUG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 05:20:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Z4n2K-0007jv-FD
	for git@vger.kernel.org; Tue, 16 Jun 2015 11:20:04 +0200
Received: from lapsgs09.informatik.uni-stuttgart.de ([129.69.213.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 11:20:04 +0200
Received: from mailinglists by lapsgs09.informatik.uni-stuttgart.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 11:20:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: lapsgs09.informatik.uni-stuttgart.de
User-Agent: KNode/4.14.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271742>

Hello,

GitHub proposes these commands to merge a pull requests (explanations from 
me, to make sure I got it correctly)

# Basically branch develop to davidsblom-develop
git checkout -b davidsblom-develop develop

# Pull in foreign repos commits from foreign develop branch.
git pull git://github.com/davidsblom/precice.git develop

# Edit and merge the changes to the main repos develop branch
git checkout develop
git merge --no-ff davidsblom-develop
git push origin develop

My question is, if davidsblom make further commits to his develop branch 
(after the pull request was issued) aren't these commits also included in 
the pull and therefore in the merge? If yes, isn't the idea to merge just 
the changes that the pull request was about? If not, why? ;-)

Thanks,
Florian
