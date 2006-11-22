X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Struggling with tangled
Date: Wed, 22 Nov 2006 20:40:00 +0100
Organization: At home
Message-ID: <ek28vh$f6f$1@sea.gmane.org>
References: <E1GmpTj-000235-2n@home.chandlerfamily.org.uk> <ek1aj0$u09$1@sea.gmane.org> <200611221915.59073.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 22 Nov 2006 19:38:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 37
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32095>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmxvf-0000Yg-4O for gcvg-git@gmane.org; Wed, 22 Nov
 2006 20:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751191AbWKVTij (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 14:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbWKVTij
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 14:38:39 -0500
Received: from main.gmane.org ([80.91.229.2]:63443 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1751191AbWKVTii (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 14:38:38 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GmxvX-0000Wy-Jv for git@vger.kernel.org; Wed, 22 Nov 2006 20:38:35 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 22 Nov 2006 20:38:35 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 22 Nov 2006
 20:38:35 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Alan Chandler wrote:

> On Wednesday 22 November 2006 11:01, Jakub Narebski wrote:
>> Alan Chandler wrote:

>>> 3) I sometime hit a merge conflict in a file which I know will actually
>>> be deleted at the tip of the topic I am rebasing.  Is there a way at this
>>> point to just tell the conflict resolution to say make this file go away.
>>
>> "git rm <filename>" plus "git update-index <filename>" doesn't work?
> 
> Well I _thought_ I tried git-update-index --remove and that hadn't worked.

I think "git update-index --force-remove" might be needed here.

>>> 4) I repeat the question I asked in a thread above.  What is the --merge
>>> switch on git-rebase actually do.  The man page starts talking about
>>> merge strategies, but there already is a -s switch for that.
>>
>> "git rebase" uses "git format-patch" + "git-am --3way" machinery by
>> default. The --merge option makes it use merge machinery instead (similar
>> to the way "git checkout -m" uses merge strategy IIRC).
> 
> Yes but ...
> 
> ... what does that mean in usage terms?
> 
> Why would I want to use one rather than the other?

Merge machinery can detect renames. I don't know if merge machinery supports
skipping over commits. The format-patch/am --3way machinery was first (and
is default).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

