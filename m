X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: StGit repo & gitweb, was Re: [PATCH] merge-recursive: add/add really  is modify/modify with an empty base
Date: Tue, 19 Dec 2006 19:50:15 +0100
Message-ID: <20061219185015.GK9399@pasky.or.cz>
References: <20061207101707.GA19139@spearce.org> <Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de> <7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612122347590.2807@wbgn013.biozentrum.uni-wuerzburg.de> <7vvekgog0r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612130402300.2807@wbgn013.biozentrum.uni-wuerzburg.de> <7vvekgl2z2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612131232270.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 18:57:13 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Catalin Marinas <catalin.marinas@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 13:56:57 EST
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612131232270.3635@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34839>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwk9B-0004bf-BP for gcvg-git@gmane.org; Tue, 19 Dec
 2006 19:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932849AbWLSS46 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 13:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932894AbWLSS46
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 13:56:58 -0500
Received: from w241.dkm.cz ([62.24.88.241]:42974 "EHLO machine.or.cz"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932849AbWLSS46
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 13:56:58 -0500
Received: (qmail 4350 invoked by uid 2001); 19 Dec 2006 19:50:15 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Wed, Dec 13, 2006 at 12:46:56PM CET, Johannes Schindelin wrote:
> Not that it matters: repo.or.cz has a nice mirror. Pasky, how powerful is 
> that machine? I am a happy user of the gitweb interface on that box...

See http://repo.or.cz/about.html - two-processor P3 800MHz with 2G RAM,
and it does quite some work besides doing repo.or.cz as well - there are
no load problems so far, though. The gitweb load in particular is pretty
low, though - I think it's about 350 requests per day; the periodical
mirroring is far more intensive, but the intervals for this could be
reduced greatly if that would become a problem.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
