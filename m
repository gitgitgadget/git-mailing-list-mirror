From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] format-patch: use a string_list for headers
Date: Sun, 7 Mar 2010 23:13:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003072313130.7596@pacific.mpi-cbg.de>
References: <7vk4torn8j.fsf@alter.siamese.dyndns.org>  <1267997598-20815-3-git-send-email-bebarino@gmail.com> <40aa078e1003071344h5ef4358aif7888afdad1b4fc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Boyd <bebarino@gmail.com>, git <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Steven Drake <sdrake@xnet.co.nz>,
	Junio C Hamano <gitster@pobox.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sun Mar 07 23:06:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoOcO-0004KJ-7h
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 23:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989Ab0CGWGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 17:06:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:55385 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754742Ab0CGWGT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 17:06:19 -0500
Received: (qmail invoked by alias); 07 Mar 2010 22:06:14 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 07 Mar 2010 23:06:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+yMbU1rUuyIQwjbMM64kILGUvAnB18EX/RL5BOmY
	vp6PTYBa/k2eCK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <40aa078e1003071344h5ef4358aif7888afdad1b4fc6@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59999999999999998
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141740>

Hi,

On Sun, 7 Mar 2010, Erik Faye-Lund wrote:

> On Sun, Mar 7, 2010 at 10:33 PM, Stephen Boyd <bebarino@gmail.com> wrote:
> > +static struct string_list extra_hdr = { .strdup_strings = 1 };
> > +static struct string_list extra_to = { .strdup_strings = 1 };
> > +static struct string_list extra_cc = { .strdup_strings = 1 };
> >
> 
> Do we really use this C99 feature (designated initializers)? I think
> it will break MSVC builds, at least... Perhaps some other non-gcc
> platforms as well?

http://repo.or.cz/w/git.git/blob?f=Documentation/SubmittingPatches#l84

Ciao,
Dscho
