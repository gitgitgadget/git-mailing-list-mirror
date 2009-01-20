From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: gitk doesn't work w/o sudo.
Date: Tue, 20 Jan 2009 18:16:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901201815010.5159@intel-tinevez-2-302>
References: <c94f8e120901190216x246589ebwc4a44dd85bb655d2@mail.gmail.com>  <3f4fd2640901190359w39ded50ds246903808e94246c@mail.gmail.com>  <c94f8e120901190637i294d379dke3a07a90da5076f8@mail.gmail.com>  <200901200912.14432.brian.foster@innova-card.com>
 <c94f8e120901200851n21c6d67r3c43e3efd435e3db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-306968877-1232471743=:5159"
Cc: Brian Foster <brian.foster@innova-card.com>,
	Reece Dunn <msclrhd@googlemail.com>,
	git list <git@vger.kernel.org>
To: Dilip M <dilipm79@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 18:18:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPKEh-0006mY-Lu
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 18:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762044AbZATRQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 12:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762039AbZATRQc
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 12:16:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:60441 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762016AbZATRQb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 12:16:31 -0500
Received: (qmail invoked by alias); 20 Jan 2009 17:16:29 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp053) with SMTP; 20 Jan 2009 18:16:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19GprVacBlGJvzO7buzQdCktJ0GVCw+UXG0IfRNOw
	QcFDyKc++7soVb
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <c94f8e120901200851n21c6d67r3c43e3efd435e3db@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Content-ID: <alpine.DEB.1.00.0901201816210.5159@intel-tinevez-2-302>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106499>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-306968877-1232471743=:5159
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.1.00.0901201816211.5159@intel-tinevez-2-302>

Hi,

On Tue, 20 Jan 2009, Dilip M wrote:

> On Tue, Jan 20, 2009 at 1:42 PM, Brian Foster
> <brian.foster@innova-card.com> wrote:
> > On Monday 19 January 2009 15:37:06 Dilip M wrote:
> >> On Mon, Jan 19, 2009 at 5:29 PM, Reece Dunn <msclrhd@googlemail.com> wrote:
> >> > 2009/1/19 Dilip M <dilipm79@gmail.com>:
> >> >> ..I recently install GIT on Ubuntu (hardy) box....I am able to use
> >> >> 'gitk' only If I do 'sudo'. Without 'sudo' it complains 'repository
> >> >> not found'
> >> >
> >> > Who is the owner of the repository directory (and the .git directory)
> >> > and what are the permissions on the directory?  [ ... ]
> >>
> >> dm-laptop:~/repos/atria> id -a
> >> uid=1000(dm) gid=1000(dm)  [ ... ]
> >> dm-laptop:~/repos/atria> ls -lh .git/
> >>[... all looks Ok ...]
> >
> >  repeating Reece's question, what is the permissions/owner
> >  _of_the_directory_which_contains_ the '.git/' directory?
> >  I can reproduce this behaviour (git 1.6.0.4) simply by
> >  denying myself search (née execute) permission on that
> >  directory, for entirely obvious reasons.
> 
> It's the same issue....Any ENV variable I can set to debug this...?

I'd try running it with strace, and then search the output for stat() 
calls involving <something>/.git.

Ciao,
Dscho
--8323329-306968877-1232471743=:5159--
