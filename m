From: worley@alum.mit.edu (Dale R. Worley)
Subject: Apparent bug in git-gc
Date: Mon, 15 Sep 2014 19:34:03 -0400
Message-ID: <201409152334.s8FNY33M032615@hobgoblin.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 01:34:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTfmd-0004v7-SP
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 01:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755640AbaIOXeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 19:34:07 -0400
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:32820
	"EHLO qmta02.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754475AbaIOXeG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Sep 2014 19:34:06 -0400
Received: from omta14.westchester.pa.mail.comcast.net ([76.96.62.60])
	by qmta02.westchester.pa.mail.comcast.net with comcast
	id raq51o0021HzFnQ51ba4PQ; Mon, 15 Sep 2014 23:34:04 +0000
Received: from hobgoblin.ariadne.com ([24.34.72.61])
	by omta14.westchester.pa.mail.comcast.net with comcast
	id rba31o00W1KKtkw3aba430; Mon, 15 Sep 2014 23:34:04 +0000
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.7/8.14.7) with ESMTP id s8FNY3H3032616
	for <git@vger.kernel.org>; Mon, 15 Sep 2014 19:34:03 -0400
Received: (from worley@localhost)
	by hobgoblin.ariadne.com (8.14.7/8.14.7/Submit) id s8FNY33M032615;
	Mon, 15 Sep 2014 19:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1410824044;
	bh=1NAj8m1DVYca489GUqnke+d/8rmZnYHdE2qFt9/BN6o=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=MpRhqFQmiTkueM8wShAjKQJYmfsdRh/8z+S0HtZVWVRlGHZbqCxC2V38SwLPLmYVU
	 hpwJKZCAC+bgei7TzoenlukaRtdIYQ3M6To5AEjd5BUC7luacAz2XvTQIKrOfSjEsj
	 TCeLQLEnNKSTgJRmFqSWkPC/yN5rwIJ52zcb4hhoztuUyL8iaKP4hFAX5XKdJqNZ8n
	 WneXsFPMHrc3OyQlfVm0XAAHwkM5Bvgjo5YspQVG9Whj67bmqC2UiFha3Pg5126eqE
	 qAE1P7sqCFVAZLjyd9jejiWZxrO0pU6MI/8GAyP2aktEqjj+Iwur10Ke1xPqZbCCs8
	 6KkpJMoo4me8w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257116>

I have an unpleasant bug in git-gc:

Git version:  1.8.3.1
Running on:  Fedora 19 Gnu/Linux

I have an 11 GB repository.  It passes git-fsck (though with a number
of dangling objects).  But when I run git-gc on it, the file
refs/heads/master disappears.  Since HEAD points to refs/heads/master,
this makes the repository unusable.

What should I do next?

Dale
