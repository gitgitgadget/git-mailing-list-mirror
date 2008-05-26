From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Make old sha1 optional with git update-ref -d
Date: Mon, 26 May 2008 11:51:12 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805261149310.30431@racer>
References: <20080525161125.25087.18083.stgit@yoghurt> <20080525161440.25087.83011.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-327801002-1211799074=:30431"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon May 26 12:52:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0aJ7-0000HI-AN
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 12:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280AbYEZKvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 06:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754222AbYEZKvJ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 06:51:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:48455 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754077AbYEZKvI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 06:51:08 -0400
Received: (qmail invoked by alias); 26 May 2008 10:51:06 -0000
Received: from R4980.r.pppool.de (EHLO racer.local) [89.54.73.128]
  by mail.gmx.net (mp041) with SMTP; 26 May 2008 12:51:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19djapMQWBdCZfouR7ueBqFcGE2wCB2Eg8IS+Mn06
	XtkPF5BKU9RFF1
X-X-Sender: gene099@racer
In-Reply-To: <20080525161440.25087.83011.stgit@yoghurt>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82916>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-327801002-1211799074=:30431
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 25 May 2008, Karl Hasselström wrote:

> Giving the old sha1 is already optional when changing a ref, and it's
> quite handy when running update-ref manually. So make it optional for
> deleting a ref too.

Isn't this a bit dangerous, especially given that there is potentially 
_no_ reflog as a safeguard?

So no, it is not the same as when changing a ref.

I am mildly negative on this (having lost some remote branches, because 
they were deleted _together with the reflogs_ by "git push bla :x"),
Dscho
--8323329-327801002-1211799074=:30431--
