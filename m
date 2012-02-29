From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Wed, 29 Feb 2012 20:18:05 +0100
Message-ID: <1330543085.22763.50.camel@beez.lab.cmartin.tk>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: opticyclic <opticyclic@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 20:19:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2p3W-0006VT-LQ
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 20:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758275Ab2B2TTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 14:19:11 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:56215 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754024Ab2B2TTK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 14:19:10 -0500
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id E504546057;
	Wed, 29 Feb 2012 20:19:03 +0100 (CET)
In-Reply-To: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191846>

On Wed, 2012-02-29 at 12:19 -0500, opticyclic wrote:
> Firstly, why is there no Bug Tracker such as JIRA for the git project?

Bug trackers aren't magical. Just because a bug is in some sort of
database, it doesn't mean that it's going to get fixed faster. People
work on what they find interesting or their sponsors find important. Bug
databases are also notorious for getting filled with duplicate entries
and languishing bugs that are waiting for the original reporter to
answer with some information that the developers asked. Everyone would
also need to get an account on that bug tracker, making it harder to
report and contribute.


There used to be a wiki for buglets so people could get started, but I'm
not sure if it survived the k.org compromise.

> This mailing list is next to useless for users since searching is
> difficult, as is commenting and voting.

All you need to comment is an e-mail program, which most people have.
gmane also allows you to post from the web interface. What voting are
you referring to? There is no form of formal voting that isn't
restricted to the people responsible (or knowledgeable about) a
particular part of the project. And that's not even really voting, but a
review on the soundness of the patch.

> 
> Secondly, since one of the alleged reasons for creating git was to not
> have to deal with patches, why are pull requests disable and patches
> sent to this mailing list?!

Who said git was made to stop dealing with patches? Some of the git
terminology is influenced by that (compare 'git revert' with the idea of
a revert that other systems have). Do you follow the linux mailing list?
It's full of patches waiting to be reviewed.

git does use pull requests. That's how gitk and git-svn are updated, in
the git repository. I believe the git-subtree inclusion request also
took form of a pull request.

> I have read https://github.com/gitster/git/blob/master/Documentation/SubmittingPatches
> and it doesn't explain it.
> 
> I'm sure I don't have to tell you that GitHub has discussions on pull
> requests, which are easier to view than the mailing list archives.

Easier to view? Do you mean it's easier on the eyes? Easier to get an
overview? What do you want to view in these discussions? Why do you want
everyone to need a GitHub account to participate in git?

The GitHub web-UI has no threading, which means that you either discuss
all the patches together in one line so it's no longer clear who's
answering what, or you comment on the commit itself, which means that
the whole discussion is at least as segmented as what you get via
e-mail, and you have to scroll more to get to the discussion of a
particular commit.

TL;DR this is the way we've found to be the most effective.

   cmn
