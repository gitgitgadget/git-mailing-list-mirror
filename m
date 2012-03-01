From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/5] t5512 (ls-remote): modernize style
Date: Thu, 1 Mar 2012 09:36:26 +0100
Message-ID: <87zkc0ogz9.fsf@thomas.inf.ethz.ch>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
	<20120223002215.GE2410@tgrennan-laptop>
	<1330566326-26075-3-git-send-email-tmgrennan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Amos Waterland <apw@rossby.metr.ou.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 09:36:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S31V5-0006sV-S8
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 09:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089Ab2CAIga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 03:36:30 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:55057 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753853Ab2CAIga (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 03:36:30 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 09:36:26 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 09:36:27 +0100
In-Reply-To: <1330566326-26075-3-git-send-email-tmgrennan@gmail.com> (Tom
	Grennan's message of "Wed, 29 Feb 2012 17:45:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191905>

Tom Grennan <tmgrennan@gmail.com> writes:

> - Redirect unwanted output
[...]
> -	git commit -m initial &&
> +	git commit -q -m initial &&

Why?  When are you seeing the output, except with --verbose?  In the
latter case, isn't it useful to have as much output as possible?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
