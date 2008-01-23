From: David Mansfield <david@cobite.com>
Subject: newbie branch repo migration question
Date: Wed, 23 Jan 2008 11:03:53 -0500
Organization: Cobite
Message-ID: <1201104233.3001.123.camel@gandalf.cobite.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 17:36:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHiZy-0006sw-J8
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 17:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbYAWQf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 11:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752775AbYAWQf0
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 11:35:26 -0500
Received: from 208.36.103.2.ptr.us.xo.net ([208.36.103.2]:52149 "EHLO
	iris.cobite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752258AbYAWQfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 11:35:25 -0500
X-Greylist: delayed 1879 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jan 2008 11:35:25 EST
Received: from localhost (iris.cobite.com [127.0.0.1])
	by iris.cobite.com (Postfix) with ESMTP id B944F53703
	for <git@vger.kernel.org>; Wed, 23 Jan 2008 11:04:00 -0500 (EST)
X-Virus-Scanned: amavisd-new at cobite.com
Received: from iris.cobite.com ([127.0.0.1])
	by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tAr2+rW9+9qh for <git@vger.kernel.org>;
	Wed, 23 Jan 2008 11:03:54 -0500 (EST)
Received: from [208.222.80.105] (208.36.103.2.ptr.us.xo.net [208.36.103.2])
	by iris.cobite.com (Postfix) with ESMTP id 1943653631
	for <git@vger.kernel.org>; Wed, 23 Jan 2008 11:03:54 -0500 (EST)
X-Mailer: Evolution 2.12.2 (2.12.2-3.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71553>

Hi,

Suppose I have a local repo with a branch, 'master'.  And I create a
branch based on it called, 'topic1'.  And I work and commit etc., make
changes on 'master' and merge them back and forth etc.

Now I want to move the 'master' to a remote repository, but not
'topic1', and then I want to switch 'topic1' as a branch of the remote
'master' and not the local one.  In fact, I want to 'get rid' of master
locally (or, rather, have 'master' be a tracking branch of
remotes/foo/master).

How is this accomplished?

Thanks,
David
