From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Wed, 16 Jul 2008 03:15:42 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807160315020.2841@eeepc-johanness>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com> <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx> <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness> <7v4p6qzla3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 03:16:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIvcl-00068f-4l
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 03:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519AbYGPBPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 21:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755275AbYGPBPH
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 21:15:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:40935 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755133AbYGPBPG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 21:15:06 -0400
Received: (qmail invoked by alias); 16 Jul 2008 01:15:04 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp029) with SMTP; 16 Jul 2008 03:15:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19WpBMfVzpW1KFzb/AeqDbMHaIP1y0fSBhxllHOCr
	IDpQC0CZOFBkcZ
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7v4p6qzla3.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88622>

Hi,

On Tue, 15 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Since the files generated and used during a rebase are never to be 
> > tracked, they should live in $GIT_DIR.  While at it, avoid the rather 
> > meaningless term "dotest" to "rebase", and unhide ".dotest-merge".
> 
> I understand moving away from .dotest/ to .git/something, but I do not 
> follow the logic of making that something to rebase at all.  It is a 
> scratch area for "am" (and applymbox), isn't it?

Of course, you can name it as you want.  But I thought that the name 
"rebase" applies as well: the patches are rebased from somewhere else on 
top of HEAD :-)

Ciao,
Dscho
