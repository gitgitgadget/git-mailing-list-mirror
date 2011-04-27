From: Drew Northup <drew.northup@maine.edu>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 16:16:36 -0400
Message-ID: <1303935396.25134.79.camel@drew-northup.unet.maine.edu>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	 <4DB80747.8080401@op5.se>
	 <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	 <4DB82D90.6060200@op5.se> <7vbozr8uo8.fsf@alter.siamese.dyndns.org>
	 <7vpqo77dlr.fsf@alter.siamese.dyndns.org>
	 <1303930175.25134.38.camel@drew-northup.unet.maine.edu>
	 <20110427194233.GA16717@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:16:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFBAL-0004uB-9V
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 22:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755680Ab1D0UQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 16:16:47 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:54710 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913Ab1D0UQq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 16:16:46 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p3RKGhbn015934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 27 Apr 2011 16:16:43 -0400
In-Reply-To: <20110427194233.GA16717@gnu.kitenet.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p3RKGhbn015934
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1304540203.4987@tb4jnYbP2+l6bPcn/5g/8w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172268>


On Wed, 2011-04-27 at 15:42 -0400, Joey Hess wrote:
> Drew Northup wrote:
> > I was just thinking of that, and for hoots and hollers I
> > copied /usr/share/man/man1/git-am.1.gz
> > to /usr/share/man/man1/git-amp.1.gz and tried "git help amp" on it.
> > 
> > 	[dnorthup@drew-northup ~]$ git help amp
> > 	No manual entry for gitamp
> > 
> > So, that doesn't work. I haven't checked yet how Git "knows" what valid
> > pages are available for "git help" but just putting another file in the
> > same directory as the others didn't do the job (at least not on my
> > workstation).
> 
> If git-amp is available in $PATH, 'git help amp' runs 'man git-amp'.
> Otherwise, it runs 'man gitamp'.

That's what I thought too, but it didn't work! (<still scratching head
here>) I'll have to try a couple of other ways to break it later on.

> Tools like autoconf etc already know how to install man pages into the
> right places. I don't see the need for any additional support for git
> here.

I'm not saying there should be--in fact quite the opposite.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
