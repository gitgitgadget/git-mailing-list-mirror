X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: StGit repo & gitweb, was Re: [PATCH] merge-recursive: add/add really is modify/modify with an empty base
Date: Wed, 13 Dec 2006 12:56:37 +0100
Organization: At home
Message-ID: <elopl4$3nk$1@sea.gmane.org>
References: <20061207101707.GA19139@spearce.org> <Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de> <7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612122347590.2807@wbgn013.biozentrum.uni-wuerzburg.de> <7vvekgog0r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612130402300.2807@wbgn013.biozentrum.uni-wuerzburg.de> <7vvekgl2z2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612131232270.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 13 Dec 2006 11:55:03 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 24
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34213>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuShG-0007yz-CO for gcvg-git@gmane.org; Wed, 13 Dec
 2006 12:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964863AbWLMLyn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 06:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWLMLyn
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 06:54:43 -0500
Received: from main.gmane.org ([80.91.229.2]:36862 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S964863AbWLMLym
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 06:54:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GuSgw-00075h-HY for git@vger.kernel.org; Wed, 13 Dec 2006 12:54:30 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 13 Dec 2006 12:54:30 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 13 Dec 2006
 12:54:30 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> Yet another question: On repo.or.cz, I searched for the "commit" "8d41555" 
> (upper right side, very nice, although the search button is lacking, which 
> is needed for some browsers like w3m). 

The problem is where to put it. The previous version didn't even had the
"select type" but used [undocumented] search operators 'author:',
'committer:' and 'pickaxe:'.

>                                        But I got _two_ results, the one I  
> expected, and its child (probably because it contains the sha1 as part of 
> the parent tag). Is this intended behaviour? After all, I search for the 
> commit...

Actually, "commit" is a bit of misnomer, as it searches commits contents
(commit body). You can go to given commit easier by hand editing URL,
editing "a=commit;h=8d41555".

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

