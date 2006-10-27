X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Ben Clifford <benc@hawaga.org.uk>
Subject: Re: StGit-enabled bash-prompt
Date: Fri, 27 Oct 2006 10:01:15 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0610270957020.9123@dildano.hawaga.org.uk>
References: <200610262317.30209.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 27 Oct 2006 10:02:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authentication-Warning: dildano.hawaga.org.uk: benc owned process doing -bs
In-Reply-To: <200610262317.30209.robin.rosenberg.lists@dewire.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30320>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdOXq-0005Vx-Qj for gcvg-git@gmane.org; Fri, 27 Oct
 2006 12:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946306AbWJ0KCV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 06:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946307AbWJ0KCV
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 06:02:21 -0400
Received: from [81.187.211.37] ([81.187.211.37]:34447 "EHLO
 dildano.hawaga.org.uk") by vger.kernel.org with ESMTP id S1946306AbWJ0KCV
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 06:02:21 -0400
Received: from dildano.hawaga.org.uk (dildano.hawaga.org.uk [127.0.0.1]) by
 dildano.hawaga.org.uk (8.13.6/8.13.6/Debian-1) with ESMTP id k9RA1Fi0016801;
 Fri, 27 Oct 2006 10:01:15 GMT
Received: from localhost (benc@localhost) by dildano.hawaga.org.uk
 (8.13.6/8.13.6/Submit) with ESMTP id k9RA1Frf016797; Fri, 27 Oct 2006
 10:01:15 GMT
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org


On Thu, 26 Oct 2006, Robin Rosenberg wrote:

> Of course you will read and understand this code. I don't know how good an 
> idea it is to use the DEBUG trap this way.

I set my prompt without using it, with something approximating this
being defined in my .bash_profile. I think the use of ' instead of " 
causes evaluation of __prompt_githead be delayed until the prompt is 
displayed.


  PS1='$(__prompt_githead) '$PS1

  __prompt_githead() {
  PS_GIT=$(git-symbolic-ref HEAD 2>/dev/null) || exit
  echo -n " $(basename $PS_GIT)" 
  }

-- 
