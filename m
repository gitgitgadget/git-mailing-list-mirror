X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: StGit repo & gitweb, was Re: [PATCH] merge-recursive: add/add really
 is modify/modify with an empty base
Date: Wed, 13 Dec 2006 12:46:56 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612131232270.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061207101707.GA19139@spearce.org>
 <Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612122347590.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvekgog0r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612130402300.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvekgl2z2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 13 Dec 2006 11:47:09 +0000 (UTC)
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Petr Baudis <pasky@suse.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vvekgl2z2.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34212>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuSZn-000796-4m for gcvg-git@gmane.org; Wed, 13 Dec
 2006 12:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964858AbWLMLq7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 06:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWLMLq7
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 06:46:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:45195 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S964858AbWLMLq6
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 06:46:58 -0500
Received: (qmail invoked by alias); 13 Dec 2006 11:46:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp029) with SMTP; 13 Dec 2006 12:46:57 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 12 Dec 2006, Junio C Hamano wrote:

> Although I would feel very happy about this change, Catalin
> might want to be informed about potential interaction this
> change might have with his commit 8d41555 in StGIT.

Indeed. Catalin, do you have any suggestion how to proceed? Do you want to 
introduce a check if the file exists prior to re-generating it? Or do you 
need some version check?

BTW why is StGit not on kernel.org?

Not that it matters: repo.or.cz has a nice mirror. Pasky, how powerful is 
that machine? I am a happy user of the gitweb interface on that box...

Yet another question: On repo.or.cz, I searched for the "commit" "8d41555" 
(upper right side, very nice, although the search button is lacking, which 
is needed for some browsers like w3m). But I got _two_ results, the one I 
expected, and its child (probably because it contains the sha1 as part of 
the parent tag). Is this intended behaviour? After all, I search for the 
commit...

Ciao,
Dscho
