From: Lars Winterfeld <lars.winterfeld@tu-ilmenau.de>
Subject: Re: bug: "fatal: cannot pread pack file", version 1.7.5.4
Date: Thu, 16 Aug 2012 16:36:25 -0700
Message-ID: <a6d4278ab75e8d59436f214d8970a79b@localhost>
References: <5638dec6e156f83385a3baa01cf9ac4d@localhost>
 <20120702215736.GA5790@sigill.intra.peff.net> <m2vci5n5r5.fsf@igel.home>
 <20120703032345.GA7143@sigill.intra.peff.net>
 <CACsJy8AmCo82YxHA_6+rkbuJOjOG-HqCgjoP2tz753SXH5w8_Q@mail.gmail.com>
 <20120703051426.GA12965@sigill.intra.peff.net>
 <7vvcgizesm.fsf@alter.siamese.dyndns.org>
 <fd74d7233b4b29fe06afad23fb87552a@localhost>
 <7v4no2zbd9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 01:36:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T29cL-0003gq-Ij
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 01:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059Ab2HPXgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 19:36:40 -0400
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:44320 "EHLO
	piggy.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479Ab2HPXgi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 19:36:38 -0400
Received: from venus.rz.tu-ilmenau.de (venus.rz.tu-ilmenau.de [141.24.4.158])
	by piggy.rz.tu-ilmenau.de (8.13.7/8.13.7/Debian-2) with ESMTP id q7GNaSak030946;
	Fri, 17 Aug 2012 01:36:29 +0200
In-Reply-To: <7v4no2zbd9.fsf@alter.siamese.dyndns.org>
X-Sender: +X7Yrj4TKmBGx8siOKDe81HW6kA+7WWIQ1o4Nby0N/UxpH6g7Se/Wg==@vger.kernel.org
User-Agent: Roundcube Webmail/0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano schrieb:
> Lars Winterfeld <lars.winterfeld@tu-ilmenau.de> writes:
> 
>>> Hrm, has this ever been resolved?
>>
>> Thank you for asking.
>> My local git version is 1.7.5.4, the server version that I actually
>> ended up pushing the files to was however still some 1.6.x.
>> So it was a false alarm. Sorry about that.
> 
> Not really.  Pushing or fetching by a new version of Git against old
> version of Git *should* work; otherwise it is a bug.

Well, okay. The (outdated) server
runs on openSUSE 11.1,
has kernel 2.6.27.39-0.2-default x86_64 GNU/Linux, 
uses git version 1.6.0.2
and gettext (GNU gettext-runtime) 0.17 .

As I said earlier, `git push` worked in the beginning and just stopped
working one day.
I can still reproduce this error, so let me know if you want more info.
