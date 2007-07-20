From: Olivier Galibert <galibert@pobox.com>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Fri, 20 Jul 2007 12:19:42 +0200
Message-ID: <20070720101942.GA77248@dspnet.fr.eu.org>
References: <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org> <9436820E-53D1-425D-922E-D4C76578E40A@silverinsanity.com> <863azk78yp.fsf@lola.quinscape.zz> <FA38709A-7C68-4D66-BA26-B5ED49DFA85A@silverinsanity.com> <7vk5sw2ba7.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.999.0707191706120.27249@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	David Kastrup <dak@gnu.org>,
	"Shawn O.Pearce" <spearce@spearce.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 20 12:22:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBpcv-0005uL-Kx
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 12:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639AbXGTKUH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 06:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753921AbXGTKUG
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 06:20:06 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:1468 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753209AbXGTKUF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 06:20:05 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 56E8EA360B; Fri, 20 Jul 2007 12:19:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707191706120.27249@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53078>

On Thu, Jul 19, 2007 at 05:15:28PM -0700, Linus Torvalds wrote:
> (*) And, for anybody confused about the issue, the answer to the latter 
> question is an emphatic: "Yes it should, live with it, and if you want the 
> directory back, you had better add it back as an empty directory"

Wouldn't it be perfectly reasonable for git rm to re-add emptied
directories as empty transparently if the appropriate
flag/configuration is set?  rm is porcelain after all.

  OG.
