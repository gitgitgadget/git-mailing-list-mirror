From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git User's Survey 2008 partial summary, part 3
Date: Sun, 7 Sep 2008 16:47:18 -0700
Message-ID: <20080907234718.GC15460@spearce.org>
References: <200809031607.19722.jnareb@gmail.com> <200809060422.34779.jnareb@gmail.com> <20080906051530.GB28035@spearce.org> <2c6b72b30809071607m69148ec0mc9d0925e24bb7b7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 01:48:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcTza-0000t8-GI
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 01:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbYIGXrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 19:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbYIGXrU
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 19:47:20 -0400
Received: from george.spearce.org ([209.20.77.23]:56509 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbYIGXrT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 19:47:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B54083835C; Sun,  7 Sep 2008 23:47:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <2c6b72b30809071607m69148ec0mc9d0925e24bb7b7e@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95195>

Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
> One thing that I am wondering about is how to best integrate the
> various git-specific traits. NetBeans already has several VCS plugins,
> many of which are derived from the same code and have been built to
> abide to the same UI design principles, and so naturally they have a
> similar "feel" to them. It seems foolish to not try and respect this
> when integrating git into the IDE space. Especially, to make it easier
> for people to try out and switch to git.

Yea, that's a big concern for any IDE implementor.  Many of the
Eclipse team providers (if not all of them?) have derived from the
CVS team provider that comes as part of the base platform.  So they
often share the same look-and-feel.  But I think Eclipse defines
less of a common VCS UI than what you are implying NetBeans does.

In Eclipse I think it is more common to define VCS custom views
(little windows/toolbars) and let the user turn on/off each view
as they see fit.
 
> One example is the question of how to enable users to work with the
> index without adding too many obscure UI elements. NetBeans VCS
> infrastructure and diff engine automatically annotates, which lines in
> the editor has been changed, modified, or deleted, and allows users to
> revert on a chunk level. While it seems very practical to extend the
> annotation bar to allow changes to be staged (I am not sure if this is
> even possible) it could end up cluttering a concept that many users
> are already very familiar with.

Yea, extending the annotation bar to show the index may actually
be useful quite useful.  If its only 15 pixels of horizontal width
lost that's actually worthwhile.  I think an older version of EGit
had something like this until I broke it.  I can't remember.

> I am curious what kind of considerations you have done on this topic
> in your work on EGit.

We've mostly ignored it.  I haven't put a lot of thought into it
because I have been focused on getting a solid JGit implementation
in place.

I do know that I really miss having an overview of what is
essentially the left side of git-gui; the staged and unstaged
(but modified) file lists.  The resource decorator is nice, but it
doesn't quite give the same flat-tree overview.

-- 
Shawn.
