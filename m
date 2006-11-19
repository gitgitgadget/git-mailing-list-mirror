X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Git manuals
Date: Sun, 19 Nov 2006 18:59:52 +0100
Message-ID: <20061119175952.GX7201@pasky.or.cz>
References: <20061116221701.4499.qmail@science.horizon.com> <20061117153246.GA20065@thunk.org> <20061117182157.GC11882@fieldses.org> <20061119175040.GB15608@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 19 Nov 2006 18:00:04 +0000 (UTC)
Cc: Theodore Tso <tytso@mit.edu>, linux@horizon.com,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061119175040.GB15608@fieldses.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31845>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlqxT-0003F8-4u for gcvg-git@gmane.org; Sun, 19 Nov
 2006 18:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932615AbWKSR7z (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 12:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbWKSR7z
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 12:59:55 -0500
Received: from w241.dkm.cz ([62.24.88.241]:49585 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S932615AbWKSR7y (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 12:59:54 -0500
Received: (qmail 8809 invoked by uid 2001); 19 Nov 2006 18:59:52 +0100
To: "J. Bruce Fields" <bfields@fieldses.org>
Sender: git-owner@vger.kernel.org

On Sun, Nov 19, 2006 at 06:50:40PM CET, J. Bruce Fields wrote:
> On Fri, Nov 17, 2006 at 01:21:57PM -0500, bfields wrote:
> > On Fri, Nov 17, 2006 at 10:32:46AM -0500, Theodore Tso wrote:
> > > It would be nice if there was an easy way to direct users through the
> > > documentation in a way which makes good pedagogical sense.
> ....
> > How about this as a strawman "git user's manual" outline:

(I was briefly discussing Git Book with Junio at OLS, I think the result
was "yeah, would be nice, perhaps we can start poking it soon". I
started to think about it once again in the last few weeks.)

> In fact, I'm tempted to submit a patch that just assigns a chapter
> number to everything under Documentation/, slaps a single table of
> contents on the front, and calls the result "the git user's manual."
> 
> Of course, the moment people started trying to read the thing they'd
> complain that it was a mess--some stuff referenced without being
> introduced, other stuff introduced too many times.  But then over time
> maybe that'd force us to mold it into some sort of logical sequence.

Sequencing isn't the only problem. A _manual_ is different from
_reference documentation_ in that it does not usually describe command
after command, but rather concept after concept. So instead of slamming
git-*-pack commands together, you have a section "Handling Packs" where
you try to coherently describe the commands together.

Your approach is fine for something you would call "Git Reference
Manual", but it is something really different from "The Git Book" or
"Git User's Manual".

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
