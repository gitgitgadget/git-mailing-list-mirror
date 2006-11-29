X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/3] git-svn: documentation updates
Date: Wed, 29 Nov 2006 00:54:19 -0800
Message-ID: <20061129085419.GB4486@hand.yhbt.net>
References: <1164768702941-git-send-email-normalperson@yhbt.net> <11647687042130-git-send-email-normalperson@yhbt.net> <456D36CE.1060300@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 29 Nov 2006 08:54:38 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <456D36CE.1060300@midwinter.com>
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32624>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpLCx-0002KN-Uc for gcvg-git@gmane.org; Wed, 29 Nov
 2006 09:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966359AbWK2IyV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 03:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966365AbWK2IyU
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 03:54:20 -0500
Received: from hand.yhbt.net ([66.150.188.102]:22403 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S966359AbWK2IyU (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 03:54:20 -0500
Received: by hand.yhbt.net (Postfix, from userid 500) id C5D172DC035; Wed, 29
 Nov 2006 00:54:19 -0800 (PST)
To: Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

Steven Grimm <koreth@midwinter.com> wrote:
> Eric Wong wrote:
> >Eliminate 'commit' from some places and plug 'dcommit' more.
> >Also update the section --id (GIT_SVN_ID) usage since we
> >have multi-init/multi-fetch now.
> >  
> 
> In the spirit of the "should the -a option be the default in 
> git-commit?" discussion... What are the chances that a future version of 
> git-svn could change the "dcommit" command to "commit" and the current 
> "commit" to something else? I know it's a historical artifact, but given 
> that git-svn is (by definition) aimed at Subversion users who are 
> probably used to running "svn commit", it seems like making "git-svn 
> commit" be the thing you usually want to run would be a good thing. One 
> less habit to unlearn.

I've been considering something along those lines.  I'm interested in
renaming the current 'commit' command to something else (it still has
its uses), but I haven't figured out what to call it...

Also, something that can wrap (git commit && git svn dcommit) into one
step would be nice.

-- 
