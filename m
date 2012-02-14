From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [RFC PATCH 0/3] git-p4: move to toplevel
Date: Tue, 14 Feb 2012 20:49:10 +0100
Message-ID: <20120214194910.GA5297@ecki>
References: <1329070423-23761-1-git-send-email-pw@padd.com>
 <7vehtyec64.fsf@alter.siamese.dyndns.org>
 <20120213203709.GA31671@ecki>
 <7vhayuctwm.fsf@alter.siamese.dyndns.org>
 <20120214092048.GC1762@ecki>
 <7vaa4l8diz.fsf@alter.siamese.dyndns.org>
 <20120214190515.GB12072@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Pete Wyckoff <pw@padd.com>,
	git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 14 20:57:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxOVW-0001OU-5n
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 20:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757010Ab2BNT5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 14:57:37 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:11781 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753215Ab2BNT5g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 14:57:36 -0500
Received: from localhost (p5B22E1C5.dip.t-dialin.net [91.34.225.197])
	by bsmtp.bon.at (Postfix) with ESMTP id A79A613004E;
	Tue, 14 Feb 2012 20:57:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120214190515.GB12072@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190742>

On Tue, Feb 14, 2012 at 02:05:15PM -0500, Jeff King wrote:
>
>   2. We explicitly run "sh" in such situations, not SHELL_PATH. Even if
>      "sh" is bash, I believe it should look at its own argv[0] and put
>      itself into a more POSIX-y mode (but I didn't test).

Indeed it does.
