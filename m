X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Document git-diff whitespace flags -b and -w
Date: Sun, 03 Dec 2006 19:38:55 +0100
Organization: At home
Message-ID: <ekv5k6$1ih$1@sea.gmane.org>
References: <11651630814064-git-send-email-jnareb@gmail.com> <Pine.LNX.4.63.0612031908020.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 3 Dec 2006 18:39:27 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 22
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33127>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqwFJ-0002Nv-8q for gcvg-git@gmane.org; Sun, 03 Dec
 2006 19:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759974AbWLCSjW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 13:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759975AbWLCSjW
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 13:39:22 -0500
Received: from main.gmane.org ([80.91.229.2]:62923 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1759974AbWLCSjV (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 13:39:21 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GqwF4-0008Nv-VU for git@vger.kernel.org; Sun, 03 Dec 2006 19:39:10 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 03 Dec 2006 19:39:10 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 03 Dec 2006
 19:39:10 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> On Sun, 3 Dec 2006, Jakub Narebski wrote:
> 
>> +--ignore-space-change::
>> +    Ignore changes in amount of white space.  This ignores white
>> +    space at line end, and consider all other sequences of one or
>> +    more white space characters to be equivalent.
> 
> Thank you for bringing this up. The latter part is correct, but the first 
> part not yet. I asked at the time if somebody cares, but got no answer, so 
> "-b" does _not_ ignore white space at the end of line ATM, but only white 
> space change. So here is a patch to fix that behaviour:

Alternate solution would be to fix documentation, to document existing code.
I used GNU diff documentation, perhaps it is better if we are GNU diff
compatibile...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

