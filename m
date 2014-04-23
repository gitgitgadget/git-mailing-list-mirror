From: d9ba@mailtor.net
Subject: Harmful LESS flags
Date: Wed, 23 Apr 2014 23:46:02 -0000
Message-ID: <4dc69237123e8962b2b2b901692ea78e.id@mailtor>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 01:54:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd6zX-0005SA-Fa
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 01:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbaDWXyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 19:54:10 -0400
Received: from mailtor.net ([109.168.103.133]:59404 "EHLO mailtor.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290AbaDWXyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 19:54:09 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Apr 2014 19:54:08 EDT
Received: from mailtoralnhyol5v.onion (localhost [127.0.0.1])
	by mailtor.net (Postfix) with ESMTP id 79BCB267648
	for <git@vger.kernel.org>; Thu, 24 Apr 2014 01:46:02 +0200 (CEST)
Received: from MAILTOR FREE ANONYMOUS MAIL PROVIDER. SUPPORT US WITH A
 DONATION IN BITCOINS: 14vkMKcwaTVDmXVW7Y69W3p444q5D38oxc Create your free
 @mailtor.net email box at mailtoralnhyol5v.onion (you need tor software
 installed). FOR CONTACT US: admin@mailtor.net
User-Agent: >_<
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246910>

hello list,

as mentioned earlier on IRC, I'm a bit concerned about the default LESS flags
used by git.

The S option causes git to cut off everything to the right

Consider this diff, printed by `git diff`

	 #!/usr/bin/env python
	-print('foo')
	+print('bar')

Looks ok to merge and run.

But, after disabling the pager:

	 #!/usr/bin/env python
	-print('foo')
	+print('bar') [lots of tabs] ; import os; os.system('aptitude install
subversion')

Oh no!

My workflow is to clone a project, read the whole source and review all diffs
after fetching them. After that is done I merge origin into my local
branch and
run the code on my system.

I've panic'd a bit after I've noticed the chopping.

It would be nice if we could change the flags to either

 a) avoid cutting off
 b) indicate something has been cut off (<- I prefer this)

I assume there are more people with a similar workflow who're still
unaware of
this feature.

I would joke about how 3 letter agencies introduced this flag to backdoor
open
source projects, but, well..

	Sincerely yours,
	a git user
