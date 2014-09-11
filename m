From: ezyang <ezyang@mit.edu>
Subject: Diffs for submodule conflicts during rebase usually empty
Date: Thu, 11 Sep 2014 13:50:57 -0400
Message-ID: <20140911135057.o7j9bwlnz4okgwsw@webmail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 19:56:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS8bJ-00021Z-0V
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 19:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbaIKR4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 13:56:04 -0400
Received: from dmz-mailsec-scanner-5.mit.edu ([18.7.68.34]:46826 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750852AbaIKR4C (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2014 13:56:02 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Sep 2014 13:56:02 EDT
X-AuditID: 12074422-f79436d000000c21-e8-5411e104af78
Received: from mailhub-4.mit.edu ( [18.7.62.40])
	(using TLS with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by dmz-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id EF.BE.03105.401E1145; Thu, 11 Sep 2014 13:51:00 -0400 (EDT)
Received: from outgoing.mit.edu (outgoing-1.mit.edu [18.9.28.12])
	by mailhub-4.mit.edu (8.13.8/8.9.2) with ESMTP id s8BHoxPZ022866
	for <git@vger.kernel.org>; Thu, 11 Sep 2014 13:51:00 -0400
Received: from webmail-4.mit.edu (webmail-4.mit.edu [18.9.23.14])
	)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id s8BHowH0012647
	for <git@vger.kernel.org>; Thu, 11 Sep 2014 13:50:59 -0400
Received: from webmail-4.mit.edu (webmail-4.mit.edu [127.0.0.1]) by webmail-4.mit.edu (8.13.8) with ESMTP
	id s8BHow63008188; Thu, 11 Sep 2014 13:50:58 -0400
Received: (from nobody@localhost)
	by webmail-4.mit.edu (8.13.8/8.13.8/Submit) id s8BHov7I008187
	for git@vger.kernel.org; Thu, 11 Sep 2014 13:50:57 -0400
X-Authentication-Warning: webmail-4.mit.edu: nobody set sender to ezyang@mit.edu using -f
Received: from ool-18b93804.dyn.optonline.net
	(ool-18b93804.dyn.optonline.net [24.185.56.4])   (User authenticated as
	ezyang@ATHENA.MIT.EDU) by webmail.mit.edu (Horde MIME library) with HTTP;
	Thu, 11 Sep 2014 13:50:57 -0400
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.0.3)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixG6nocvyUDDEYGWHpUXXlW4mB0aPz5vk
	AhijuGxSUnMyy1KL9O0SuDIOb9jPVDBPquLehPMsDYx7hbsYOTkkBEwkPuxbygJhi0lcuLee
	DcQWEpjGJNHartjFyAVkH2SUePJ2IytE4iijxJXjFRCJeYwSq7fsYoZw5jBKHO1aywwxKlJi
	9/MdLBCJp4wSh3duYAJJ8ArYSpxvus8OYrMIqEqsXdsC1sAmICvx8cMKsBoRAXGJt8dngtUI
	CzhJ3D5wnRmiV1Di5MwnYLcyC+hJ/P95irGLkQPIlpZY/o8DIiwvsf3tHLByUQFziQd7dzBO
	YBSehaR7FpLuWQjds5B0L2BkWcUom5JbpZubmJlTnJqsW5ycmJeXWqRrqpebWaKXmlK6iREc
	8i5KOxh/HlQ6xCjAwajEw1vBIhgixJpYVlyZe4hRkoNJSZT32m2gEF9SfkplRmJxRnxRaU5q
	8SFGCQ5mJRFe54VAOd6UxMqq1KJ8mJQ0B4uSOO+mH3whQgLpiSWp2ampBalFMFkZDg4lCV7Z
	B0CNgkWp6akVaZk5JQhpJg5OkOE8QMOv3gcZXlyQmFucmQ6RP8Woy7Gu81s/kxBLXn5eqpQ4
	bx9IkQBIUUZpHtwcWKp6xSgO9JYwbzrIOh5gmoOb9ApoCRPQkoPG/CBLShIRUlINjL2szT0s
	JdU7C6v63t2Oa+3YJONtdCazxHrTLZlXRkaxX/N+l2bO+H505a0P7w7yi6bn/1H8/UTldfa9
	M9f7TLNK56+MzjdjsDthlb/wcOptdrY76mvXdbhJbG9KVZ9inl0wW7uc44mBQu2v 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256859>

Hello all,

In many situations, if you have a submodule conflict during a rebase,
and you type 'git diff' to get a summary of the situation, you will get
an empty diff.  Here's a simple transcript for one such case (I'm sorry
I can't make it much shorter), tested on git version 2.0.3.693.g996b0fd:

    git init
    mkdir b
    cd b
    git init
    git commit --allow-empty -m "submodule initial"
    cd ..
    git submodule add ./b
    git commit -am "parent initial"
    git branch dev
    cd b
    touch a
    git add a
    git commit -m "submodule master"
    cd ..
    git commit -am "parent master"
    git checkout dev
    git submodule update
    cd b
    touch b
    git add b
    git commit -m "submodule dev"
    cd ..
    git commit -am "parent dev"
    git rebase master
    git diff b

The last output is:

    diff --cc b
    index 4b1b6c6,c423df2..0000000
    --- a/b
    +++ b/b

As it turns out, this behavior is logical in a perverse sort of way.

    - The rebase operation doesn't go about updating your submodule
      checkouts, so whatever is in the file is what the submodule
      was pointing to before your initiated the rebase.

    - By default, 'git diff' on a merge conflict (implicitly
      'git diff --cc') only will report if the submodule's HEAD
      differs from all of the merge heads.  So if you only had
      one commit which changed the submodule, you're probably
      on that commit, and so the "current state" of the submodule

However, just because behavior is logical, doesn't mean it is user
friendly.  There are a few problems here:

    1. Git is treating the lagging submodule HEAD as if it were
    actually a resolution that you might want for the conflict.
    Actually, it's basically almost always wrong (in the example
    above, if you commit it you'll be discarding commits made on
    master.)  There is a sorter of wider UI issue here where Git
    can't tell if you've legitimately changed the HEAD pointer
    of a submodule, or if you checked out a new revision with different
    submodule pointers and forgot to run 'git submodule update'.
    (But by the way, you can't even do that here, because this is
    a merge!)

    2. The behavior of not reporting the diff when the diff for one
    branch is non-empty is illogical: for submodules (whose "file
    contents" are so short), you basically always want some hashes,
    and not an empty diff.  Doubly so when the "resolution" is
    bogus (c.f. (1)).

Of course, changing behavior in a backwards-incompatible way is never a
good way, so it's not exactly obvious what should be done here. I would
recommend tweaking the default combined diff behavior for submodules and
adding an admonition to the user that the submodules have not been
updated in the rebase message (I can submit a patch for this if people
agree if it's a good idea), but maybe that's too much of a behavior
change.

By the way, the difference between 'git diff -c' and 'git diff --cc'
does not seem to be documented anywhere, except for an oblique comment
in diff-format.txt "Note that 'combined diff' lists only files which
were modified from all parents." -- the user expected, of course, to
figure out that 'combined diff' here refers to --cc, but not -c.

Cheers,
Edward
