X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Some advanced index playing
Date: Sun, 3 Dec 2006 20:40:12 +0000
Message-ID: <200612032040.13100.alan@chandlerfamily.org.uk>
References: <200612031701.15594.alan@chandlerfamily.org.uk> <Pine.LNX.4.64.0612031024480.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 3 Dec 2006 20:40:38 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0612031024480.3476@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33140>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqy8Y-0004gz-Mj for gcvg-git@gmane.org; Sun, 03 Dec
 2006 21:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760079AbWLCUkb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 15:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760080AbWLCUkb
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 15:40:31 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:43932 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S1760079AbWLCUkb (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3
 Dec 2006 15:40:31 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1Gqy8T-0000WX-3M; Sun, 03 Dec 2006 20:40:29 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Sunday 03 December 2006 18:34, Linus Torvalds wrote:
...
> So in short, you should just have done "git reset", and you'd have
> reset your index back to the state of your last commit.
>
> So "git reset" is generally your friend whenever something goes
> wrong. If you also want to reset your checked-out files (which you
> did NOT want to do in this case, of course), you would have added the
> "--hard" flag to git reset.

Doh [slaps head with wet blanket]

I was so worried about NOT changing my working tree - I totally 
overlooked the reset command.  I had never quite understood 
what --mixed really meant before.  But re-reading the man page now, its 
obvious.



-- 
Alan Chandler
