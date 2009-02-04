From: oliverw <oliver@weichhold.com>
Subject: GIT over ssh with identity file
Date: Wed, 4 Feb 2009 00:37:18 -0800 (PST)
Message-ID: <21826348.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 09:39:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUdHX-0008Lw-QN
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 09:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbZBDIhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 03:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbZBDIhV
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 03:37:21 -0500
Received: from kuber.nabble.com ([216.139.236.158]:54442 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbZBDIhT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 03:37:19 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1LUdG2-0004Zy-JG
	for git@vger.kernel.org; Wed, 04 Feb 2009 00:37:18 -0800
X-Nabble-From: oliver@weichhold.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108310>


Forgive me if this has been answered before. I've searched everywhere but
couldn't find a solution.

Is it somehow possible to pass your private key file to git when working
over ssh. What I have in mind would be something like this:

git -i /path/to/private/key clone ssh://homer@foo.bar.com/var/git/repos.git 

Since I want to use this on a server I would like to avoid using a password
caching agent at all cost.

-- 
View this message in context: http://www.nabble.com/GIT-over-ssh-with-identity-file-tp21826348p21826348.html
Sent from the git mailing list archive at Nabble.com.
