X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [BUG] StGit removed git branch of the same name as StGit branch
Date: Mon, 20 Nov 2006 17:28:12 -0500
Message-ID: <20061120222812.GE12285@fieldses.org>
References: <200611202201.45521.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 22:28:51 +0000 (UTC)
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611202201.45521.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31943>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmHcg-00052R-1U for gcvg-git@gmane.org; Mon, 20 Nov
 2006 23:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934114AbWKTW2O (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 17:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934153AbWKTW2O
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 17:28:14 -0500
Received: from mail.fieldses.org ([66.93.2.214]:62168 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S934114AbWKTW2N (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 17:28:13 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GmHca-000618-HX; Mon, 20 Nov 2006
 17:28:12 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Mon, Nov 20, 2006 at 10:01:44PM +0100, Jakub Narebski wrote:
> I have used StGit (wonderfull tool) to manage patches on git branch 
> gitweb/web. Unfortunately, I have named stg branch the same as git 
> branch. When removing stg branch (I wanted to remove 
> heads/base/gitweb/web) using "stg branch --delete gitweb/web" it 
> deleted also git branch when I wanted to remove only the StGit managed 
> indicator.

You probably actually had to "stg branch --delete --force", didn't you?

What you want is "stg commit".

> Perhaps that is correct behavior... but certainly unexpected.

I think "stg branch --delete" is pretty clearly named and documented....

The idea I guess was to make it possible to use stgit (and only stgit)
for everything, and never type a git command.  It might have been better
to make stgit only manage patch series, and admit that people should use
git for the rest.  Then it might work more like you expect.

