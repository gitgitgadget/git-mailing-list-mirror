From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Thu, 15 Jan 2009 06:56:07 +0200
Message-ID: <8763khtbfc.fsf@iki.fi>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
	<alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de>
	<87ljtdk9b3.fsf@iki.fi> <200901142059.09005.trast@student.ethz.ch>
	<alpine.DEB.1.00.0901142258250.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 05:57:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNKId-00054h-OT
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 05:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756302AbZAOE4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 23:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756243AbZAOE4X
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 23:56:23 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:46178 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755781AbZAOE4X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 23:56:23 -0500
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 48FC5B8903BF8A93; Thu, 15 Jan 2009 06:56:12 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LNKH1-0000u1-VG; Thu, 15 Jan 2009 06:56:07 +0200
In-Reply-To: <alpine.DEB.1.00.0901142258250.3586@pacific.mpi-cbg.de> (Johannes Schindelin's message of "Wed\, 14 Jan 2009 23\:06\:48 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105766>

Johannes Schindelin (2009-01-14 23:06 +0100) wrote:

> On Wed, 14 Jan 2009, Thomas Rast wrote:
>>       -aaa [aaa]
>>       +aaa (aaa) aaa
>> 
>> would still give you
>> 
>>       aaa (aaa)<GREEN> aaa<RESET>
>> 
>> which may be unexpected.
>
> But why should it be unexpected?  If people say that every length of "a" 
> makes a word, and consequently everything else is clutter, then that's 
> that, no?

It works logically but I'd very much like to see a some kind of advice
in the man page. I already faced this (unexpected) situation and wasn't
able to fix the regexp myself.
