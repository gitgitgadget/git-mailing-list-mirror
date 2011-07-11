From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 3/5] commit: add commit_generation function
Date: Mon, 11 Jul 2011 19:57:09 +0200
Message-ID: <20110711175709.GA6245@toss.lan>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161814.GC10418@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 11 19:57:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgKjV-0005Dr-6o
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 19:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758365Ab1GKR5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 13:57:20 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:7359 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757924Ab1GKR5U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 13:57:20 -0400
Received: from bsmtp.bon.at (unknown [10.232.130.106])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 4AE74CE38F
	for <git@vger.kernel.org>; Mon, 11 Jul 2011 19:57:17 +0200 (CEST)
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 7ACAF10010;
	Mon, 11 Jul 2011 19:57:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110711161814.GC10418@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176882>

On Mon, Jul 11, 2011 at 12:18:14PM -0400, Jeff King wrote:
>
> +unsigned long commit_generation(const struct commit *commit)
> +{
[...]
> +	/* drop const because we may call parse_commit */
> +	return commit_generation_recurse((struct commit *)commit);
> +}

Out of curiosity, why make it const in the first place?

Clemens
