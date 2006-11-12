X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Anand Kumria" <wildfire@progsoc.org>
Subject: should git download missing objects?
Date: Sun, 12 Nov 2006 15:44:25 +0000 (UTC)
Message-ID: <ej7fgp$8ca$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Sun, 12 Nov 2006 15:44:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 22
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: backup.global.cn
User-Agent: pan 0.117 (We'll fly and we'll fall and we'll burn)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31262>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjHVu-0002nb-HL for gcvg-git@gmane.org; Sun, 12 Nov
 2006 16:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932932AbWKLPot (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 10:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932935AbWKLPot
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 10:44:49 -0500
Received: from main.gmane.org ([80.91.229.2]:14496 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S932934AbWKLPos (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 10:44:48 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GjHVl-0002l4-CX for git@vger.kernel.org; Sun, 12 Nov 2006 16:44:46 +0100
Received: from backup.global.cn ([195.224.169.69]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Sun, 12 Nov 2006 16:44:45 +0100
Received: from wildfire by backup.global.cn with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 12 Nov 2006 16:44:45
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

I did an initial clone of Linus' linux-2.6.git tree, via the git protocol,
and then managed to accidently delete one of the .pack and
corresponding .idx files.

I thought that 'cg-fetch' would do the job of bring down the missing pack
again, and all would be well. Alas this isn't the case.

<http://pastebin.ca/246678>

Pasky, on IRC, indicated that this might be because git-fetch-pack isn't
downloading missing objects when the git:// protocol is being used.

Should it? Is there a magic invocation of git fetch I can use to fix this
up. I can always re-clone completely (since this is just a tracking repo)
but it would be nice to fix this with the tools themselves.

Any hints?

Thanks,
Anand
