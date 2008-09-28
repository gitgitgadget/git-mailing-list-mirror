From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 3/4] mingw: move common functionality to win32.h
Date: Sun, 28 Sep 2008 11:10:48 +0200
Message-ID: <200809281110.48256.johannes.sixt@telecom.at>
References: <20080927084301.GB21650@dpotapov.dyndns.org> <200809272034.04931.johannes.sixt@telecom.at> <20080927215102.GF21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Marcus Griep <marcus@griep.us>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 28 11:12:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjsK0-00032U-2S
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 11:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbYI1JKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 05:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbYI1JKy
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 05:10:54 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:36950 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbYI1JKw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 05:10:52 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id DFAD213A29D;
	Sun, 28 Sep 2008 11:10:48 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6DCD41D225;
	Sun, 28 Sep 2008 11:10:48 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080927215102.GF21650@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96946>

On Samstag, 27. September 2008, Dmitry Potapov wrote:
> win32_to_errno was the first thing that implemented but then released
> that translation of Win32 errors to errno cannot be in general case.
> For instance, ERROR_BUFFER_OVERFLOW means ENAMETOOLONG here, but it
> can be translated to ETOOSMALL in other cases. How do you propose to
> deal with that?

We deal with that when the need arises, in an evolutionary manner. The first 
step is to *have* an error code translation routine.

-- Hannes
