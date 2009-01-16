From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [RFC PATCH] Fix gitdir detection when in subdir of gitdir
Date: Fri, 16 Jan 2009 18:23:46 +0100
Message-ID: <20090116172346.GA15804@neumann>
References: <1232120253-1551-1-git-send-email-szeder@ira.uka.de>
	<alpine.DEB.1.00.0901161729070.3586@pacific.mpi-cbg.de>
	<4970BA2B.7090807@viscovery.net> <4970BAE5.8080006@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 18:25:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNsRX-0002Pe-Eh
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 18:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760278AbZAPRXv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 12:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757422AbZAPRXv
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 12:23:51 -0500
Received: from francis.fzi.de ([141.21.7.5]:5037 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755570AbZAPRXu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 12:23:50 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 16 Jan 2009 18:23:45 +0100
Content-Disposition: inline
In-Reply-To: <4970BAE5.8080006@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 16 Jan 2009 17:23:45.0866 (UTC) FILETIME=[2FC64AA0:01C977FF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105980>

On Fri, Jan 16, 2009 at 05:50:45PM +0100, Johannes Sixt wrote:
> Johannes Sixt schrieb:
> > G=E1bor's patch needs a better justification which misbehavior it t=
ries to
> > fix, and the spot that it changes:
>=20
> I actually meant: "which use-case the patch tries to help". Because t=
he
> current behavior can hardly be classified as bug. ("You have no busin=
ess
> cd-ing around in .git." ;)

I agree that fiddling around in '.git' is a quite rare use case.

I did it while I was working on bash completion support for the
upcoming 'git sequencer' to see where it stores its temporary files
and what is in those files.  And I got errors from the completion
script after each executed command, which quickly made me upset enough
to look after it.

I thought it worths fixing, but it's even better if it's not a bug,
because then I don't have to fix my fix (;

Regards,
G=E1bor
