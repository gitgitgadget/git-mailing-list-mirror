From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH 0/4] drop some "int x = x" hacks to silence gcc warnings
Date: Thu, 21 Mar 2013 14:44:51 +0100
Message-ID: <kif2so$2ug$1@ger.gmane.org>
References: <20130321110338.GA18552@sigill.intra.peff.net> <514AF2E1.7020409@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 21 14:45:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIfoP-0006e0-Ml
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 14:45:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757531Ab3CUNpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 09:45:16 -0400
Received: from plane.gmane.org ([80.91.229.3]:42906 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756329Ab3CUNpP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 09:45:15 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UIfoD-0006V0-P8
	for git@vger.kernel.org; Thu, 21 Mar 2013 14:45:33 +0100
Received: from dsdf-4d0a073f.pool.mediaways.net ([77.10.7.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 14:45:33 +0100
Received: from jojo by dsdf-4d0a073f.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 14:45:33 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4d0a073f.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218727>

Johannes Sixt wrote:
> Am 3/21/2013 12:03, schrieb Jeff King:
>> I was fooling around with clang and noticed that it complains about
>> the "int x = x" construct under -Wall. That is IMHO a deficiency in
>> clang, since the idiom has a well-defined use in silencing
>> -Wuninitialized warnings.
>
> IMO, that's a myth. The construct invokes undefined behavior at least
> since C99, and the compilers are right to complain about it.

And I complained about this a couple months ago, as the compiler on 
HP-NonStop stumbles across this too (by emitting a warning)

Bye, Jojo 
