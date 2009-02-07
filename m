From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] config: Add new option to open an editor.
Date: Sat, 7 Feb 2009 22:14:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902072214410.10279@pacific.mpi-cbg.de>
References: <94a0d4530902040741t4333b132v886d7057353ed52a@mail.gmail.com>  <1233786856-6571-1-git-send-email-felipe.contreras@gmail.com>  <7vmyd1lrnx.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0902050043000.10279@pacific.mpi-cbg.de> 
 <alpine.DEB.1.00.0902050049240.10279@pacific.mpi-cbg.de> <94a0d4530902071309l7c34945ana2af31e41707fa0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 22:17:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVuXz-0008EJ-EC
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 22:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366AbZBGVOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 16:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbZBGVOT
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 16:14:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:59147 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753307AbZBGVOT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 16:14:19 -0500
Received: (qmail invoked by alias); 07 Feb 2009 21:14:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 07 Feb 2009 22:14:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19C56hTXMhCU63uJnT5pkeqP71iVcfxsU7WlOiY07
	duVZ5P0iX466Xm
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <94a0d4530902071309l7c34945ana2af31e41707fa0c@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108880>

Hi,

On Sat, 7 Feb 2009, Felipe Contreras wrote:

> On Thu, Feb 5, 2009 at 1:49 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Thu, 5 Feb 2009, Johannes Schindelin wrote:
> >
> >> On Wed, 4 Feb 2009, Junio C Hamano wrote:
> >>
> >> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> >
> >> > > The idea was originated by discussion about usability of manually
> >> > > editing the config file in 'special needs' systems such as Windows. Now
> >> > > the user can forget a bit about where the config files actually are.
> >> >
> >> > Does this honor core.editor setting in existing configuration files?
> >>
> >> It should, as it uses launch_editor().
> >
> > Oh, I see that launch_editor() does not do its own git_config() parsing.
> > Dunno if it should...
> 
> I think it should, how expensive would it be to call
> git_config(git_default_config, NULL) when it has been loaded already?

We would not need the complete git_default_config(), would we?

Ciao,
Dscho
