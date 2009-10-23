From: Nick Woolley <nickwoolley@yahoo.co.uk>
Subject: Re: [cvsimport] Import CVS repository from a specified date or branch
 name
Date: Fri, 23 Oct 2009 22:38:25 +0100
Message-ID: <4AE22251.7060901@yahoo.co.uk>
References: <4AE160BC.5000608@vipco.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Klaus_R=F6del?= <klaus.roedel@vipco.de>
X-From: git-owner@vger.kernel.org Sat Oct 24 00:12:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1SMe-0007eD-03
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 00:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbZJWWLw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Oct 2009 18:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbZJWWLw
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 18:11:52 -0400
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:48430 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbZJWWLv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 18:11:51 -0400
X-Greylist: delayed 2010 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Oct 2009 18:11:51 EDT
Received: from 87-194-154-6.bethere.co.uk ([87.194.154.6] helo=[192.168.0.100])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nickwoolley@yahoo.co.uk>)
	id 1N1Rq5-000732-62; Fri, 23 Oct 2009 22:38:25 +0100
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4AE160BC.5000608@vipco.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131136>

Klaus R=F6del wrote:
> I have a very large and old (serveral years) cvs repository and I wan=
t
> to import this in git.
> For my work it is not nessecary to import all the revision history fr=
om
> the cvs repository.
> It is engough to import only the revisions from a specified date or
> branch name of the cvs repo.
>=20
> Is this possible with git-cvsimport?

I'm not certain if it is possible, if it is I suspect it might require =
invoking
cvsps first and then reading in the output generated with git-cvsimport=
, as
Andreas implies.

In any case, the underlying cvsps program is flawed, and  in it's curre=
nt form,
although it seems to work ok for simple situations, I know for a fact t=
hat
didn't faithfully reproduce a rather big old CVS repository I tried it =
on. So if
you're planning on just importing once, and don't need incremental impo=
rts, from
my experience I'd suggest you'd fare better using cvs2git:

http://cvs2svn.tigris.org/cvs2git.html

Cheers,

N
