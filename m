X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Bash completion Issue?
Date: Sun, 5 Nov 2006 00:33:07 +0000
Message-ID: <200611050033.07716.alan@chandlerfamily.org.uk>
References: <200611041236.59989.alan@chandlerfamily.org.uk> <20061104184120.GB2311@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 5 Nov 2006 00:33:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <20061104184120.GB2311@spearce.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30943>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgVxC-0002qW-Me for gcvg-git@gmane.org; Sun, 05 Nov
 2006 01:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965763AbWKEAdd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 19:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965764AbWKEAdc
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 19:33:32 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:20871 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S965763AbWKEAdc (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4
 Nov 2006 19:33:32 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1GgVx5-0007nI-09 for git@vger.kernel.org; Sun, 05 Nov 2006 00:33:31 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Saturday 04 November 2006 18:41, Shawn Pearce wrote:
> Alan Chandler <alan@chandlerfamily.org.uk> wrote:
...
> > In debian, there seems to be a directory /etc/bash_completion.d with
> > files for each of the packages, and the debian git packages have entries
> > in there.  So I assume they are derived from the completion work
> > mentioned on this list.
>
> What completion script is it?  The one that is now shipped as part
> of Git has a header of the following, and resides in git.git as
> contrib/completion/git-completion.bash:
>
> 	#
> 	# bash completion support for core Git.
> 	#
> 	# Copyright (C) 2006 Shawn Pearce
> 	# Conceptually based on gitcompletion (http://gitweb.hawaga.org.uk/).
> 	#

Well I have something like this (with git 1.4.3.3)

# 'git' bash completion and library routines used by porcelain completions.
#
# Copyright (c) Paolo Giarrusso, 2005
# Copyright (c) Ben Clifford, 2005
#
# The master version is available at:
#       http://www.hawaga.org.uk/gitcompletion.git


>
> > What seems strange to me is that nobody else has mentioned this before
> > now.
>
> Maybe because you have a different completion script?

Seems like it might be:-(


-- 
Alan Chandler
