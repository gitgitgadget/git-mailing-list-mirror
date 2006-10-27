X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: fetching packs and storing them as packs
Date: Fri, 27 Oct 2006 05:20:53 +0200
Organization: At home
Message-ID: <ehrtt8$rm3$1@sea.gmane.org>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home> <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610261105200.12418@xanadu.home> <45413209.2000905@tromer.org> <Pine.LNX.4.64.0610262038320.11384@xanadu.home> <20061027014229.GA28407@spearce.org> <45417205.6020805@tromer.org> <20061027030054.GB28407@spearce.org> <BAYC1-PASMTP03992F75428088AF83AE39AE040@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 27 Oct 2006 03:20:44 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 23
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30285>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdIGr-0005Qw-2E for gcvg-git@gmane.org; Fri, 27 Oct
 2006 05:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946134AbWJ0DUe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 23:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161480AbWJ0DUe
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 23:20:34 -0400
Received: from main.gmane.org ([80.91.229.2]:49839 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1161479AbWJ0DUd (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 23:20:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GdIGZ-0005M2-RL for git@vger.kernel.org; Fri, 27 Oct 2006 05:20:19 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 27 Oct 2006 05:20:19 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 27 Oct 2006
 05:20:19 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Sean wrote:

> On Thu, 26 Oct 2006 23:00:54 -0400
> Shawn Pearce <spearce@spearce.org> wrote:
> 
>> What happens when the incoming pack (steps #2 and #3) takes 15
>> minutes to upload (slow ADSL modem, lots of objects) and the
>> background repack process sees those temporary refs and starts
>> trying to include those objects?  It can't walk the DAG that those
>> refs point at because the objects aren't in the current repository.
> 
> As long as there was standard naming for such temporary refs,
> they could be completely ignored by the repack process, no?

You meant I think: half ignored. Taken into account when finding
which parts are referenced to delete (-d part), but not complain
if they don't point to anything (validation).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

