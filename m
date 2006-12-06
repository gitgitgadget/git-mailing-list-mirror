X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] cvs-migration document: make the need for "push" more obvious
Date: Wed, 6 Dec 2006 09:52:19 -0500
Message-ID: <20061206145219.GB1714@fieldses.org>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org> <45760545.2010801@gmail.com> <20061206.105251.144349770.wl@gnu.org> <Pine.LNX.4.63.0612061325320.28348@wbgn013.biozentrum.uni-wuerzburg.de> <el6d50$p7e$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 14:52:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <el6d50$p7e$2@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33463>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gry8G-0005Sx-J0 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 15:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760668AbWLFOwV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 09:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760669AbWLFOwV
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 09:52:21 -0500
Received: from mail.fieldses.org ([66.93.2.214]:32933 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1760668AbWLFOwU (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 09:52:20 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1Gry8B-0000fu-2K; Wed, 06 Dec 2006
 09:52:19 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Wed, Dec 06, 2006 at 01:32:32PM +0100, Jakub Narebski wrote:
> Johannes Schindelin wrote:
> 
> > +  * Since every working tree contains a repository, a commit will not
> > +    publish your changes; it will only create a revision. You have to
> > +    "push" your changes to a public repository to make them visible
> > +    to others.
> > +
> 
> I'm not sure about context of this addition, but it is simply not
> true if you publish your working repository. Granted, usually one
> sets up bare public publishing repository...

That's true, but this document is focused on the cvs-like case of
multiple private repos pushing to a single common public repo.

But we could replace "a commit will not publish" by "a commit in your
private repository will not publish"--which would make the statement
true without distracting from the main point.

