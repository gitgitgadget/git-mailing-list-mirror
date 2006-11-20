X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [BUG] StGit removed git branch of the same name as StGit branch
Date: Mon, 20 Nov 2006 17:48:00 -0500
Message-ID: <20061120224800.GF12285@fieldses.org>
References: <200611202201.45521.jnareb@gmail.com> <20061120222812.GE12285@fieldses.org> <ejtal6$p8s$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 22:48:43 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ejtal6$p8s$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31948>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmHvr-0001Nv-TP for gcvg-git@gmane.org; Mon, 20 Nov
 2006 23:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966400AbWKTWsE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 17:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966408AbWKTWsE
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 17:48:04 -0500
Received: from mail.fieldses.org ([66.93.2.214]:15550 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S966400AbWKTWsC (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 17:48:02 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GmHvk-0006KC-PH; Mon, 20 Nov 2006
 17:48:00 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Mon, Nov 20, 2006 at 11:37:54PM +0100, Jakub Narebski wrote:
> J. Bruce Fields wrote:
> > You probably actually had to "stg branch --delete --force", didn't you?
> 
> Nope. "stg branch --delete gitweb/web"
> 
> > What you want is "stg commit".
> 
> No. Whole stack was committed, I wanted only get rid of
> heads/base/gitweb/web (of StGit managed branch indicator).

Oh, right, got it.

> > The idea I guess was to make it possible to use stgit (and only stgit)
> > for everything, and never type a git command.  It might have been better
> > to make stgit only manage patch series, and admit that people should use
> > git for the rest.  Then it might work more like you expect.
> 
> Yes, I expected to use StGit as a kind of preprocessing (branch preparation)
> for git.

The multiple-porcelains idea seems like a mistake to me--it'd be fine if
you're just adding new features on the side, but who wants to learn
entirely different sets of commands, with subtly different syntax,
semantics, and feature sets, for doing the same thing?

