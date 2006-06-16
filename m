From: Petr Baudis <pasky@suse.cz>
Subject: Re: Autoconf/Automake
Date: Fri, 16 Jun 2006 20:23:49 +0200
Message-ID: <20060616182349.GF2609@pasky.or.cz>
References: <1150324030.23268.12.camel@dv> <20060615072450.GF7766@nowhere.earth> <20060615133146.GA5794@steel.home> <20060615163209.GJ7766@nowhere.earth> <Pine.LNX.4.64.0606150954430.5498@g5.osdl.org> <20060615174833.GA32247@dspnet.fr.eu.org> <e6s7eb$78h$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 16 20:22:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrIyA-00031Q-SZ
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 20:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWFPSWz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 14:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWFPSWz
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 14:22:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11208 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751252AbWFPSWy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 14:22:54 -0400
Received: (qmail 21302 invoked by uid 2001); 16 Jun 2006 20:23:49 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <e6s7eb$78h$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21961>

Dear diary, on Thu, Jun 15, 2006 at 08:03:56PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Does autoconf generate configure script in POSIX shell, or in bash?

/bin/sh, but on such a degree that it avoids using even functions -
which makes the resulting ./configure script quite awful. autoconf is
*much* better than automake (libtool I shall refrain commenting on
entirely; eeeek) in that you have much more free hand in bending it
in case it does something stupid, but the resulting ./configure script
is still mammoth and barely readable.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
