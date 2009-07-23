From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH 1/2] Add a test showing that 'git repack' throws away
 grafted-away parents
Date: Thu, 23 Jul 2009 18:09:51 +0200
Message-ID: <20090723160951.GA12855@atjola.homenet>
References: <cover.1248362827u.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.0907231733300.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 23 18:10:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU0rv-0005DW-0Y
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 18:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324AbZGWQJ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jul 2009 12:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753117AbZGWQJ6
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 12:09:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:56967 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752581AbZGWQJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 12:09:58 -0400
Received: (qmail invoked by alias); 23 Jul 2009 16:09:57 -0000
Received: from i59F5637C.versanet.de (EHLO atjola.homenet) [89.245.99.124]
  by mail.gmx.net (mp009) with SMTP; 23 Jul 2009 18:09:57 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/CYVkb+BbCkR8NqDJkTRidw8fSX1lY/417r+CHaJ
	rsEBPb3RCr18Ba
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0907231733300.8306@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123876>

On 2009.07.23 17:33:45 +0200, Johannes Schindelin wrote:
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>

> ---
>=20
> 	Bjoern said that the reflogs are not thrown away if there is no=20
> 	"sleep 1" (which I turned into "test-chmtime -1 .git/logs/HEAD
> 	.git/logs/refs/heads/master" only to delete it as things worked=20
> 	here without it).

My original version of the test lacked the test_tick, with it, the test
works without "sleep 1" for me, too.

Bj=F6rn
