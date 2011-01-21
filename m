From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Re: rebase -i: explain how to discard all commits
Date: Fri, 21 Jan 2011 08:04:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1101210801210.15247@pacific.mpi-cbg.de>
References: <vpq62ziv788.fsf@bauges.imag.fr> <20110120195726.GA11702@burratino> <20110120200827.GB14184@vidovic> <201101202134.41911.trast@student.ethz.ch> <7vfwsnqn8c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 08:03:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgB2B-000646-Vc
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 08:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077Ab1AUHDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 02:03:43 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:56140 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750898Ab1AUHDn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 02:03:43 -0500
Received: (qmail invoked by alias); 21 Jan 2011 07:03:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp007) with SMTP; 21 Jan 2011 08:03:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ophgbG8MoltJHL7Tw1vbNI5sJBlSPHyHjuVuCW2
	QLAYP1lTxIScxQ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vfwsnqn8c.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165356>

Hi,

On Thu, 20 Jan 2011, Junio C Hamano wrote:

> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > (I for one have never accepted such a rebase; if the TODO only 
> > consists of noop, that means I made a mistake.)
> 
> Wouldn't that suggest us that if we were to do anything to this message 
> it would be a good idea to teach the user to "reset --hard" the branch 
> if no commits truly needs to be replayed on top of the onto-commit?

The important difference between rebase -i && noop on the one, and reset 
--hard on the other hand is that the latter is completely unsafe. I mean, 
utterly completely super-unsafe. And I say that because _this here 
developer_ who is not exactly a Git noob lost stuff that way.

rebase -i checks that all is well and we could come back to the current 
status later if we realized that things went horribly wrong.

reset --hard does not do that. No safety net. No reflog. Nada.

Hth,
Dscho
