From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: unpacker error on push
Date: Fri, 18 Jun 2010 13:35:49 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006181332230.13427@xanadu.home>
References: <0B32FF97-4B20-4B9A-BA45-08EF9485F3A1@nvidia.com>
 <alpine.LFD.2.00.1006161520480.13427@xanadu.home>
 <64131565-2407-4EBF-A6CB-7C286E1B20D4@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_d7P5t8bQ5MVRjyOeSN5SRQ)"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Gavin Kistner <gkistner@nvidia.com>
X-From: git-owner@vger.kernel.org Fri Jun 18 19:36:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPfU0-0008Ll-25
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 19:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933844Ab0FRRfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 13:35:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17536 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933739Ab0FRRfv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 13:35:51 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR006.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L480004M0VQJG80@VL-MO-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 18 Jun 2010 13:35:50 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <64131565-2407-4EBF-A6CB-7C286E1B20D4@nvidia.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149353>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_d7P5t8bQ5MVRjyOeSN5SRQ)
Content-type: TEXT/PLAIN; charset=Windows-1252
Content-transfer-encoding: 8BIT

On Fri, 18 Jun 2010, Gavin Kistner wrote:

> On Jun 16, 2010, at 1:34 PM, Nicolas Pitre wrote:
> > On Wed, 16 Jun 2010, Gavin Kistner wrote:
> >> Local: OS X 10.6.3, git 1.7.1
> >> Remote: Ubuntu Lucid, git 1.7.0.4
> >> 
> >> How can I fix whatever is broken so that I can push again, and—more 
> >> importantly—get the important changes I made last night over to the 
> >> remote, by hook or by crook?> -_-_-_-_-_-_-_-_-_-_ On the local 
> >> machine -_-_-_-_-_-_-_-_-_-_
> >> 
> >> Slim2:bugbot3 phrogz$ git push
> >> Counting objects: 70, done.
> >> Delta compression using up to 2 threads.
> >> Compressing objects: 100% (31/31), done.
> >> Writing objects: 100% (40/40), 26.91 KiB, done.
> >> Total 40 (delta 11), reused 37 (delta 8)
> >> error: unpack failed: unpack-objects abnormal exit
> >> To git://10.20.16.110/bugbot3.git
> >> ! [remote rejected] planning -> planning (n/a (unpacker error))
> >> error: failed to push some refs to 'git://10.20.16.110/bugbot3.git'
> > 
> > Could you try doing "git config receive.unpackLimit 1" on the _remote_ 
> > machine in the receiving repository?
> 
> I ran into this problem again. I backed up both repositories in full, 
> ran the command above in the remote repository, and it did not fix the 
> problem.

The error message changed a bit though, right?

> I deleted my local copy and cloned using ssh instead if git://, copied 
> over the same changes and was able to push again. This looks to be my 
> workaround.
> 
> If anyone wants to dive deeper into this problem, please let me know 
> and we can fight it using the snapshots I have. 

I would be interested in them.


Nicolas

--Boundary_(ID_d7P5t8bQ5MVRjyOeSN5SRQ)--
