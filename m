From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [VALGRIND PATCH for nth_last patch series] Fix invalid memory
 access
Date: Wed, 21 Jan 2009 13:06:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901211306270.3586@pacific.mpi-cbg.de>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901210113500.19014@racer> <7vwscpgi7t.fsf@gitster.siamese.dyndns.org> <200901211019.01493.trast@student.ethz.ch> <7vr62xezm8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 13:08:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPbsd-0001hh-Lt
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 13:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759013AbZAUMGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 07:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758134AbZAUMGn
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 07:06:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:60848 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754315AbZAUMGl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 07:06:41 -0500
Received: (qmail invoked by alias); 21 Jan 2009 12:06:39 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 21 Jan 2009 13:06:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/hy8B5OlnhP482/mZ9KkFunE+huWxvqoWs0Jx/SH
	yrgfABU1raj2Oj
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vr62xezm8.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106599>

Hi,

On Wed, 21 Jan 2009, Junio C Hamano wrote:

> Having said all that, I think Dscho's one had an off-by-one (but it is
> getting late and it may be I who has one).

Yep, I missed the "\n" at the end.

Ciao,
Dscho
