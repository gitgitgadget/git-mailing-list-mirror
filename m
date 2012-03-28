From: Ivan Todoroski <grnch_lists@gmx.net>
Subject: Re: [PATCH/RFC v2 3/4] fetch-pack: test cases for the new --stdin
 option
Date: Wed, 28 Mar 2012 02:14:45 +0200
Message-ID: <4F7257F5.6070709@gmx.net>
References: <loom.20120318T083216-96@post.gmane.org> <m3fwd550j3.fsf@localhost.localdomain> <20120318190659.GA24829@sigill.intra.peff.net> <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com> <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net> <4F715CF7.5070903@gmx.net> <4F715DBF.6030909@gmx.net> <7v4ntaj61t.fsf@alter.siamese.dyndns.org> <4F724F0D.7000602@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 02:14:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCgXP-0003g5-Cl
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 02:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756697Ab2C1AOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 20:14:49 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:43660 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756786Ab2C1AOs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 20:14:48 -0400
Received: (qmail invoked by alias); 28 Mar 2012 00:14:46 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.166.58]
  by mail.gmx.net (mp028) with SMTP; 28 Mar 2012 02:14:46 +0200
X-Authenticated: #14478976
X-Provags-ID: V01U2FsdGVkX1+TYgEMzQCTvtLxxqmFzGs2XFerfIzbWHvk9IXNRL
	6i4MAz0EnqeKOV
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <4F724F0D.7000602@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194100>

On 28.03.2012 01:36, Ivan Todoroski wrote:
> On 27.03.2012 19:40, Junio C Hamano wrote:
>> 
>> It is sensible to expect that we see all the refs we told it to
>> fetch, but I do not think it is sensible to require they come in
>> the same order as we have given them to the command.
> 
> Oh, OK. I was not aware that fetch-pack is free to reorder commits
> (at least in principle). I will adjust the tests to be
> order-independent.

s/reorder commits/reorder refs for fetching/

I didn't mean actually reordering commits in history, of course.
