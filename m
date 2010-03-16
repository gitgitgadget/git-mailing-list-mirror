From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH v2] daemon.c: avoid accessing ss_family member of struct
 sockaddr_storage
Date: Tue, 16 Mar 2010 09:52:58 +0200 (EET)
Message-ID: <alpine.DEB.2.00.1003160949270.29993@cone.home.martin.st>
References: <alpine.DEB.2.00.1003152336520.29993@cone.home.martin.st> <Ulrh6ePYHqfB90btctT3EMJiuUz4wjLndvupvp0xJR1sBAao-hZxS0PI6-IxWscYhjaEno7FzgY@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463810048-72258983-1268725981=:29993"
Cc: git@vger.kernel.org, git@mlists.thewrittenword.com, peff@peff.net,
	kusmabite@gmail.com, drafnel@gmail.com
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Mar 16 08:53:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrRaU-0003bK-9K
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 08:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936263Ab0CPHxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 03:53:10 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:40749 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756227Ab0CPHxH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 03:53:07 -0400
Received: from dsl-tkubrasgw1-ffc4c100-75.dhcp.inet.fi (88.193.196.75) by kirsi1.inet.fi (8.5.014)
        id 4B1D0B4D040126BE; Tue, 16 Mar 2010 09:53:02 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <Ulrh6ePYHqfB90btctT3EMJiuUz4wjLndvupvp0xJR1sBAao-hZxS0PI6-IxWscYhjaEno7FzgY@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142335>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463810048-72258983-1268725981=:29993
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 15 Mar 2010, Brandon Casey wrote:

> On 03/15/2010 04:37 PM, Martin Storsjö wrote:
> > Coming to think about it, would it simplify the code even more if the 
> > function were to take a const struct sockaddr* as a parameter instead? 
> > That would, on the other hand, require more casts where it's called, 
> > though...
> 
> How about this.

Yes, this looks neat!

Acked-by: Martin Storsjö <martin@martin.st>

// Martin
---1463810048-72258983-1268725981=:29993--
