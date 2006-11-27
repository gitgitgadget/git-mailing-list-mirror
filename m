X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Vilz <niv@iaglans.de>
Subject: Re: [PATCH 9/10] Allow completion of --committer and --author arguments to git log.
Date: Mon, 27 Nov 2006 11:28:32 +0100
Message-ID: <20061127102831.GA5428@fry.bender.fht>
References: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org> <20061127084228.GI19745@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 10:28:56 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061127084228.GI19745@spearce.org>
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at hs-esslingen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32408>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GodjB-0005UX-3K for gcvg-git@gmane.org; Mon, 27 Nov
 2006 11:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757806AbWK0K2m (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 05:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757824AbWK0K2m
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 05:28:42 -0500
Received: from mail.hs-esslingen.de ([134.108.32.78]:59274 "EHLO
 mail.hs-esslingen.de") by vger.kernel.org with ESMTP id S1757801AbWK0K2l
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 05:28:41 -0500
Received: from localhost (mail.hs-esslingen.de [134.108.32.78]) by
 mail.hs-esslingen.de (Postfix) with ESMTP id 7F4CF13E74; Mon, 27 Nov 2006
 11:28:39 +0100 (CET)
Received: from mail.hs-esslingen.de ([134.108.32.78]) by localhost (rslx211
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 14807-05; Mon, 27 Nov
 2006 11:28:33 +0100 (CET)
Received: from localhost (ovpngp2198.hs-esslingen.de [134.108.122.198])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by mail.hs-esslingen.de (Postfix) with ESMTP id
 4492913E2B; Mon, 27 Nov 2006 11:28:33 +0100 (CET)
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Mon, Nov 27, 2006 at 03:42:28AM -0500, Shawn O. Pearce wrote:
> This is just a cute hack, but we can (easily) complete the parameter
> to --author or --committer in bash by asking for all possible authors
> or committers in this project from git log and offering them up as
> valid choices.
> 
> We replace spaces with dots as this prevents names with spaces from
> appearing as two parameters rather than one, yet it still matches the
> space in the field.
is it hard to train bash-completion to use "" and spaces instead of 
replacing spaces by dots? Besides, great feature, thank you for that... 
that's very handy.

Sincerly
