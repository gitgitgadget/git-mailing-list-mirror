From: Nicolas Pitre <nico@cam.org>
Subject: Re: [Junio C Hamano] Re: Consolidate SHA1 object file close
Date: Sun, 15 Jun 2008 21:13:41 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806152108410.23110@xanadu.home>
References: <7viqwbfxk6.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0806151057100.2949@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 16 03:14:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K83Ir-0006ig-IU
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 03:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbYFPBNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 21:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbYFPBNm
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 21:13:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:29714 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbYFPBNm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 21:13:42 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K2J00JDY7E6ZA80@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 15 Jun 2008 21:13:19 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.10.0806151057100.2949@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85156>

On Sun, 15 Jun 2008, Linus Torvalds wrote:

> 
> 
> On Sat, 14 Jun 2008, Junio C Hamano wrote:
> >
> > Other than that I had to stop for a few seconds to think at the magic 
> > "20 bytes longer", they look scary-but-correct ;-).

BTW, isn't the same concerns valid for temporary pack file creation too?
Or maybe we just don't care in the context of packs?

Also... this change is lacking its counterpart in 
builtin-prune.c:remove_temporary_files().


Nicolas
