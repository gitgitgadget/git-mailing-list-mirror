From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/2] git-candidate: git based patch tracking and review
Date: Wed, 11 Nov 2015 10:55:07 +0100
Message-ID: <5643107B.20501@alum.mit.edu>
References: <1447160198-23296-1-git-send-email-richard.ipsum@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Richard Ipsum <richard.ipsum@codethink.co.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 11:02:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwSET-0002rW-8s
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 11:02:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbbKKKCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 05:02:18 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:52786 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751508AbbKKKCN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Nov 2015 05:02:13 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Nov 2015 05:02:13 EST
X-AuditID: 1207440e-f79516d0000012b3-82-5643107d40a0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 3B.61.04787.D7013465; Wed, 11 Nov 2015 04:55:09 -0500 (EST)
Received: from [192.168.69.130] (p4FC97793.dip0.t-ipconnect.de [79.201.119.147])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tAB9t7b5016521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 11 Nov 2015 04:55:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1447160198-23296-1-git-send-email-richard.ipsum@codethink.co.uk>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqFsr4BxmcOaemUXXlW4mi08n3ByY
	PJ69nMzk8XmTXABTFLdNUmJJWXBmep6+XQJ3xsojJ9gK/ghXdH9ewtjAOEOgi5GTQ0LARGLi
	jHOMELaYxIV769m6GLk4hAQuM0rc+X6SHcK5wCRxdsZHJpAqXgFNiUkH17GB2CwCqhK7zk9i
	AbHZBHQlFvU0g9WICgRJrFj+ghGiXlDi5MwnYDUiAm4Stxq72EFsYQFviSMPpzOD2EICvhK7
	114GquHg4BTwk5h8QwkkzCygJ7Hj+i9WCFteonnrbOYJjPyzkEydhaRsFpKyBYzMqxjlEnNK
	c3VzEzNzilOTdYuTE/PyUot0jfVyM0v0UlNKNzFCwpFvB2P7eplDjAIcjEo8vBE2TmFCrIll
	xZW5hxglOZiURHmtGZ3DhPiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwHuADyvGmJFZWpRblw6Sk
	OViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHj1+IEaBYtS01Mr0jJzShDSTBycIMO5pESK
	U/NSUosSS0sy4kERGV8MjEmQFA/Q3mqQdt7igsRcoChE6ylGRSlx3vkgCQGQREZpHtxYWJJ5
	xSgO9KUwryVIFQ8wQcF1vwIazAQ0+IuEE8jgkkSElFQDo8gEMbYNZcKOr6wWStYHXljErMHL
	V+n2/uWkuhQDpYvSaY9cTj0VWTFRzrXOt1Uxn8XGfG1/YENmpPT5rDzJM3WmCzbbdH4IePdm
	8jazqaXH/rVtkb651KokcV/Br5CiaGvdlY+WRxyzOhVh9qbJ2Dot/c1cBbWytvfr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281155>

On 11/10/2015 01:56 PM, Richard Ipsum wrote:
> I've continued my work[1] to add patch tracking and candidate review capability
> to git.
> 
> git-candidate now has a more git-like user interface, so remote candidates
> can now be specified in a similar way to remote refs (e.g. origin/candidate)
> as well as various other improvements, such as versioned metadata.

This is a really interesting project. I've seen a blog post or two
proposing to store bug tracker information in Git in a distributed way,
but I don't recall anything about doing the same for code review
information.

I would be interested to hear about the design of your system at an
abstract technical level. What do you store in Git and in what layout?
Do you need to record any extra metadata within the commits that are
merged to master? How do you merge and/or reconcile code review comments
that come from multiple sources (or are they just tabulated)? Can your
system handle the rebasing of topic branches? What about nonlinear topic
branches (branches branches that themselves include merges)?

All that being said, my gut feeling is that a system like this should
not be developed within the Git project itself. Code review is a
complicated thing, and I expect that different people will have very
different ideas about how it should work. It would be a bad idea for the
Git project to "bless" one system by including it in our source tree.
(Earlier in the Git's history it was easier to get something accepted
into "contrib", but that has gotten much harder over time.)

If, someday, one system becomes crushingly dominant, then conceivably it
would make sense for it to be distributed along with Git for the
convenience of users. Or if a bunch of review systems standardize on a
single data model for storing review information in a Git repo, it might
make sense for the plumbing for handling that data to reside in git-core
for performance and data integrity reasons. Until then, I think it would
be better for code review systems to live on their own, as independent
projects.

In my opinion it would be fine to discuss the design of your system and
solicit feedback about the design on the Git mailing list, and also to
publish occasional announcement emails when you release new versions or
whatever. You might also want to list your system on the Git SCM wiki,
for example here [1].

Yours,
Michael

[1] https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools

-- 
Michael Haggerty
mhagger@alum.mit.edu
