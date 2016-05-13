From: Eric Wong <e@80x24.org>
Subject: Re: [PATCH 3/6] t9107: use "return 1" instead of "exit 1"
Date: Fri, 13 May 2016 22:59:16 +0000
Message-ID: <20160513225916.GA17368@dcvr.yhbt.net>
References: <20160513204654.GA10684@sigill.intra.peff.net>
 <20160513204721.GC15391@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 14 00:59:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1M3W-0007A2-U2
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 00:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbcEMW7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 18:59:20 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51188 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753887AbcEMW7S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 18:59:18 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5647320D5C;
	Fri, 13 May 2016 22:59:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160513204721.GC15391@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294590>

Jeff King <peff@peff.net> wrote:
> +			git diff --exit-code refs/remotes/origin/$i refs/remotes/origin/$j ||
> +				return 1

80 columns; but I guess Junio picked it up, already.
Otherwise the rest of the series looks good.  Thanks.
