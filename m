From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: unpacker error on push
Date: Wed, 16 Jun 2010 15:34:39 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006161520480.13427@xanadu.home>
References: <0B32FF97-4B20-4B9A-BA45-08EF9485F3A1@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_QRyKMmZrHrf5eEmalfOmNA)"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Gavin Kistner <gkistner@nvidia.com>
X-From: git-owner@vger.kernel.org Wed Jun 16 21:34:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOyNs-0005PS-Rd
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 21:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759483Ab0FPTel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 15:34:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47818 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759205Ab0FPTek (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 15:34:40 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L44002MZH1RPJD0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 16 Jun 2010 15:34:39 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <0B32FF97-4B20-4B9A-BA45-08EF9485F3A1@nvidia.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149273>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_QRyKMmZrHrf5eEmalfOmNA)
Content-type: TEXT/PLAIN; charset=Windows-1252
Content-transfer-encoding: 8BIT

On Wed, 16 Jun 2010, Gavin Kistner wrote:

> (my apologies if you receive this twice; I sent it once before I was 
> authenticated on the mailing list)

This list doesn't require you to be subscribed for you to post messages.

> Local: OS X 10.6.3, git 1.7.1
> Remote: Ubuntu Lucid, git 1.7.0.4
> 
> How can I fix whatever is broken so that I can push again, and—more 
> importantly—get the important changes I made last night over to the 
> remote, by hook or by crook?> -_-_-_-_-_-_-_-_-_-_ On the local 
> machine -_-_-_-_-_-_-_-_-_-_
> 
> Slim2:bugbot3 phrogz$ git push
> Counting objects: 70, done.
> Delta compression using up to 2 threads.
> Compressing objects: 100% (31/31), done.
> Writing objects: 100% (40/40), 26.91 KiB, done.
> Total 40 (delta 11), reused 37 (delta 8)
> error: unpack failed: unpack-objects abnormal exit
> To git://10.20.16.110/bugbot3.git
> ! [remote rejected] planning -> planning (n/a (unpacker error))
> error: failed to push some refs to 'git://10.20.16.110/bugbot3.git'

Could you try doing "git config receive.unpackLimit 1" on the _remote_ 
machine in the receiving repository?

Note this is not a proper fix but rather an attempt to isolate the 
issue.  Please make a backup of the entire repository both on the local 
and the remote machine if you can, so the failure can be reproduced 
again after restoring them to the current state in case this would "fix" 
the issue.


Nicolas

--Boundary_(ID_QRyKMmZrHrf5eEmalfOmNA)--
