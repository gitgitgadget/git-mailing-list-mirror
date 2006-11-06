X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: fork0@t-online.de (Alex Riesen)
Subject: Re: Merge branch to directory of other branch.
Date: Mon, 6 Nov 2006 22:49:01 +0100
Message-ID: <20061106214901.GA25623@steel.home>
References: <1d592d70611061001n6d6f7aa8tbd34a45c5d968eab@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 6 Nov 2006 21:49:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <1d592d70611061001n6d6f7aa8tbd34a45c5d968eab@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-ID: XKfPavZB8e1gs9Kkfr0+Ebinz4p+99rUMuemOy6aRzICsKAwIuyKrQ
X-TOI-MSGID: 722fd9e6-d51c-4d1c-891f-74c713d40b48
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31026>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhCLI-00083L-IG for gcvg-git@gmane.org; Mon, 06 Nov
 2006 22:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753208AbWKFVtP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 16:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753785AbWKFVtP
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 16:49:15 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:55970 "EHLO
 mailout02.sul.t-online.com") by vger.kernel.org with ESMTP id
 S1753208AbWKFVtO (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006
 16:49:14 -0500
Received: from fwd30.aul.t-online.de  by mailout02.sul.t-online.com with smtp
  id 1GhCLA-0004sd-05; Mon, 06 Nov 2006 22:49:12 +0100
Received: from tigra.home
 (XKfPavZB8e1gs9Kkfr0+Ebinz4p+99rUMuemOy6aRzICsKAwIuyKrQ@[84.163.92.120]) by
 fwd30.sul.t-online.de with esmtp id 1GhCL2-1EJ4S00; Mon, 6 Nov 2006 22:49:04
 +0100
Received: from steel.home (steel.home [192.168.1.2]) by tigra.home (Postfix)
 with ESMTP id E79F6277AF; Mon,  6 Nov 2006 22:49:03 +0100 (CET)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian)) id
 1GhCKz-0006gZ-90; Mon, 06 Nov 2006 22:49:01 +0100
To: Kirill Shutemov <k.shutemov@gmail.com>
Sender: git-owner@vger.kernel.org

Kirill Shutemov, Mon, Nov 06, 2006 19:01:02 +0100:
> I have one branch with full content and other branch with one
> directory from first branch. How can I merge this branches?

Assuming they are related:

    git checkout -b merged full
    git pull . one-directory

