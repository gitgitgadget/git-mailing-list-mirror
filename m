From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 0/3] Document and refuse rebase -s ours
Date: Sun, 15 Nov 2009 22:13:15 +0100
Message-ID: <200911152213.18743.trast@student.ethz.ch>
References: <7vvdhggote.fsf@alter.siamese.dyndns.org> <cover.1258309432.git.trast@student.ethz.ch> <7veinzfqj9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 22:14:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9mQZ-0007hL-L4
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 22:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbZKOVOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 16:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbZKOVOS
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 16:14:18 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:22609 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305AbZKOVOS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 16:14:18 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 22:14:23 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 22:14:01 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.27.37-0.1-default; KDE/4.3.3; x86_64; ; )
In-Reply-To: <7veinzfqj9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132967>

Junio C Hamano wrote:
> 
> I'd rewrite [3/3] in the following way to keep it easier to maintain the
> blacklist, like this.
> 
>             case "$1" in
>     -       ours)
>     +       ours | theirs | octopus | subtree)

I agree with the rewrite; it's easier to maintain, even though it's
now in a quite strange place.

However, I think the example you gave is misleading: 'subtree' is a
useful strategy if you want to rebase across a subtree merge boundary,
isn't it?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
