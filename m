X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/3] git-svn: documentation updates
Date: Sat, 2 Dec 2006 17:39:55 -0800
Message-ID: <20061203013955.GD1369@localdomain>
References: <1164768702941-git-send-email-normalperson@yhbt.net> <11647687042130-git-send-email-normalperson@yhbt.net> <456D36CE.1060300@midwinter.com> <20061129085419.GB4486@hand.yhbt.net> <loom.20061129T133305-813@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 3 Dec 2006 01:40:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <loom.20061129T133305-813@post.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33078>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqgKz-0004pt-A2 for gcvg-git@gmane.org; Sun, 03 Dec
 2006 02:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758563AbWLCBj6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 20:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758633AbWLCBj6
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 20:39:58 -0500
Received: from hand.yhbt.net ([66.150.188.102]:11162 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1758563AbWLCBj5 (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 20:39:57 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 0664D2DC034; Sat,  2 Dec 2006 17:39:55 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 02 Dec 2006
 17:39:55 -0800
To: Pazu <pazu@pazu.com.br>
Sender: git-owner@vger.kernel.org

Pazu <pazu@pazu.com.br> wrote:
> Eric Wong <normalperson <at> yhbt.net> writes:
> 
> > Also, something that can wrap (git commit && git svn dcommit) into one
> > step would be nice.
> 
> What I'd like to see is foreign systems integration for git pull/push. If git
> had to use git-svn behind the curtains, so be it would be -very- nice if the
> user could just use git pull/push.

Both push and pull are git/bk/hg(?)-specific terms; most SVN users are
not accustomed to them.  Using 'pull' with git-svn has already been
discouraged for a while (since the introduction of dcommit); and
having a 'push' without a 'pull' would be very confusing.

I am interested in putting the .git/svn/*/info/url information into
.git/config, however (like modern remotes).

-- 
