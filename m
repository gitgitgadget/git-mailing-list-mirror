X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-pull from git.git - no remote ref for pu or next?
Date: Tue, 12 Dec 2006 20:18:06 +0100
Organization: At home
Message-ID: <elmv4t$kmd$2@sea.gmane.org>
References: <863b7l83o9.fsf@blue.stonehenge.com> <86y7pd6oz7.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612120949230.3535@woody.osdl.org> <Pine.LNX.4.63.0612121908100.2807@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0612121021270.3535@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 12 Dec 2006 19:20:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 28
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34132>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuDAo-0000hk-JN for gcvg-git@gmane.org; Tue, 12 Dec
 2006 20:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932382AbWLLTUL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 14:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWLLTUK
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 14:20:10 -0500
Received: from main.gmane.org ([80.91.229.2]:57739 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932385AbWLLTUH
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 14:20:07 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GuDAY-0005ZU-56 for git@vger.kernel.org; Tue, 12 Dec 2006 20:20:02 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 20:20:02 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 12 Dec 2006
 20:20:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:

> On Tue, 12 Dec 2006, Johannes Schindelin wrote:
>> > rsync generally _works_ apart from the slight race-condition issue, 
>> 
>> ... and git would probably change the pack structure (i.e. which objects 
>> are in which packs, or even loose) which would be too bad for all those 
>> HTTP leechers ...
> 
> Well, as it is, I end up repacking my git archives on kernel.org every two 
> weeks or so anyway, so anybody who uses stupid protocols (rsync or http) 
> will end up downloading everything anew anyway.

What about "logaritmic packs" idea someone (Pasky?) posted on git mailing
list: pack from last week, pack from last month except last week, pack from
two months, pack from four months, pack from last year...

> And kernel.org will probably start doing automatic repacking, since the 
> current situation just means that some people don't repack on their own, 
> and have tens of thousands of loose objects.

...with *.keep to keep archive packs it can be even automated somewhat.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

