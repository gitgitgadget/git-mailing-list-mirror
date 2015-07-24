From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 6/6] Documentation/git-tools: drop references to defunct
 tools
Date: Fri, 24 Jul 2015 17:34:53 -0400
Message-ID: <20150724213453.GA3328@flurp.local>
References: <1437710457-38592-1-git-send-email-sunshine@sunshineco.com>
 <1437710457-38592-7-git-send-email-sunshine@sunshineco.com>
 <xmqqmvylmnzp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 23:35:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIkcY-00029v-IH
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 23:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754423AbbGXVfC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 17:35:02 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38531 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097AbbGXVfA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 17:35:00 -0400
Received: by iggf3 with SMTP id f3so27010730igg.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 14:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vc+9aCoNZlnjAlLyVwcz9Q8abaPr5d/dV3F+0d7HcPU=;
        b=sGOuClwnFwT01jOCrt2IbE/eeOpJDQRSQz2DTYMpFpOvByJUGYq/p5iQPY/CNbLB+n
         QjzFvOQFjHdZ4yN4g9C7QAay+xLylCsXm3gahKiUEtuu/ecO8q6RMe6g+ybEGel00d72
         bfzo9Iw4BwPExjhAOdJ24Jka2vqwSthjsPulG1n8HLckJ3yWZfFZUkz5rtoL7r8gXi56
         OV/bNYB1b6N/tqpdcXo7Hn/v6yISRj0CIGGA7XVygVhJe8znr5wAfMt5uefrsBlY0l4k
         B1l05ExPSz/TQJse5Kz3CvMMlvJepqNnBtGloEU79g4pkMRRExT1I81UiYTtmPtF/Wcj
         22+w==
X-Received: by 10.50.143.104 with SMTP id sd8mr185215igb.34.1437773700117;
        Fri, 24 Jul 2015 14:35:00 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id b140sm5988925ioe.9.2015.07.24.14.34.59
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 24 Jul 2015 14:34:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqmvylmnzp.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274602>

On Fri, Jul 24, 2015 at 11:03:54AM -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Cogito -- unmaintained since late 2006[1]
> > pg -- URL dead; web searches reveal no information
> > quilt2git -- URL dead; web searches reveal no information
> > (h)gct -- URL dead; no repository activity since 2007[2]
> >
> > [1]: http://git.or.cz/cogito/
> > [2]: http://repo.or.cz/w/hgct.git
> >
> > Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> > ---
> > Perhaps it would be better to drop all items, and retain only the link
> > to the Git wiki?
> 
> Hmmm, that's a very tempting thought.

Here it is in patch form atop the present series[1]. By plopping this
change atop the other patches, the decision to retire or keep the list
of tools becomes as easy as either retaining or dropping this one patch
(as opposed to re-rolling the entire series).

[1]: http://thread.gmane.org/gmane.comp.version-control.git/274537


---- 8< ----
From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 7/6] Documentation/git-tools: retire manually maintained list; keep only wiki

When Git was young, people looking for third-party Git-related tools
came to the Git project itself to find them, so it made sense to
maintain a list of tools here. These days, however, search engines fill
that role much more efficiently, so retire this manually-maintained
list.

The list of front-ends and tools on the Git wiki rates perhaps a distant
second to search engines, and may still have value, so retain a
reference to it.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-tools.txt | 88 ++++-----------------------------------------
 1 file changed, 7 insertions(+), 81 deletions(-)

diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
index 48a3595..2f4ff50 100644
--- a/Documentation/git-tools.txt
+++ b/Documentation/git-tools.txt
@@ -1,84 +1,10 @@
-A short Git tools survey
-========================
+Git Tools
+=========
 
+When Git was young, people looking for third-party Git-related tools came
+to the Git project itself to find them, thus a list of such tools was
+maintained here. These days, however, search engines fill that role much
+more efficiently, so this manually-maintained list has been retired.
 
-Introduction
-------------
-
-Apart from Git contrib/ area there are some others third-party tools
-you may want to look at.
-This document presents a brief summary of each tool and the corresponding
-link.
-For a more comprehensive list, see:
+See also the `contrib/` area, and the Git wiki:
 http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
-
-
-Alternative/Augmentative Porcelains
------------------------------------
-
-- *StGit* (http://www.procode.org/stgit/)
-+
-Stacked Git provides a quilt-like patch management functionality in the
-Git environment. You can easily manage your patches in the scope of Git
-until they get merged upstream.
-
-
-History Viewers
----------------
-
-- *gitk* (shipped with git-core)
-+
-gitk is a simple Tk GUI for browsing history of Git repositories easily.
-
-
-- *gitview*  (contrib/)
-+
-gitview is a GTK based repository browser for Git
-
-
-- *gitweb* (shipped with git-core)
-+
-Gitweb provides full-fledged web interface for Git repositories.
-
-
-- *qgit* (http://digilander.libero.it/mcostalba/)
-+
-QGit is a git/StGit GUI viewer built on Qt/C++. QGit could be used
-to browse history and directory tree, view annotated files, commit
-changes cherry picking single files or applying patches.
-Currently it is the fastest and most feature rich among the Git
-viewers and commit tools.
-
-- *tig* (http://jonas.nitro.dk/tig/)
-+
-tig by Jonas Fonseca is a simple Git repository browser
-written using ncurses. Basically, it just acts as a front-end
-for git-log and git-show/git-diff. Additionally, you can also
-use it as a pager for Git commands.
-
-
-Foreign SCM interface
----------------------
-
-- *git-svn* (shipped with git-core)
-+
-git-svn is a simple conduit for changesets between a single Subversion
-branch and Git.
-
-
-- *hg-to-git* (contrib/)
-+
-hg-to-git converts a Mercurial repository into a Git one, and
-preserves the full branch history in the process. hg-to-git can
-also be used in an incremental way to keep the Git repository
-in sync with the master Mercurial repository.
-
-
-Others
-------
-
-- *git.el* (contrib/)
-+
-This is an Emacs interface for Git. The user interface is modelled on
-pcl-cvs. It has been developed on Emacs 21 and will probably need some
-tweaking to work on XEmacs.
-- 
2.5.0.rc3.407.g68aafd0
