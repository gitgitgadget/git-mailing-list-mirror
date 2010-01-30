From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Sat, 30 Jan 2010 00:25:14 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001300018040.1681@xanadu.home>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com>
 <7viqakcu56.fsf@alter.siamese.dyndns.org>
 <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com>
 <alpine.LFD.2.00.1001292013150.1681@xanadu.home>
 <ca433831001291840o751fa02eve1ae301537674325@mail.gmail.com>
 <alpine.LFD.2.00.1001292208470.1681@xanadu.home>
 <ca433831001291959m76ed6adap32a17c10e465af1f@mail.gmail.com>
 <alpine.LFD.2.00.1001292305500.1681@xanadu.home>
 <alpine.LFD.2.00.1001292352540.1681@xanadu.home>
 <76718491001292111y2d15620ei8a12c081a9283a07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 06:25:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb5pk-0007ME-H3
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 06:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203Ab0A3FZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 00:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834Ab0A3FZS
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 00:25:18 -0500
Received: from relais.videotron.ca ([24.201.245.36]:31393 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932065Ab0A3FZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 00:25:16 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KX100GKPOE25HS0@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 30 Jan 2010 00:25:15 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <76718491001292111y2d15620ei8a12c081a9283a07@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138448>

On Sat, 30 Jan 2010, Jay Soffian wrote:

> This sounds right to me too. There's nothing wrong with having a
> detached HEAD, and nothing wrong with creating commits in that state.
> You're effectively creating an anonymous branch in the DAG and it's
> subject to garbage collection if you move away from that anonymous
> branch w/o naming it.
> 
> Pedantic note: you don't lose those commits at the next checkout. They
> are merely subject to garbage collection (and not until they age out
> of HEAD's reflog). I know you know that, just being precise. :-)

Being the actual author of the code managing the separate HEAD reflog, I 
do know that indeed.  ;-)


Nicolas
