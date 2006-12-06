X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git UI nit
Date: Wed, 06 Dec 2006 16:36:54 +0100
Organization: At home
Message-ID: <el6nul$58n$2@sea.gmane.org>
References: <el6jmt$mej$1@sea.gmane.org> <Pine.LNX.4.63.0612061546190.28348@wbgn013.biozentrum.uni-wuerzburg.de> <4576DD27.6050307@xs4all.nl> <Pine.LNX.4.63.0612061619120.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 6 Dec 2006 15:35:30 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 30
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33475>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gryni-00041c-25 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 16:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935644AbWLFPfK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 10:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935706AbWLFPfJ
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 10:35:09 -0500
Received: from main.gmane.org ([80.91.229.2]:55282 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S935644AbWLFPfH
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 10:35:07 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrynR-0000nm-MB for git@vger.kernel.org; Wed, 06 Dec 2006 16:34:57 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 16:34:57 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006
 16:34:57 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> On Wed, 6 Dec 2006, Han-Wen Nienhuys wrote:
> 
>> Johannes Schindelin escreveu:
>>>                     }
>>>                     if (quiet)
>>>                             continue;
>>> -                   printf("%s: needs update\n", ce->name);
>>> +                   printf("%s: dirty; needs commit\n", ce->name);
>> 
>> Yes - I'd just mention revert as an option too. 
> 
> Actually, I like it that short.

So why not simply use "%s: dirty\n"?
 
> We had an email on this list, where the poster said he could not merge 
> with Git. It turned out that the merge failed with conflicts, but he 
> did not bother reading through the messages, apparently because they were 
> too many.

Some of that stems from the "pipeline" model / implementation of git
commands, where every separate stage spews it's own warning and error
messages.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

