From: Andrew Vit <andrew@avit.ca>
Subject: Files that want to delete themselves
Date: Wed, 24 Sep 2008 10:55:02 -0700 (PDT)
Message-ID: <19654453.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 19:56:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiYbH-00055h-BV
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 19:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbYIXRzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 13:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721AbYIXRzE
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 13:55:04 -0400
Received: from kuber.nabble.com ([216.139.236.158]:57905 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbYIXRzD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 13:55:03 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1KiYZq-0002wY-RR
	for git@vger.kernel.org; Wed, 24 Sep 2008 10:55:02 -0700
X-Nabble-From: andrew@avit.ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96671>


Hi,

I have a Rails project that I'm managing with git and I have a strange
problem with one of the plugin directories. Every time I do `git add .` it
tries to delete itself... Any idea what might be happening?


andrew$ git status
# On branch master
nothing to commit (working directory clean)

andrew$ git add .

andrew$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	new file:   vendor/plugins/restful_authentication
#	deleted:    vendor/plugins/restful_authentication/CHANGELOG
#	deleted:    vendor/plugins/restful_authentication/README.textile
#	deleted:    vendor/plugins/restful_authentication/Rakefile
#	deleted:    vendor/plugins/restful_authentication/TODO
# ...
# ...
# ...
#

-- 
View this message in context: http://www.nabble.com/Files-that-want-to-delete-themselves-tp19654453p19654453.html
Sent from the git mailing list archive at Nabble.com.
