X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: stgit: No patches to pop
Date: Mon, 11 Dec 2006 17:20:34 +0100
Organization: At home
Message-ID: <elk0c3$ovu$1@sea.gmane.org>
References: <7ac1e90c0612110632x56a2917cu4db33e47923f34c2@mail.gmail.com> <tnxpsaqwgxl.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 11 Dec 2006 16:18:39 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 22
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34012>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtnrM-00033r-U5 for gcvg-git@gmane.org; Mon, 11 Dec
 2006 17:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936981AbWLKQS2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 11:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937016AbWLKQS2
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 11:18:28 -0500
Received: from main.gmane.org ([80.91.229.2]:52875 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S936981AbWLKQS1
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 11:18:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gtnr7-00022T-F1 for git@vger.kernel.org; Mon, 11 Dec 2006 17:18:17 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 17:18:17 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 11 Dec 2006
 17:18:17 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Catalin Marinas wrote:

>> I also get things like:
>>
>> % stg pop second
>> popping patch "third"... done
>> Now at patch "second"
> 
> In version 0.11, the "pop" command is equivalent to "goto". I changed
> this in the latest version (in the StGIT repository) so that "pop
> <patch>" tries to only extract that patch from the stack by popping
> all the patches to the given one and pushing them back without the one
> you specified. It also supports patch ranges (i.e. patch1..patch4).

That is kind of strange. Pop should work like pop does, for example
the one in Perl or Python, removing n elements from the stack of applied
patches. Not work as "float <patch>"...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

