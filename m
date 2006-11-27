X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH 4/10] Add current branch in PS1 support to
 git-completion.bash.
Date: Mon, 27 Nov 2006 10:31:11 -0500
Message-ID: <BAYC1-PASMTP02E79ADEE48804655B6FC8AEE60@CEZ.ICE>
References: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org>
	<20061127084128.GD19745@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 15:31:47 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061127103111.4835bffc.seanlkml@sympatico.ca>
In-Reply-To: <20061127084128.GD19745@spearce.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Nov 2006 15:31:12.0676 (UTC) FILETIME=[11F08640:01C71239]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoiRy-0007KV-4F for gcvg-git@gmane.org; Mon, 27 Nov
 2006 16:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758285AbWK0PbO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 10:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758288AbWK0PbO
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 10:31:14 -0500
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:38736 "EHLO
 BAYC1-PASMTP02.CEZ.ICE") by vger.kernel.org with ESMTP id S1758282AbWK0PbN
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 10:31:13 -0500
Received: from linux1.attic.local ([65.93.43.74]) by BAYC1-PASMTP02.CEZ.ICE
 over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); Mon, 27 Nov
 2006 07:31:12 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GohVl-0006gg-NQ; Mon, 27 Nov 2006 09:31:09 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Mon, 27 Nov 2006 03:41:28 -0500
"Shawn O. Pearce" <spearce@spearce.org> wrote:

> Many users want to display the current branch name of the current git
> repository as part of their PS1 prompt, much as their PS1 prompt might
> also display the current working directory name.
> 
> We don't force our own PS1 onto the user.  Instead we let them craft
> their own PS1 string and offer them the function __git_ps1 which they
> can invoke to obtain either "" (when not in a git repository) or
> "(%s)" where %s is the name of the current branch, as read from HEAD,
> with the leading refs/heads/ removed.

Suppose it doesn't hurt to include support for this in git completion
scripts.  It doesn't look like __git_ps1 is a proper name though,
perhaps __git_branch or __git_current_branch would be better?

