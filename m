From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH/RFC] config: Add --null/-z option for null-delimted output
Date: Tue, 19 Jun 2007 04:12:52 +0200
Message-ID: <20070619021252.GE19725@planck.djpig.de>
References: <f2t6na$5bi$1@sea.gmane.org> <11821227322913-git-send-email-frank@lichtenheld.de> <Pine.LNX.4.64.0706190151160.4059@racer.site> <7v645kyba8.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 04:13:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0TDI-0001fz-88
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 04:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760736AbXFSCM6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 22:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760707AbXFSCM6
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 22:12:58 -0400
Received: from planck.djpig.de ([85.10.192.180]:2537 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759581AbXFSCM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 22:12:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 23EFD88102;
	Tue, 19 Jun 2007 04:12:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id auewW4GppmxF; Tue, 19 Jun 2007 04:12:52 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id CC48588105; Tue, 19 Jun 2007 04:12:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v645kyba8.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50440>

On Mon, Jun 18, 2007 at 06:37:35PM -0700, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Another possibility, though, is to say:
> 
> 	core.some\0where\0core.over\0\0core.the\0core.rainbow\0

How do you denote empty values then?

[section]
	key=
	key

this are two very different statements atm (e.g. the one is false and
the other one is true).

I still think using two different delimiters is the simplest choice.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
