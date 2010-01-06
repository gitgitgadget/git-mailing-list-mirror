From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: A question about changing remote repo name
Date: Wed, 6 Jan 2010 01:27:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001060123280.4985@pacific.mpi-cbg.de>
References: <60ce8d251001032245n4e0267b1o1ecc796f324f8179@mail.gmail.com>  <c1b8b6671001041852w4740b7d6g4b8db1221c5dc744@mail.gmail.com>  <60ce8d251001042030l75c5443gf173f127ad206df3@mail.gmail.com>
 <c1b8b6671001051607j6b6398d8gf08f7615a38de64e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dongas <dongas86@gmail.com>, git@vger.kernel.org
To: Russell Steicke <russellsteicke@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 01:21:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSJep-0000k6-96
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 01:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657Ab0AFAVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 19:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754204Ab0AFAVp
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 19:21:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:44616 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753422Ab0AFAVo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 19:21:44 -0500
Received: (qmail invoked by alias); 06 Jan 2010 00:21:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp016) with SMTP; 06 Jan 2010 01:21:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+LLG057byL9NG6384oi3d8xDvkxUCG3lVXhoFDQF
	c649+CgVX5fzz4
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <c1b8b6671001051607j6b6398d8gf08f7615a38de64e@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136223>

Hi,

On Wed, 6 Jan 2010, Russell Steicke wrote:

> On Tue, Jan 5, 2010 at 12:30 PM, Dongas <dongas86@gmail.com> wrote:
> > I did a few more steps:
> > root@ubuntu:/work/git-repo/free_monkey# grep -wrin 'origin' .
> > ./.git/packed-refs:2:abfae429bb4081043e84681e5ee94102085f87e0
> > refs/remotes/origin/master
> > ./.git/refs/remotes/karmic/HEAD:1:ref: refs/remotes/origin/master
> >
> > Change 'origin' to 'karmic' in above files.
> 
> Ah yes, I forgot about those files.  I _think_ (but I'm not certain
> without digging into the code) that it's always safe to rm
> packed-refs, as that file is a cache for quicker access to the refs.

For everybody reading this thread: DON'T!

Russel, it would be better if you knew about the mechanism before 
making other people believe that it is safe to delete a file that is _not_ 
a cache, but _replaces_ the existing refs.

(Just mentioning that you only _think_ it is safe does not help; it is not 
safe, but people will think that it is safe.  Maybe you'll spend those 5 
minutes in the future before sending a message like you did...)

Hth,
Dscho
