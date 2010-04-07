From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Wed, 07 Apr 2010 08:42:53 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004070842040.7232@xanadu.home>
References: <loom.20100406T161552-321@post.gmane.org>
 <vpqljd062xb.fsf@bauges.imag.fr> <4BBB5346.6070607@gmail.com>
 <4BBB53F5.9010106@op5.se>
 <q2mec874dac1004060850r5eaa41fak2ba9889d07794651@mail.gmail.com>
 <v2qecffb261004060856qcb769a06vf40ad2a75a3aa4fd@mail.gmail.com>
 <alpine.LFD.2.00.1004061705390.7232@xanadu.home> <4BBC1E47.80308@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Vitaly <vitaly.berov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 14:43:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzUbC-00057e-0i
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 14:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756299Ab0DGMmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 08:42:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:19052 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989Ab0DGMmy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 08:42:54 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L0I006MHBBHK010@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 07 Apr 2010 08:42:53 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4BBC1E47.80308@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144216>

On Wed, 7 Apr 2010, Vitaly wrote:

> I suspected the security reasons.
> 
> Ok, we work in trusted environment. How can we turn this behavior off?

you can't.  This is fundamental to the Git native protocol.


Nicolas
