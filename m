X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH 4/10] Add current branch in PS1 support to
 git-completion.bash.
Date: Mon, 27 Nov 2006 12:45:41 -0500
Message-ID: <BAYC1-PASMTP11F1E3F750BA675B27EC9EAEE60@CEZ.ICE>
References: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org>
	<20061127084128.GD19745@spearce.org>
	<20061127103111.4835bffc.seanlkml@sympatico.ca>
	<20061127165122.GB6616@spearce.org>
	<20061127122653.3e801d7a.seanlkml@sympatico.ca>
	<20061127173136.GD6616@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 17:46:05 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061127124541.5fdabb4c.seanlkml@sympatico.ca>
In-Reply-To: <20061127173136.GD6616@spearce.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Nov 2006 17:55:32.0468 (UTC) FILETIME=[3B93EB40:01C7124D]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GokYG-0008Jp-HI for gcvg-git@gmane.org; Mon, 27 Nov
 2006 18:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758442AbWK0Rpp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 12:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758447AbWK0Rpp
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 12:45:45 -0500
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:13402 "EHLO
 BAYC1-PASMTP11.CEZ.ICE") by vger.kernel.org with ESMTP id S1758442AbWK0Rpn
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 12:45:43 -0500
Received: from linux1.attic.local ([65.93.43.74]) by BAYC1-PASMTP11.CEZ.ICE
 over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); Mon, 27 Nov
 2006 09:55:32 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1Gojbw-0006uU-7d; Mon, 27 Nov 2006 11:45:40 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Mon, 27 Nov 2006 12:31:36 -0500
Shawn Pearce <spearce@spearce.org> wrote:

> I did that.  :-)
> 
> If you read the implementation of __git_ps1 the default format is
> " (%s)" but you can pass anything you want as the first parameter.

lol, you're good.  I'm back to thinking it's slightly misnamed though,
as that %s can only ever mean branch.  But it's really a minor nit,
sorry for the noise.  Good work.

