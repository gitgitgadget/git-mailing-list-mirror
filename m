X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/4] git-svn: let libsvn_ls_fullurl return properties too
Date: Mon, 4 Dec 2006 17:04:28 -0800
Message-ID: <20061205010428.GA26687@soma>
References: <20061204235724.46FD7139B0C@magnus.utsl.gen.nz> <7v3b7vnqtv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 01:04:42 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v3b7vnqtv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33273>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrOjZ-0004hF-SR for gcvg-git@gmane.org; Tue, 05 Dec
 2006 02:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758394AbWLEBEb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 20:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967931AbWLEBEb
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 20:04:31 -0500
Received: from hand.yhbt.net ([66.150.188.102]:42521 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1758394AbWLEBEa
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 20:04:30 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 8869C2DC034; Mon,  4 Dec 2006 17:04:28 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon,  4 Dec 2006
 17:04:28 -0800
To: Sam Vilain <sam@vilain.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Thanks.
> 
> Please CC people who are primarily working on the part of the
> system you are improving.  In the case of git-svn that would be
> Eric Wong.

Yes, CCs regarding git-svn would be much appreciated, thanks.

> As I almost never touch git-svn myself, I'll queue these four
> changes in 'pu' while waiting Ack from Eric on them.

Ack on what the patches do, but not as-is.

Please fix the coding style so that it's consistent with the rest of
git-svn:

a) indentation is done with hard tabs
b) no spaces around parentheses: "if ($foo) {" vs "if ( $foo ) {"

Also, adding tests would be helpful in helping me maintain it (I'm not
a regular svk user, so I don't want to break anything you've done down
the line).

Thanks.

-- 
