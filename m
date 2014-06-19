From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Conventions on struct copying?
Date: Thu, 19 Jun 2014 13:22:44 -0400
Organization: PD Inc
Message-ID: <5A7F0CEE2DEC4F1B825568DB8358D397@black>
References: <20140618233129.GK368384@vauxhall.crustytoothpaste.net> <xmqqvbrwhlki.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>,
	"'brian m. carlson'" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Jun 19 19:22:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxg34-0003hS-LW
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 19:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933754AbaFSRWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 13:22:50 -0400
Received: from mail.pdinc.us ([67.90.184.27]:48596 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932894AbaFSRWu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 13:22:50 -0400
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s5JHMimF025232;
	Thu, 19 Jun 2014 13:22:44 -0400
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <xmqqvbrwhlki.fsf@gitster.dls.corp.google.com>
Thread-Index: Ac+L4W7Pk/5NUb6DRXmzKz2d081mdQAAY8fQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252169>

> -----Original Message-----
> From: Junio C Hamano
> Sent: Thursday, June 19, 2014 13:11
> 
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > I don't know of any place we explicitly copy structs like
> > this,...
> 
> which should be a reason enough.  The first concrete guideline is
> "just imitate the existing code".
> 
> > but I don't know of any prohibition against it, either.
> 
> So now you know ;-).

To expand, on that do not trust the compiler to do deep copies.

http://stackoverflow.com/questions/2302351/assign-one-struct-to-another-in-c

Hit #1 on https://www.google.com/search?q=c+assignment+of+struct

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
