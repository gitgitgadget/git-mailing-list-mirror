From: Peter van der Does <peter@avirtualhome.com>
Subject: Re: git config key bug or by design?
Date: Wed, 28 Nov 2012 07:11:47 -0500
Message-ID: <20121128071147.188a869e@Indy>
References: <20121127221446.7f2fbf71@Indy>
	<20121128033408.GE27772@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 13:12:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdgUm-0006kO-Tx
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 13:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539Ab2K1MLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 07:11:49 -0500
Received: from biast.lunarmania.com ([67.210.100.118]:46295 "EHLO
	biast.lunarmania.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471Ab2K1MLt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 07:11:49 -0500
Received: from c-69-248-87-3.hsd1.nj.comcast.net ([69.248.87.3]:46367 helo=mail.grandprix.int)
	by biast.lunarmania.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77)
	(envelope-from <peter@avirtualhome.com>)
	id 1TdgUV-0006Va-Ed
	for git@vger.kernel.org; Wed, 28 Nov 2012 04:11:47 -0800
Received: from Indy (indy.grandprix.int [192.168.1.106])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: pdoes)
	by mail.grandprix.int (Postfix) with ESMTPSA id 57D282E4AD
	for <git@vger.kernel.org>; Wed, 28 Nov 2012 07:11:47 -0500 (EST)
In-Reply-To: <20121128033408.GE27772@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.13; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - biast.lunarmania.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - avirtualhome.com
X-Get-Message-Sender-Via: biast.lunarmania.com: authenticated_id: avirtu2/from_h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210729>

On Tue, 27 Nov 2012 22:34:09 -0500
Jeff King <peff@peff.net> wrote:
> 
> I don't recall ever discussing it. But what is it that you want to
> store in a key starting with a number? Git does not respect any such
> config values[1].
> 
> Are you writing a new tool that will store its config alongside git's?
> Even if the behavior is loosened, you would probably want to avoid
> starting your config keys with numbers, as older git versions would be
> around for a while and would choke on it.
> 
> -Peff
> 
> [1] You can still store arbitrary bytes in the subsection name (e.g.,
>     "foo.123.bar").

I am writing a tool, it needs to store branch names in a separate config
file. 

It's clear git doesn't respect those values, hence my question. I
understand how to work around the problem, I would just prefix the key.
I was just wondering if it was by design, which I guess it is as the
parsing of the file will die if the key starts with a non-alpha
character.


-- 
Peter van der Does

GPG key: CB317D6E

IRC: Ganseki on irc.freenode.net
Twitter: @petervanderdoes
