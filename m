From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 01/23] pack v4: initial pack dictionary structure and code
Date: Tue, 27 Aug 2013 12:13:25 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1308271205090.14472@syhkavp.arg>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
 <1377577567-27655-2-git-send-email-nico@fluxnic.net>
 <xmqqbo4jf9yf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 18:13:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VELta-0002EN-T1
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 18:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377Ab3H0QN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 12:13:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28098 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190Ab3H0QN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 12:13:26 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS700MJ06EDGL60@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 12:13:25 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 3FCBC2DA052D; Tue, 27 Aug 2013 12:13:25 -0400 (EDT)
In-reply-to: <xmqqbo4jf9yf.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233109>

On Tue, 27 Aug 2013, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> > ---
> 
> Was there a reason not to reuse the hash-table Linus did in
> hash.[ch]?

Well... Most likely because when I started that code (which used to be 
quite different initially) it might not have been served correctly by 
hash.c, or any other reasons I long have forgotten by now which might or 
might not still be valid.

> It may not make much of a difference for something so small and
> isolated from the rest of the system, but if hash.[ch] can be easily
> fixed with a small tweak to suit the use by this subsystem better,
> it might be worth reusing the existing code with improvement, which
> may help other potential users.

Absolutely.  If someone wants to give a hand in that direction I'll 
happily integrate patches into my series.  I cannot promise I'll do the 
work myself as I prefer spending the time I have available on actually 
making pack v4 usable.


Nicolas
