X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: StGit repo & gitweb, was Re: [PATCH] merge-recursive: add/add really  is modify/modify with an empty base
Date: Tue, 19 Dec 2006 20:39:25 +0100
Organization: At home
Message-ID: <em9f0e$iti$1@sea.gmane.org>
References: <20061207101707.GA19139@spearce.org> <Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de> <7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612122347590.2807@wbgn013.biozentrum.uni-wuerzburg.de> <7vvekgog0r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612130402300.2807@wbgn013.biozentrum.uni-wuerzburg.de> <7vvekgl2z2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612131232270.3635@wbgn013.biozentrum.uni-wuerzburg.de> <20061219185015.GK9399@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 19 Dec 2006 19:37:40 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 21
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34844>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwkmH-0005jz-CZ for gcvg-git@gmane.org; Tue, 19 Dec
 2006 20:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932918AbWLSTh0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 14:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932919AbWLSTh0
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 14:37:26 -0500
Received: from main.gmane.org ([80.91.229.2]:39513 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932918AbWLSThZ
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 14:37:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gwkly-0002o9-9i for git@vger.kernel.org; Tue, 19 Dec 2006 20:37:11 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 19 Dec 2006 20:37:10 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 19 Dec 2006
 20:37:10 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Petr Baudis wrote:

> On Wed, Dec 13, 2006 at 12:46:56PM CET, Johannes Schindelin wrote:
>> Not that it matters: repo.or.cz has a nice mirror. Pasky, how powerful is 
>> that machine? I am a happy user of the gitweb interface on that box...
> 
> See http://repo.or.cz/about.html - two-processor P3 800MHz with 2G RAM,
> and it does quite some work besides doing repo.or.cz as well - there are
> no load problems so far, though. The gitweb load in particular is pretty
> low, though - I think it's about 350 requests per day; the periodical
> mirroring is far more intensive, but the intervals for this could be
> reduced greatly if that would become a problem.

Do you do "git repack -a -d" (and "git prune-packed"), or do you use
some kept packs?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

