From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Probably a bug with "~" symbol in filenames on Windows 7 x64 in
 git 1.9.5
Date: Thu, 8 Jan 2015 11:40:27 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1501081140070.21312@s15462909.onlinehome-server.info>
References: <CADb7K9rELHWgy_NYJWrSr9gZn7pcMvETv93d0j+u2fXinj5iTg@mail.gmail.com> <CAPc5daVddkaMkx=43nCeQKbbkrV6nExOqvEBJNyugzDQB2n6kQ@mail.gmail.com> <alpine.DEB.1.00.1501081100570.21312@s15462909.onlinehome-server.info> <20150108102815.GA4806@peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Dmitry Bykov <pvrt74@gmail.com>, msysgit@googlegroups.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 08 11:42:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9AWB-0002PL-Pd
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 11:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756202AbbAHKkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 05:40:39 -0500
Received: from mout.gmx.net ([212.227.15.19]:52824 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754041AbbAHKki (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 05:40:38 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MRoRF-1YG0A92BQ1-00StqH;
 Thu, 08 Jan 2015 11:40:28 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20150108102815.GA4806@peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:1azCycd6UMDxR5DZDx6O+MbDdN7b4aetE27K0qsQ+h2PiGwYhLf
 jkLXybbFMFdi/1tWLyWpfmllXEjw2g52tXbWLE9CwZI2bDAu6NZsjBuKjV+jflRX/ha+yW9
 ol+3ipEEvcxnubUsqTCqqUQkTdu3PbnqCkBHD02mdokms1FI46OqoCyIEK0TvOq5fXqSzZx
 PvIeIRbHyB86HabdIaAHw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262191>

Hi Peff,

On Thu, 8 Jan 2015, Jeff King wrote:

> On Thu, Jan 08, 2015 at 11:06:18AM +0100, Johannes Schindelin wrote:
> 
> > ICON~714.PNG is a valid short name for a long name (such as
> > 'icon.background.png') because it fits the shortening scheme (8.3 format,
> > the base name ends in ~<n>). As this can clash with a validly shortened
> > long name, Git for Windows refuses to check out such paths by default.
> > 
> > If you want the old -- unsafe -- behavior back, just set your
> > core.protectNTFS to false (this means that you agree that the incurred
> > problems are your own responsibility and cannot be blamed on anybody else
> > ;-))
> 
> I wonder if it is worth having a "git-only" mode for core.protectNTFS.
> Turning it off entirely would make him susceptible to GIT~1 attacks.

That is a good idea!

Ciao,
Dscho
