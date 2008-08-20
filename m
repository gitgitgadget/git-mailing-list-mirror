From: Rick Moynihan <rick@calicojack.co.uk>
Subject: managing git submodules with git-svn
Date: Wed, 20 Aug 2008 10:35:36 +0100
Message-ID: <48ABE568.80106@calicojack.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 14:38:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVmvM-0007xx-J9
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 14:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038AbYHTMfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 08:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753143AbYHTMfY
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 08:35:24 -0400
Received: from storm.bpweb.net ([83.223.106.8]:58049 "EHLO storm.bpweb.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752945AbYHTMfX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 08:35:23 -0400
X-Greylist: delayed 10775 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Aug 2008 08:35:23 EDT
Received: from lechuck.local (host-77-100-223-163.static.telewest.net [77.100.223.163])
	(authenticated bits=0)
	by storm.bpweb.net (8.13.1/8.13.1) with ESMTP id m7K9Zfoc024401
	for <git@vger.kernel.org>; Wed, 20 Aug 2008 10:35:47 +0100
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
X-BpTo: <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92983>

Hi all,

We are currently using a mixture of git and svn to manage a project with 
an array of subprojects.  We use git primarily for its excellent 
branching and merging support, and as a means of more effectively 
managing commits etc...  We're not yet ready to make the leap entirely 
to git and find subversion still has a role, primarily due to some 3rd 
party upstream (e.g. Apache) projects using svn.  SVN is also better 
supported by some of our tools/systems.

Our project is made up of a number of subprojects, and I'd like to use 
git submodules to easily track and lock changes in component versions. 
git submodules appear to do exactly this, versioning the meta-repo with 
each subproject locked at a specific commit/SHA-1.

My question is; is there anyway to easily do this but have git use 
git-svn manage the submodule?  I think this makes sense and suspect it 
would be possible to do, though it looks like it's currently not a 
feature.  Is this a feature anyone else would find useful?


Thanks again,

R.
