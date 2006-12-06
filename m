X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] cvs-migration document: make the need for "push" more obvious
Date: Wed, 6 Dec 2006 12:24:50 -0500
Message-ID: <20061206172450.GE1714@fieldses.org>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org> <45760545.2010801@gmail.com> <20061206.105251.144349770.wl@gnu.org> <Pine.LNX.4.63.0612061325320.28348@wbgn013.biozentrum.uni-wuerzburg.de> <4576D92A.80307@xs4all.nl> <20061206145802.GC1714@fieldses.org> <Pine.LNX.4.63.0612061613460.28348@wbgn013.biozentrum.uni-wuerzburg.de> <20061206171950.GD1714@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 17:25:09 +0000 (UTC)
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, gpermus@gmail.com,
	hanwen@lilypond.org, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061206171950.GD1714@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33497>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs0Vx-0006J8-Fu for gcvg-git@gmane.org; Wed, 06 Dec
 2006 18:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936809AbWLFRY6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 12:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936909AbWLFRY6
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 12:24:58 -0500
Received: from mail.fieldses.org ([66.93.2.214]:39176 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S936809AbWLFRY5 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 12:24:57 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1Gs0Vn-00034K-1U; Wed, 06 Dec 2006
 12:24:51 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Wed, Dec 06, 2006 at 12:19:50PM -0500, J. Bruce Fields wrote:
> On Wed, Dec 06, 2006 at 04:16:57PM +0100, Johannes Schindelin wrote:
> Definitely, I agree.  So that argues for locating the most import stuff
> as close to start of the document as possible.  But obviously there's
> lot of important stuff and you can't do that with everything, so you
> also have to rely on keeping things organized so people can more easily
> skip to the middle.

Hm, but, come to think of it, I agree with you that the "how to commit
and push" really should come earlier, since that's the stuff most people
need to know; currently the order is roughly:

	importing a cvs archive
	creating a shared repository
	committing to a shared repository

We should start out with the assumption that a shared repo is already
set up and make it:

	committing to a shared repository
	creating a shared repository
	importing a cvs archive

which puts it in stuff-most-people-need-to-know to
stuff-less-people-need-to-know order.  Maybe the current introduction
should even be postponed to later.

And some day we should move that whole final CVS annotate section
elsewhere.

