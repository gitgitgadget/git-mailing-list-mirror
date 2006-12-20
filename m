X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Change in git-svn dcommit semantics?
Date: Wed, 20 Dec 2006 12:38:57 +0100
Organization: At home
Message-ID: <emb77h$cf2$1@sea.gmane.org>
References: <m2mz5jegka.fsf@ziti.local> <94FF72E0-F8BD-4773-803E-F179754BF0ED@silverinsanity.com> <Pine.LNX.4.63.0612200053550.19693@wbgn013.biozentrum.uni-wuerzburg.de> <C2881A17-27F7-467C-B353-189BB7DBFD1E@silverinsanity.com> <7v3b7bnz6q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 20 Dec 2006 11:36:51 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34916>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwzkb-0004iU-DQ for gcvg-git@gmane.org; Wed, 20 Dec
 2006 12:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964994AbWLTLgm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 06:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWLTLgm
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 06:36:42 -0500
Received: from main.gmane.org ([80.91.229.2]:41946 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S964994AbWLTLgl
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006 06:36:41 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GwzkH-0003aY-4f for git@vger.kernel.org; Wed, 20 Dec 2006 12:36:25 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 20 Dec 2006 12:36:25 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 20 Dec 2006
 12:36:25 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Brian Gernhardt <benji@silverinsanity.com> writes:
> 
>> And is there an easier way to find these things than "git rev-list
>> HEAD | git diff-tree -r -s --stdin -SCOLLISION | xargs git show"?  I
>> cobbled that together from poking around inside gitk (which mostly
>> works in OS X, but has some issues that make me prefer the command
>> line).
> 
> I typically do:
> 
>       git log --full-diff -p -SCOLLISION
> 
> The --full-diff option helps because it shows the diff for other
> files (that do not have different number of substring COLLISION
> in the pre and postimage) in the same commit as well.

Yet another undocumented option. Sigh...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

