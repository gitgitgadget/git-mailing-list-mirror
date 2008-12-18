From: the_jack <josip@yopmail.com>
Subject: Retrieving last tag of a working tree
Date: Thu, 18 Dec 2008 04:07:19 -0800 (PST)
Message-ID: <21071491.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 13:08:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDHgM-0001g8-6D
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 13:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbYLRMHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 07:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbYLRMHW
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 07:07:22 -0500
Received: from kuber.nabble.com ([216.139.236.158]:40328 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbYLRMHV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 07:07:21 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1LDHex-0002Lk-Su
	for git@vger.kernel.org; Thu, 18 Dec 2008 04:07:19 -0800
X-Nabble-From: josip@yopmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103455>


I'm using msys git on Windows XP for version tracking embedded design project
in C. I mostly work with GUIs (git-gui and qgit), I use bash only when I
have to.

I need to be able to access version from software. To do that, I use tags to
mark all released versions, and that version string is written to file
version.h (the file is not tracked) by pre-build command:

#define KDK_SOFTWARE_VERSION "0.72"

Precompiler assigns this string to a variable. At this moment, version.h is
filled by python script that calls "git-describe --tag HEAD" and parses the
output. This works, but it's not quite reliable. There has to be a better
way for getting the last tag of current working tree. If I checkout an
earlier tagged version (0.70), I would need to automatically get 0.70 inside
version.h

Can anyone shed any light on this?
-- 
View this message in context: http://www.nabble.com/Retrieving-last-tag-of-a-working-tree-tp21071491p21071491.html
Sent from the git mailing list archive at Nabble.com.
