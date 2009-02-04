From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] config: Add new option to open an editor.
Date: Thu, 5 Feb 2009 00:49:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902050049240.10279@pacific.mpi-cbg.de>
References: <94a0d4530902040741t4333b132v886d7057353ed52a@mail.gmail.com> <1233786856-6571-1-git-send-email-felipe.contreras@gmail.com> <7vmyd1lrnx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902050043000.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 00:50:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUrWB-000637-VA
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 00:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757332AbZBDXtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 18:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757053AbZBDXtW
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 18:49:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:57304 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756723AbZBDXtU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 18:49:20 -0500
Received: (qmail invoked by alias); 04 Feb 2009 23:49:18 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp044) with SMTP; 05 Feb 2009 00:49:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+y4sBe9QWyXn++AZgaughJ0MSYe40GmHIzVpZuRP
	6MjNv/OhWR/y8z
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0902050043000.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108470>

Hi,

On Thu, 5 Feb 2009, Johannes Schindelin wrote:

> On Wed, 4 Feb 2009, Junio C Hamano wrote:
> 
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> > 
> > > The idea was originated by discussion about usability of manually
> > > editing the config file in 'special needs' systems such as Windows. Now
> > > the user can forget a bit about where the config files actually are.
> > 
> > Does this honor core.editor setting in existing configuration files?
> 
> It should, as it uses launch_editor().

Oh, I see that launch_editor() does not do its own git_config() parsing.  
Dunno if it should...

Ciao,
Dscho
