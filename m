From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: What is the idea for bare repositories?
Date: Mon, 12 Nov 2007 17:19:54 +0100
Organization: HCS, University of Amsterdam
Message-ID: <200711121719.54146.wielemak@science.uva.nl>
References: <86k5on8v6p.fsf@lola.quinscape.zz> <20071112131927.GA1701@c3sl.ufpr.br> <Pine.LNX.4.64.0711121355380.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 17:20:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irc1H-0007B7-Ug
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 17:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568AbXKLQT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 11:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbXKLQT6
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 11:19:58 -0500
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:4191 "EHLO
	smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbXKLQT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 11:19:56 -0500
Received: from gollem.science.uva.nl (gollem.science.uva.nl [146.50.26.20])
	(authenticated bits=0)
	by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id lACGJs8f029007
	for <git@vger.kernel.org>; Mon, 12 Nov 2007 17:19:55 +0100 (CET)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0711121355380.4362@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64651>

On Monday 12 November 2007 14:57, Johannes Schindelin wrote:
> Hi,
>
> On Mon, 12 Nov 2007, Bruno Cesar Ribas wrote:
> > A bare repository is the way to publish your changes to the public.
> > git-daemon and http-clones use a bare repository that only contains
> > adminsitrative files.
>
> More to the point, a bare repository is one which does not have a working
> directory attached.
>
> As such, many commands do not make any sense at all, such as "git add"
> (_what_ do you want to add?  There is not even a working directory to work
> with!), or "git commit".

As we are on the subject anyway. Though not tested with the very latest,
but when I was playing with them, I found out that cloning a empty bare
repository produces nothing at all, dispite the promising message:

	$ mkdir x && cd x
	$ git --bare init --shared=group
	Initialized empty shared Git repository in /home/nobackup/jan/tmp/x/
	$ cd ..
	$ git clone x y
	Initialized empty Git repository in /home/jan/nobackup/tmp/y/.git/
	$ ls y
	ls: cannot access y: No such file or directory

Is this a bug?

	--- Jan
