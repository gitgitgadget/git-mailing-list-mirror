From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] HEAD, ORIG_HEAD and FETCH_HEAD are really special.
Date: Fri, 07 Sep 2007 15:08:59 -0700
Message-ID: <7vzlzy162s.fsf@gitster.siamese.dyndns.org>
References: <1189115308.30308.9.camel@koto.keithp.com>
	<7vsl5r8jer.fsf@gitster.siamese.dyndns.org>
	<1189133898.30308.58.camel@koto.keithp.com>
	<7vd4wu67qs.fsf_-_@gitster.siamese.dyndns.org>
	<1189181313.30308.97.camel@koto.keithp.com>
	<alpine.LFD.0.9999.0709071222270.21186@xanadu.home>
	<7vejha43oh.fsf@gitster.siamese.dyndns.org>
	<87r6lab0rw.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Sat Sep 08 00:09:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITm0p-0006H8-4B
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 00:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758596AbXIGWJK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 18:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753624AbXIGWJI
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 18:09:08 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49735 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbXIGWJI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 18:09:08 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 74C7F13049E;
	Fri,  7 Sep 2007 18:09:23 -0400 (EDT)
In-Reply-To: <87r6lab0rw.wl%cworth@cworth.org> (Carl Worth's message of "Fri,
	07 Sep 2007 14:53:23 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58083>

Carl Worth <cworth@cworth.org> writes:

> On Fri, 07 Sep 2007 13:32:30 -0700, Junio C Hamano wrote:
>> So I am all for making an ambiguous refname an error in 1.5.4.
>
> If you do, then please also make it an error to create an ambiguous
> refname as well.

Yeah, didn't I also suggest that already?
