From: Drew Northup <drew.northup@maine.edu>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 14:49:35 -0400
Message-ID: <1303930175.25134.38.camel@drew-northup.unet.maine.edu>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	 <4DB80747.8080401@op5.se>
	 <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	 <4DB82D90.6060200@op5.se> <7vbozr8uo8.fsf@alter.siamese.dyndns.org>
	 <7vpqo77dlr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Jon Seymour <jon.seymour@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 20:50:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF9oY-0000KZ-Li
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 20:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756579Ab1D0SuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 14:50:09 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:56717 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763Ab1D0SuI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 14:50:08 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p3RInfFB007898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 27 Apr 2011 14:49:46 -0400
In-Reply-To: <7vpqo77dlr.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=4
	Fuz1=4 Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p3RInfFB007898
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1304534987.55957@U1mvKYTxNVVCaknALu4XAQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172259>


On Wed, 2011-04-27 at 11:28 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Andreas Ericsson <ae@op5.se> writes:
> >
> >> You're utterly horribly wrong. ...
> >> ...
> >> So the complete description would be
> >>
> >>   git clone git://somerepo/gitworks
> >>   cd gitworks
> >>   make install
> >>
> >> and the rest is in developer hands.
> >
> > Yeah, I like this as the conclusion of this thread ;-).
> 
> Having said that, to make this work well not just for the command but for
> documentation and help, there needs a way for the build procedure of such
> user-script project to query the manpage and the documentation paths, just
> like we let them query the executable path via "git --exec-path".

I was just thinking of that, and for hoots and hollers I
copied /usr/share/man/man1/git-am.1.gz
to /usr/share/man/man1/git-amp.1.gz and tried "git help amp" on it.

	[dnorthup@drew-northup ~]$ git help amp
	No manual entry for gitamp

So, that doesn't work. I haven't checked yet how Git "knows" what valid
pages are available for "git help" but just putting another file in the
same directory as the others didn't do the job (at least not on my
workstation).

However, as noted earlier, copying /usr/bin/git-am to /usr/bin/git-amp
did work. Executing "git amp -h" resulted in the built-in help text for
'git am' being printed to the screen, exactly as expected.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
