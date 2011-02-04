From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [1.8.0] Re: reorganize the mess that the source tree has become
Date: Fri, 04 Feb 2011 17:47:40 -0500
Message-ID: <1296859660.1255.49.camel@drew-northup.unet.maine.edu>
References: <20110202022909.30644.qmail@science.horizon.com>
	 <alpine.LFD.2.00.1102030036420.12104@xanadu.home>
	 <AANLkTimnMDuAX-Ctc5K3mt=b2bz2FTsb_P7Fs8RzVwpd@mail.gmail.com>
	 <AANLkTikhPRGZ9DxCWbWvBiac_DYiXYsnEdHVOnbHUdU4@mail.gmail.com>
	 <87bp2sy2mf.fsf@catnip.gol.com>  <20110204181550.GA14173@vidovic>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Miles Bader <miles@gnu.org>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	George Spelvin <linux@horizon.com>,
	Eugene Sajine <euguess@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Fri Feb 04 23:50:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlUTZ-0003jJ-NN
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 23:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075Ab1BDWty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 17:49:54 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:59575 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab1BDWty (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 17:49:54 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p14MlkPc023817
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 4 Feb 2011 17:47:51 -0500
In-Reply-To: <20110204181550.GA14173@vidovic>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=7
	Fuz1=7 Fuz2=7
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p14MlkPc023817
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1297464536.32092@o5Xi8cf//uzqDgQgL7DKPA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166063>


On Fri, 2011-02-04 at 19:15 +0100, Nicolas Sebrecht wrote:
> The 04/02/11, Miles Bader wrote:
> > Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
> > > Quite frankly, I'm surprised there are (presumably experienced)
> > > developers who do not immediately see the value of a little
> > > organization. Surely, given the use of code conventions, formatting
> > > rules, etcetera, the obvious one step further is to also organize
> > > where the files go?
> > 
> > I think one of the problems is that what's been suggested seems like
> > window-dressing.  Moving everything into src/ and calling it "organized"
> > doesn't actually accomplish much other than perhaps making the README
> > file more visible to newbs; things are _still_ a mess, just a mess with
> > four more letters...
> 
> So it would be an ordered mess, at least. The current amount of files in
> the root directory do make things harder for people not already familiar
> with the content. FMHO, moving the source files into a subdirectory
> could be only a first step to the good direction.

Nicolas,
Having once upon a time (in CVS days) taken over a project that was
neatly organized into tons of folders I can say that more folders is not
always better.
If you are organizing things into modules by folders, and those things
are mutually exclusive pre-compilation then doing so may make sense. If
the folders ADD value to the project by adding organization--as opposed
to hiding disorganization--then they may have value.
>From my meager hacking thus far (working on making utf-16 a more
user-friendly experience out-of-the-box) I have found that none of this
is true (thus far) with the git codebase. In fact the one thing that
would have been useful is more in-code--and/or separate
API-ish--documentation (it took me waaaay too long to figure out how git
add, aka git-add, works), but I am too much of a realist to expect that
to change much. I most certainly DO NOT recommend that a mess of patches
be submitted to Junio to fix it (document what you are working on as you
see fit; I work on too many things to not document fairly extensively).
I approach codebase reorganization the same way. I have seen the
destructive things it can do to a project when it becomes an end unto
itself separate from the primary focus. In fact, what killed that first
project I mentioned was an argument about something that was not part of
the primary purpose of the project which exploded with a fury resembling
a religious confrontation. I do not want to see that happen to Git. I
didn't want to see that project die either, but when you exasperate
enough of the core developers that's what happens. 

(My first job as project leader was to get it off of our CVS host, the
second was to find it a nice grave over at nongnu.org. I never did get
CVS import to work. I never did convince any of the core developers that
it was still worth working on.)

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
