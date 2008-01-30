From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch.sh: remove temporary directory on
 failure
Date: Wed, 30 Jan 2008 11:51:31 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801301151050.23907@racer.site>
References: <479E4612.6030006@nrlssc.navy.mil> <7v3asfkgii.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 12:52:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKBUX-0003yA-7k
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 12:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760521AbYA3LwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 06:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760373AbYA3Lv7
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 06:51:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:60313 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758165AbYA3Lv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 06:51:58 -0500
Received: (qmail invoked by alias); 30 Jan 2008 11:51:56 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp008) with SMTP; 30 Jan 2008 12:51:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/pJOJCawfpVD3earYylZwHW2+AEXAUX2cV+3JA3u
	f5MVg0Z2BGI5aC
X-X-Sender: gene099@racer.site
In-Reply-To: <7v3asfkgii.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72055>

Hi,

On Tue, 29 Jan 2008, Junio C Hamano wrote:

> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
> > Even though this directory may be useful for debugging when you 
> > encounter a problem, I wonder if the normal "error" will be _user_ 
> > error. In which case the user will adjust the command line parameters 
> > and try to rerun. Currently the user would then receive the message
> >
> >      "$tempdir already exists, please remove it"
> >
> > Then, rm -rf the tempdir, then rerun.
> >
> > Is this necessary? Maybe anyone with the know-how to debug would also 
> > have the know-how to comment out the 'trap' in the script (or direct 
> > someone asking for help on the mailing list to do so).
> 
> Makes sense to me.  Dscho?

To me, too.

Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Thanks,
Dscho
