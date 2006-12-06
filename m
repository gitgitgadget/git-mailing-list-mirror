X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] cvs-migration document: make the need for "push" more obvious
Date: Wed, 6 Dec 2006 09:58:02 -0500
Message-ID: <20061206145802.GC1714@fieldses.org>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org> <45760545.2010801@gmail.com> <20061206.105251.144349770.wl@gnu.org> <Pine.LNX.4.63.0612061325320.28348@wbgn013.biozentrum.uni-wuerzburg.de> <4576D92A.80307@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 14:58:27 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gpermus@gmail.com, hanwen@lilypond.org, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4576D92A.80307@xs4all.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33465>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GryDw-0006UU-MP for gcvg-git@gmane.org; Wed, 06 Dec
 2006 15:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760675AbWLFO6N (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 09:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760676AbWLFO6N
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 09:58:13 -0500
Received: from mail.fieldses.org ([66.93.2.214]:51095 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1760675AbWLFO6N (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 09:58:13 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GryDi-0000lC-T2; Wed, 06 Dec 2006
 09:58:02 -0500
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

On Wed, Dec 06, 2006 at 03:52:26PM +0100, Han-Wen Nienhuys wrote:
> Johannes Schindelin escreveu:
> > It really is an important concept to grasp for people coming
> > from CVS. Even if it is briefly mentioned, it is not obvious
> > enough to sink in.
> 
> I think the goal is laudable, but IMO it would be better to shorten
> the document rather adding more text.

OK, but...

>  Documentation/cvs-migration.txt |   34 +++++++++++++++++++++++-----------
>  1 files changed, 23 insertions(+), 11 deletions(-)

... that lengthens it even more than the proposed addition.

> +    Hence, there is a difference between creating a revision
> +    (the "commit" command) and submitting it (the "push" command).

I'd rather leave that introduction as it is--just as a section that
advertises the git features without trying to explain much.  And I'd
rather not mention push until we have a chance to explain how to use it.

