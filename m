X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: Re: Collection of stgit issues and wishes
Date: Mon, 18 Dec 2006 00:21:14 +0100
Message-ID: <20061217232113.GC16838@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20061208221744.GA3288@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0612120143j7d0c1026rab046c8f44ec43ca@mail.gmail.com> <87y7pc2rc7.fsf@morpheus.local> <457FD3E4.3090104@op5.se> <20061213110314.GA22670@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 17 Dec 2006 23:21:37 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>,
	David K?gedal <davidk@lysator.liu.se>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061213110314.GA22670@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34710>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gw5K2-0001ll-2F for gcvg-git@gmane.org; Mon, 18 Dec
 2006 00:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753209AbWLQXVb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 18:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753208AbWLQXVa
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 18:21:30 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:36954 "EHLO
 smtp1-g19.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1753209AbWLQXVa (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006
 18:21:30 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp1-g19.free.fr (Postfix) with ESMTP id DD172AFB; Mon,
 18 Dec 2006 00:21:28 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000) id 141811F092;
 Mon, 18 Dec 2006 00:21:14 +0100 (CET)
To: Karl Hasselstr?m <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On Wed, Dec 13, 2006 at 12:03:14PM +0100, Karl Hasselstr?m wrote:
> > > That approach can cause problems later on. If "stgit st" is
> > > currently a unique prefix of "stgit status", people might use it
> > > in scripts. Then, one day, you add the "stgit store" command, or
> > > whatever, and their scripts start breaking for no good reason.

Such shortcuts are *definitely* not for script writers.

> > People who use abbreviations of commands in scripts ought to be
> > shot, not catered to, especially if they know this abbreviation is
> > automagically calculated.
> 
> Well, yes, but there's no reason to not shoot them _politely_ ...

At least we could shoot them when stdout is not a tty ?
Not sure there is a good way of detecting if we're being run directly 
from an interactive shell.


> I'd prefer hand-picked command abbreviations to reduce namespace
> clutter. That way, it's even possible to have "ambiguous" shortcuts --
> for example, "stg st" -> "stg status" even if "stg store" exists. And
> shortcuts that aren't prefixes, like "stg ua" -> "stg unapplied". And
> the user doesn't need to retrain her fingers just because a prefix
> gets ambiguous.

Sure, I'd hate having to type "stg sta" :)

Best regards,
-- 
