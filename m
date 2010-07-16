From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Find successor of common ancestor
Date: Fri, 16 Jul 2010 11:06:13 +0200
Message-ID: <20100716090613.GB22894@nibiru.local>
References: <20100716082937.GA22894@nibiru.local> <AANLkTintIToGZu3fvK4aE5LFL7MgOnlfwKgsZ79Q0-o1@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 16 11:13:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZgyv-0003lF-3T
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 11:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936142Ab0GPJNP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jul 2010 05:13:15 -0400
Received: from forum.psychotherapie.org ([217.160.22.205]:34798 "EHLO
	s15216962.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936069Ab0GPJNO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 05:13:14 -0400
Received: (from uucp@localhost)
	by s15216962.onlinehome-server.info (8.13.3/8.13.3) with UUCP id o6G9DCxs016020
	for git@vger.kernel.org; Fri, 16 Jul 2010 11:13:12 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o6G96ER4014917
	for git@vger.kernel.org; Fri, 16 Jul 2010 11:06:14 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTintIToGZu3fvK4aE5LFL7MgOnlfwKgsZ79Q0-o1@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151136>

* Santi B=E9jar <santi@agolina.net> wrote:
> On Fri, Jul 16, 2010 at 10:29 AM, Enrico Weigelt <weigelt@metux.de> w=
rote:
> >
> > Hi folks,
> >
> >
> > suppose the following situation:
> >
> > I've forked some branch A into B, now A and B have evolved
> > independently for quite some time into A' and B'. Now I'd like
> > to rebase B' along A' history line step by step - first on A+1,
> > then A+3, ... until A' (that's what I'd call zip-rebase).
>=20
> This is just what "git rebase"  does:
>=20
> $ git checkout B'
> $ git rebase A'

Yes, but I need to find out A+1 for my zip-rebase.


cu
--=20
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
