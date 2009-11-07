From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 11/12] Basic build infrastructure for Python scripts
Date: Sat, 7 Nov 2009 13:13:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911071311350.4985@pacific.mpi-cbg.de>
References: <1257547966-14603-1-git-send-email-srabbelier@gmail.com>  <1257547966-14603-5-git-send-email-srabbelier@gmail.com> <1257547966-14603-6-git-send-email-srabbelier@gmail.com>  <1257547966-14603-7-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-8-git-send-email-srabbelier@gmail.com>  <1257547966-14603-9-git-send-email-srabbelier@gmail.com> <1257547966-14603-10-git-send-email-srabbelier@gmail.com>  <1257547966-14603-11-git-send-email-srabbelier@gmail.com> 
 <1257547966-14603-12-git-send-email-srabbelier@gmail.com>  <16cee31f0911061523v5b9754ebg9c846c0e96ac808@mail.gmail.com> <fabb9a1e0911061525n7c7ad7dl2d97d979a25335bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Andrzej K. Haczewski" <ahaczewski@gmail.com>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 07 13:12:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6k9P-0003F7-44
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 13:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbZKGMJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2009 07:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbZKGMJ4
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 07:09:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:58808 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751261AbZKGMJz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2009 07:09:55 -0500
Received: (qmail invoked by alias); 07 Nov 2009 12:09:59 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp004) with SMTP; 07 Nov 2009 13:09:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19h4N9JonVh/JWQTvzGJ3JY/PjAw+IwNh2qbe+Gpy
	VNopQNJ0hJFV8L
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <fabb9a1e0911061525n7c7ad7dl2d97d979a25335bf@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132360>

Hi,

On Sat, 7 Nov 2009, Sverre Rabbelier wrote:

> On Sat, Nov 7, 2009 at 00:23, Andrzej K. Haczewski <ahaczewski@gmail.com> wrote:
> 
> > I'm asking because bash+perl is a huge stopper for Windows platform, 
> > which requires basic unix environment to work, while python support 
> > for Windows is excellent and most of Windows developers already use 
> > python.
> 
> I don't know what the stance is on this though, currently it is intended 
> only for the remote helpers I think.

Everybody who knows only a little bit about the history of msysGit knows 
that Perl/Bash support was easy while Python seems to be impossible.  
Before anybody says "but Python is Open Source, and available for 
Windows": I will only listen when you have a script that builds Python 
inside msysGit, not requiring a proprietary compiler nor Linux for a 
cross-build.

Hth,
Dscho
