From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCHv2 1/8] Makefile: apply dependencies consistently to sparse/asm targets
Date: Thu, 21 Jun 2012 01:00:50 +0200
Message-ID: <87ipeltwpp.fsf@thomas.inf.ethz.ch>
References: <20120619232231.GA6328@sigill.intra.peff.net>
	<20120619232310.GA6496@sigill.intra.peff.net>
	<20120620035015.GA4213@burratino>
	<20120620042607.GA10414@sigill.intra.peff.net>
	<20120620102750.GB4579@burratino>
	<20120620163714.GB12856@sigill.intra.peff.net>
	<20120620182855.GA26948@sigill.intra.peff.net>
	<7vk3z1u4lw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 01:01:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShTtS-00081z-0t
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 01:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757601Ab2FTXAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 19:00:54 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:19319 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754743Ab2FTXAx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 19:00:53 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 21 Jun
 2012 01:00:47 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 21 Jun
 2012 01:00:50 +0200
In-Reply-To: <7vk3z1u4lw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 20 Jun 2012 13:10:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200375>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>   [01/11]: Makefile: sort LIB_H list
>>   [02/11]: Makefile: fold MISC_H into LIB_H
>>   [03/11]: Makefile: do not have git.o depend on common-cmds.h
>>   [04/11]: Makefile: apply dependencies consistently to sparse/asm targets
>>   [05/11]: Makefile: do not replace @@GIT_USER_AGENT@@ in scripts
>>   [06/11]: Makefile: split GIT_USER_AGENT from GIT-CFLAGS
>>   [07/11]: Makefile: split prefix flags from GIT-CFLAGS
>>   [08/11]: Makefile: do not replace @@GIT_VERSION@@ in shell scripts
>>   [09/11]: Makefile: update scripts when build-time parameters change
>>   [10/11]: Makefile: build instaweb similar to other scripts
>>   [11/11]: Makefile: move GIT-VERSION-FILE dependencies closer to use
>
> Looks good modulo a minor nit.  Will queue.

I hate saying "me too", so instead I will say: I agree!

And thanks for this massive cleanup in response to a small nit...

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
