From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 1/4] mingw: remove use of _getdrive() from lstat/fstat
Date: Sat, 27 Sep 2008 21:38:10 +0200
Message-ID: <200809272138.11305.johannes.sixt@telecom.at>
References: <20080927083945.GZ21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Marcus Griep <marcus@griep.us>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 27 21:40:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjfef-0001tD-Ij
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 21:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbYI0TiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 15:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752681AbYI0TiP
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 15:38:15 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:48398 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbYI0TiO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 15:38:14 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 5226D13A30C;
	Sat, 27 Sep 2008 21:38:12 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 0EBB328EB9;
	Sat, 27 Sep 2008 21:38:11 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080927083945.GZ21650@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96919>

On Samstag, 27. September 2008, Dmitry Potapov wrote:
> The field device is not used by Git, and putting the number of the
> current device is meaningless anyway.

Acked-by: Johannes Sixt <johannes.sixt@telecom.at>

-- Hannes
