From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: Compile fix for SCO OPenServer
Date: Wed, 30 Jul 2008 18:32:12 -0600
Message-ID: <alpine.LNX.1.10.0807301831320.13032@xenau.zenez.com>
References: <20071205172125.GF12636@yugib.highrise.ca> <20080730184956.GF10399@yugib.highrise.ca> <7vtze73zwg.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0807301403360.13032@xenau.zenez.com> <20080730204339.GJ10399@yugib.highrise.ca>
 <alpine.LNX.1.10.0807301522140.13032@xenau.zenez.com> <20080730225635.GM10399@yugib.highrise.ca> <alpine.LNX.1.10.0807301700500.13032@xenau.zenez.com> <20080730234455.GN10399@yugib.highrise.ca> <alpine.LNX.1.10.0807301747160.13032@xenau.zenez.com>
 <20080731001112.GP10399@yugib.highrise.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Aidan Van Dyk <aidan@highrise.ca>
X-From: git-owner@vger.kernel.org Thu Jul 31 02:33:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOM6W-0002gP-61
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 02:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756307AbYGaAcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 20:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756257AbYGaAcP
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 20:32:15 -0400
Received: from zenez.com ([166.70.62.2]:19169 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753097AbYGaAcO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 20:32:14 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 0FDB83F980; Wed, 30 Jul 2008 18:32:12 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id F19AA3F97D;
	Wed, 30 Jul 2008 18:32:12 -0600 (MDT)
In-Reply-To: <20080731001112.GP10399@yugib.highrise.ca>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90886>

On Wed, 30 Jul 2008, Aidan Van Dyk wrote:
> * Boyd Lynn Gerber <gerberb@zenez.com> [080730 20:00]:
> > So what do you think we need to have.  I really do not see the need for 
> > __OPENSERVER__.  Do you?
> 
> No, I think I saw that long ago, when I said:
> > Sorry, a bit premature on my end...    
> 
> With SNPRINTF_RETURNS_BOGUS and NO_MKDTEMP and CFLAGS set for make, I
> don't need any source code changes to compile on SCO.
> 
> And as long as I have GNU bash and diff available, the test suite passes
> as well.  Well, all except for t9500-gitweb-standalone-no-errors.sh:
> 	[Thu Jul 31 00:08:46 2008] gitweb.perl: -T and -B not implemented on filehandles at /u/aidan/git/t/trash directory/../../gitweb/gitweb.perl line 2444.
> 
> Perl claims:
> 	This is perl, v5.8.8 built for i586-pc-sysv5
> 
> But again, I don't plan on running gitweb on this SCO box either...

OK, thanks, I did not want to not respond if things were needed.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
