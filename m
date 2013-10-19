From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 00/14] Officially start moving to the term 'staging
 area'
Date: Fri, 18 Oct 2013 19:41:12 -0500
Message-ID: <5261d528ca9cf_35b014d9e7cb6@nysa.notmuch>
References: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
 <1381789769-9893-4-git-send-email-felipe.contreras@gmail.com>
 <5261C42E.4050208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Miles Bader <miles@gnu.org>
To: Karsten Blees <karsten.blees@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 19 03:12:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXL5L-0000bu-Fb
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 03:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977Ab3JSBL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 21:11:57 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:62316 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab3JSBL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 21:11:56 -0400
Received: by mail-ob0-f172.google.com with SMTP id gq1so256735obb.17
        for <git@vger.kernel.org>; Fri, 18 Oct 2013 18:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=rPKiU2PoqQ/uCAh7EdcDw7CMy2A/wv22DnQEuvI16yg=;
        b=RXPxORmwNPXTKzKLszoRZvzJz0kHhPjm4qAxvNmMIaswW9xsArDqT6ta07mg7POa9q
         D7QrLFNv84Tw8jeRzXEo2jtULaA7Viq46uEiARDWeRg0j8P8uYILqIT3yVbadanNWYgA
         jifKDI3cbAp6YaVxQ6PT9wqld/3TyP5WC3aYn63xIMS4v3JxWljEo4+rlf8AkujlaX9c
         LWowc0YGABEHiTw2TDOpNPqbB2lp4HSukCNtyzdK51VNqhRyc2aka+wUFf1XSrPGOVrL
         Y3qbipxaHj15ACLrM5rOSzGFRE8+ig9FCzYB12rp6VbtJnhjx/eEYLo63YTARyNkFlBA
         0/bA==
X-Received: by 10.182.44.134 with SMTP id e6mr8750850obm.14.1382145116054;
        Fri, 18 Oct 2013 18:11:56 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hs4sm9705359obb.5.2013.10.18.18.11.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2013 18:11:54 -0700 (PDT)
In-Reply-To: <5261C42E.4050208@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236381>

Karsten Blees wrote:
> Am 15.10.2013 00:29, schrieb Felipe Contreras:
> > tl;dr: everyone except Junio C Hamano and Drew Northup agrees; we should move
> > away from the name "the index".
> > 
> > It has been discussed many times in the past that 'index' is not an
> > appropriate description for what the high-level user does with it, and
> > it has been agreed that 'staging area' is the best term.
> 
> I haven't followed the previous discussion, but if a final conclusion towards
> 'staging area' has already been reached, it should probably be revised.
> 
> > The term 'staging area' is more intuitive for newcomers which are more
> > familiar with English than with Git, and it seems to be a
> > straightforward mental notion for people with different mother tongues.
> > 
> > In fact it is so intuitive that it's used already in a lot online
> > documentation, and the people that do teach Git professionally use this
> > term, because it's easier for many kinds of audiences to grasp.
> 
> Such online documentation often portraits the 'staging area' as some
> supposedly 'unique' git feature, which I find _very_ confusing. In fact,
> every major SCM has a staging area. E.g. you first need to "svn/hg/bzr/p4
> add/remove/rename/move" a file, which is somehow recorded in the working
> copy. These recorded changes will then be picked up by a subsequent
> "svn/hg/bzr/p4 commit/submit".

That is not a staging area.

  % hg init test
  % cd test
  % echo Hello > README
  % hg add README
  % echo Bye > README
  % hg commit -m Init
  % hg log -p -r -1
  changeset:   0:ba28df72474c
  tag:         tip
  user:        Felipe Contreras <felipe.contreras@gmail.com>
  date:        Fri Oct 18 19:43:42 2013 -0500
  summary:     Init

  diff -r 000000000000 -r ba28df72474c README
  --- /dev/null	Thu Jan 01 00:00:00 1970 +0000
  +++ b/README	Fri Oct 18 19:43:42 2013 -0500
  @@ -0,0 +1,1 @@
  +Bye


What exactly got staged?

To me the best way to think about the staging area is like a commit draft. No
other VCS has anything like that. And what is the point about this argument?

> > index: an 'index' is a guide of pointers to something else; a book
> > index has a list of entries so the reader can locate information
> > easily without having to go through the whole book. Git porcelain is
> > not using the staging area to find out entries quicker; it's not an
> > index.
> 
> The 'staging area' is a sorted list of most recently checked out files, and
> its primary purpose is to quickly detect changes in the working copy (i.e.
> its an index).

That is not it's primary purpose.

> Of the 28 builtin main porcelain commands, 18 read the index (read_index),
> and 11 of those also check the state of the working copy (ie_match_stat).
> Incidentally, the latter include _all_ commands that update the so-called
> 'staging area'.
> 
> Subversion until recently kept the checked out files scattered in
> **/.svn/text-base directories, and many operations were terribly slow due to
> this. Subversion 1.7 introduced a new working copy format, based on a
> database in the root .svn directory (i.e. an index), leading to tremendous
> performance improvements.
> 
> The git index is a major feature that facilitates the incredible performance
> we're so much addicted to...why be shy about it and call it something else?

Tell me which subversion command adds and removes information from their
working copy metadata, which is not a used as a staging area, commit draft, or
even an index.

Moreover, we are not discussing about Git's index file, that low level concept
will stay the same, we are talking about the high level concept.

> > stage: a 'stage' is a special area designated for convenience in order
> > for some activity to take place; an orator would prepare a stage in
> > order for her speak to be successful, otherwise many people might not
> > be able to hear, or see her. Git porcelain is using the staging area
> > precisely as a special area to be separated from the working directory
> > for convenience.
> 
> I'm not a native speaker, but in my limited understanding, 'staging' in
> computer jargon is the process of preparing data for a production system
> (i.e. until the 'stage' or 'state' of the data is ready for production). It
> has nothing to do with the 'stage' in a theater.

It is the same. A stage in the theater is also used for preparing a production.

> I've never heard the term 'staging' beeing used for source code or software
> (that would be 'integration'). I've also never heard 'staging' for moving
> data back from a production system to some work- or development area.

Then why are people using it in external documentation? Why is ProGit already using it?

But more importantly: do you have a better name?

> In any sense, 'staging' is a unidirectional process (even in a theater).

It is not. Props and utilites are added and removed from the stage.

> If I think of the index as a staging area, it covers just a single use case:
> preparing new commits.

That is its main purpose.

> With this world view, it is completely counter-intuitive that e.g. changing
> branches overwrites my staging area.

Why would it do that? It's preparing the next commit, on top of which branch is
not defined yet.

> IMO, it is ok to use 'like a staging area' when we talk about using the index
> to prepare new commits.

Which is how it is being proposed; changing the name of the high-level concept.

> However, its not ok to use 'staging area' as a general synonym for the index.

Nobody is proposing that; the low-level "index file" stays the same.

-- 
Felipe Contreras
