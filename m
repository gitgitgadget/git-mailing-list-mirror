From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/2] request-pull: protect against OPTIONS_KEEPDASHDASH from environment
Date: Sun, 25 Apr 2010 14:34:28 +0200
Message-ID: <201004251434.29296.trast@student.ethz.ch>
References: <20100424120437.GA12237@progeny.tock> <20100424121537.GB12312@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 14:34:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O612u-0002ew-U7
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 14:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630Ab0DYMen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 08:34:43 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:40770 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753564Ab0DYMem (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 08:34:42 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 25 Apr
 2010 14:34:40 +0200
Received: from thomas.localnet (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 25 Apr
 2010 14:34:30 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <20100424121537.GB12312@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145738>

Jonathan Nieder wrote:
> Empty it explicitly to guard against this.  While at it, make the
> corresponding fix to git-resurrect, too (all other scripts in git.git
> already protect themselves).

Ack.  Thanks for thinking of contrib :-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
