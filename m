From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Teach git-commit about commit message templates.
Date: Wed, 25 Jul 2007 14:42:16 +0800
Message-ID: <46A6F0C8.7010204@midwinter.com>
References: <20070723041741.GA22461@midwinter.com>	<Pine.LNX.4.64.0707231059490.14781@racer.site>	<46A481B4.7000502@midwinter.com>	<Pine.LNX.4.64.0707231136530.14781@racer.site>	<46A48949.1020501@midwinter.com>	<7vfy3fkpr8.fsf@assigned-by-dhcp.cox.net>	<46A5EA2D.1030707@midwinter.com> <7v3azdh400.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 08:42:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDaZm-0003Qz-QF
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 08:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757589AbXGYGmX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 02:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756076AbXGYGmW
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 02:42:22 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:44290
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1753976AbXGYGmW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 02:42:22 -0400
Received: (qmail 30274 invoked from network); 25 Jul 2007 06:42:21 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=DbhExkZfPOu/Ig2Nk5iy4PELZQ7yzXdy5+mzskHKec3c2x1Re+8MkjL6+dEtdrup  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 25 Jul 2007 06:42:21 -0000
User-Agent: Thunderbird 2.0.0.5 (Macintosh/20070716)
In-Reply-To: <7v3azdh400.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53669>

Junio C Hamano wrote:
> No, I am way more cunning and lazy than that.  I did not have
> hunch about the common case, so I just had you (and anybody else
> who would join the thread) do necessary thinking and guessing
> for me ;-)
>   

Ah, good. So it sounds like what I've got is at least an okay first cut 
from a functionality point of view. Dscho (or anyone else), any 
objections to the code in v2 of my patch? I believe I addressed all the 
feedback from v1.

-Steve
