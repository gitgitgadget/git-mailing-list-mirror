From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] config: Use parseopt.
Date: Sun, 15 Feb 2009 12:26:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902151224450.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de>  <1234612989-32297-1-git-send-email-felipe.contreras@gmail.com>  <alpine.DEB.1.00.0902142041370.10279@pacific.mpi-cbg.de>  <94a0d4530902141231t143067e5n872558a4e515be4a@mail.gmail.com> 
 <alpine.DEB.1.00.0902142328530.10279@pacific.mpi-cbg.de> <94a0d4530902150104n555b845bofc5897230c64a5f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 12:27:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYf9V-0000MG-8R
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 12:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbZBOLZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 06:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbZBOLZf
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 06:25:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:46902 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752231AbZBOLZe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 06:25:34 -0500
Received: (qmail invoked by alias); 15 Feb 2009 11:25:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 15 Feb 2009 12:25:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Hv812e2hHL3w43oahykSsXI3lZKR88HNFWYdHeI
	HSVLcssZ/NTfcB
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <94a0d4530902150104n555b845bofc5897230c64a5f2@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109994>

Hi,

On Sun, 15 Feb 2009, Felipe Contreras wrote:

> On Sun, Feb 15, 2009 at 12:32 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Sat, 14 Feb 2009, Felipe Contreras wrote:
> >
> >> On Sat, Feb 14, 2009 at 9:59 PM, Johannes Schindelin
> >> <Johannes.Schindelin@gmx.de> wrote:
> >>
> >> > On Sat, 14 Feb 2009, Felipe Contreras wrote:
> >> >
> >> >> +     else if (actions & ACTION_EDIT) {
> >> >> +             const char *config_filename;
> >> >> +             if (config_exclusive_filename)
> >> >> +                     config_filename = config_exclusive_filename;
> >> >> +             else
> >> >> +                     config_filename = git_path("config");
> >> >
> >> > Why not reuse config_exclusive_filename here?
> >>
> >> You mean:
> >> if (!config_exclusive_filename)
> >>   config_exclusive_filename = git_path("config");
> >
> > Yes.
> 
> I'm not sure about this one. At least git_config should be moved before 
> that code, otherwise it will only try to read core.editor from the 
> exclusive_filename and that's not what we want.

Ah!  I did not think about core.editor, of course, but that is what got 
you started with git-config, after all.

However, the next line sets config_exclusive_filename, does it not?

Ciao,
Dscho
