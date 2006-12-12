X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-pull from git.git - no remote ref for pu or next?
Date: Tue, 12 Dec 2006 20:15:41 +0100
Organization: At home
Message-ID: <elmv0c$kmd$1@sea.gmane.org>
References: <863b7l83o9.fsf@blue.stonehenge.com> <86y7pd6oz7.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612120949230.3535@woody.osdl.org> <Pine.LNX.4.63.0612121908100.2807@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0612121352520.18171@xanadu.home> <Pine.LNX.4.63.0612121956470.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 12 Dec 2006 19:13:51 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 16
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34131>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuD4X-000887-Eh for gcvg-git@gmane.org; Tue, 12 Dec
 2006 20:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932376AbWLLTNn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 14:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWLLTNn
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 14:13:43 -0500
Received: from main.gmane.org ([80.91.229.2]:46373 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932376AbWLLTNm
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 14:13:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GuD4E-0004Hh-2C for git@vger.kernel.org; Tue, 12 Dec 2006 20:13:30 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 20:13:30 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 12 Dec 2006
 20:13:30 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> But it would become a non-problem when the HTTP transport would learn to 
> read and interpret the .idx files, basically constructing thin packs from 
> parts of the .pack files ("Content-Range:" comes to mind)...

cURL the CLI can do this with -r/--range option, so I think that curl
the library can do this too. Mind you, this is HTTP/1.1 extension
(hmmm... I wonder if many sites run HTTP/1.0 only).

See also: http://www.linux.com/article.pl?sid=06/10/10/1824245
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

