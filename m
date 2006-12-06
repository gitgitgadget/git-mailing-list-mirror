X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: git UI nit
Date: Wed, 06 Dec 2006 17:04:18 +0100
Message-ID: <4576EA02.2010809@xs4all.nl>
References: <el6jmt$mej$1@sea.gmane.org> <Pine.LNX.4.63.0612061546190.28348@wbgn013.biozentrum.uni-wuerzburg.de> <4576DD27.6050307@xs4all.nl> <Pine.LNX.4.63.0612061619120.28348@wbgn013.biozentrum.uni-wuerzburg.de> <el6nul$58n$2@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 16:05:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 20
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <el6nul$58n$2@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33481>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrzGo-0000Zn-2Q for gcvg-git@gmane.org; Wed, 06 Dec
 2006 17:05:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936308AbWLFQFO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 11:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936313AbWLFQFO
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 11:05:14 -0500
Received: from main.gmane.org ([80.91.229.2]:34494 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S936308AbWLFQFM
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 11:05:12 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GrzGY-0004TF-Py for git@vger.kernel.org; Wed, 06 Dec 2006 17:05:02 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Wed, 06 Dec 2006 17:05:02 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006 17:05:02
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski escreveu:
> Johannes Schindelin wrote:
> 
>> On Wed, 6 Dec 2006, Han-Wen Nienhuys wrote:
>>
>>> Johannes Schindelin escreveu:
>>>>                     }
>>>>                     if (quiet)
>>>>                             continue;
>>>> -                   printf("%s: needs update\n", ce->name);
>>>> +                   printf("%s: dirty; needs commit\n", ce->name);
>>> Yes - I'd just mention revert as an option too. 
>> Actually, I like it that short.
> 
> So why not simply use "%s: dirty\n"?

because a newbie doesn't know how to resolve that problem.

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
