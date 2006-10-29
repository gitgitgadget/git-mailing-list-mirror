X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [PATCH 3/3] Teach git-index-pack how to keep a pack file.
Date: Sun, 29 Oct 2006 21:44:12 +0200
Message-ID: <20061029194412.GA3346@mellanox.co.il>
References: <7vr6wr0wa7.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 19:42:28 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vr6wr0wa7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30447>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeGXr-0002UH-Di for gcvg-git@gmane.org; Sun, 29 Oct
 2006 20:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965357AbWJ2TmH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 14:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965358AbWJ2TmH
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 14:42:07 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:42897 "EHLO
 dev.mellanox.co.il") by vger.kernel.org with ESMTP id S965357AbWJ2TmE (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 14:42:04 -0500
Received: from mellanox.co.il ([194.90.237.34]) by dev.mellanox.co.il
 (8.13.1/8.13.1) with SMTP id k9TJfS4j030651; Sun, 29 Oct 2006 21:41:29 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Sun, 29 Oct 2006
 21:44:12 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Quoting r. Junio C Hamano <junkio@cox.net>:
> It might be a good idea to leave process ID of the caller of the
> index-pack as part of --keep="reason" string, along with the
> timestamp to help the user decide if the .keep is leftover or
> still in progress (the timestamp can be seen from ls -l *.keep
> so it is not strictly needed).

Add hostname to that, for repositories that reside on networked file systems.

-- 
