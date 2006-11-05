X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Bash completion Issue?
Date: Sun, 5 Nov 2006 09:30:23 +0000
Message-ID: <200611050930.23455.alan@chandlerfamily.org.uk>
References: <200611041236.59989.alan@chandlerfamily.org.uk> <200611050033.07716.alan@chandlerfamily.org.uk> <20061105042849.GA3840@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 5 Nov 2006 09:31:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <20061105042849.GA3840@spearce.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30961>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgeLO-0001wt-1H for gcvg-git@gmane.org; Sun, 05 Nov
 2006 10:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932596AbWKEJav (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 04:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbWKEJav
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 04:30:51 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:22949 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S932596AbWKEJav (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5
 Nov 2006 04:30:51 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1GgeL3-0000Zr-QE for git@vger.kernel.org; Sun, 05 Nov 2006 09:30:49 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Sunday 05 November 2006 04:28, Shawn Pearce wrote:

> Maybe you can nicely ask the Debian maintainer to switch to using
> use the completion script that is actually shipped with git 1.4.3.3?

It seems to be a little bit more subtle than I first thought.

There is a separate 'git-completion' package which is not maintained by the 
git maintainer (Gerrit Pape) and which has not been updated since August. Its 
this package that contains the scripts.

I'll file a bug report against it.
-- 
Alan Chandler
