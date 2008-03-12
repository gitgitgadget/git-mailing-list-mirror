From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH v4] gc: call "prune --expire 2.weeks.ago" by default
Date: Wed, 12 Mar 2008 18:40:00 -0400 (EDT)
Message-ID: <alpine.LFD.1.00.0803121838560.2947@xanadu.home>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site>
 <7vskywadum.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803112234470.2947@xanadu.home>
 <alpine.LSU.1.00.0803121833210.1656@racer.site> <47D8193B.901@nrlssc.navy.mil>
 <m3prtzyens.fsf@localhost.localdomain> <47D83532.70103@nrlssc.navy.mil>
 <alpine.LSU.1.00.0803122058430.1656@racer.site>
 <47D83C53.7000602@nrlssc.navy.mil> <7vejaf65q0.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803122153440.1656@racer.site>
 <7vwso74p33.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 23:40:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZZcs-00081z-3p
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 23:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbYCLWkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 18:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752334AbYCLWkE
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 18:40:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54728 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbYCLWkD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 18:40:03 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JXN00GOF2YOM3E0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 12 Mar 2008 18:40:01 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vwso74p33.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77015>

On Wed, 12 Mar 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > ---prune::
> 
> I am fairly paranoid about end users wondering about what is described in
> ancient documentation and complaining that we do not talk about it
> anymore.  I am tempted to suggest:
> 
> 	This is a no-op but you may see it mentioned in older docs and
> 	scripts.  Older git-gc never ran 'prune' without being told, and
> 	this option was a way to tell it to.
> 
> but this would lead to littering the documentation with too much
> historical information in the long run.  I dunno.  I am inclined to favor
> the removal as your patch did, but somebody else may have clever ideas.

Historical notes of that sort belong in RelNotes.


Nicolas
