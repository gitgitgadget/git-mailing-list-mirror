From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] gc --aggressive: make it really aggressive
Date: Wed, 18 Mar 2009 18:27:30 +0200
Message-ID: <87ocvyvlsd.fsf@iki.fi>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
	<20071205.202047.58135920.davem@davemloft.net>
	<4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>
	<20071205.204848.227521641.davem@davemloft.net>
	<4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>
	<alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>
	<Pine.LNX.4.64.0712061201580.27959@racer.site>
	<alpine.DEB.1.00.0903181657180.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 18 17:29:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljydj-0003Ov-6f
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 17:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbZCRQ1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 12:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753009AbZCRQ1m
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 12:27:42 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:41296 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981AbZCRQ1l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 12:27:41 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 49B9120C003B01AE; Wed, 18 Mar 2009 18:27:37 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1Ljyc6-0000zj-Da; Wed, 18 Mar 2009 18:27:30 +0200
In-Reply-To: <alpine.DEB.1.00.0903181657180.10279@pacific.mpi-cbg.de> (Johannes Schindelin's message of "Wed\, 18 Mar 2009 17\:01\:31 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113627>

On 2009-03-18 17:01 (+0100), Johannes Schindelin wrote:

>> The default was not to change the window or depth at all. As
>> suggested by Jon Smirl, Linus Torvalds and others, default to
>> 
>> 	--window=250 --depth=250

> Guess what. This is still unresolved, and yet somebody else had to be
> bitten by 'git gc --aggressive' being everything but aggressive.

Pieter de Bie's tests seem to suggest that usually --window=50
--depth=50 gives about the same results than with higher values:

    http://vcscompare.blogspot.com/2008/06/git-repack-parameters.html

I don't understand the issue very well myself so I really can't say what
would be a/the good value. Anyway, I agree that it would be nice if "git
gc --aggressive" were aggressive and a user wouldn't need to know about
"git repack" and its cryptical low-levelish options.
