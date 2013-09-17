From: Patrick Welche <prlw1@cam.ac.uk>
Subject: Re: 1.8.4 rebase regression?
Date: Tue, 17 Sep 2013 10:15:08 +0100
Message-ID: <20130917091508.GC289@quark>
References: <20130915235739.GA712@quark>
 <vpqioy1815z.fsf@anie.imag.fr>
 <vpqd2o77wbk.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 17 11:15:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLrNO-0001zF-Vn
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 11:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970Ab3IQJPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 05:15:11 -0400
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:35832 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723Ab3IQJPK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 05:15:10 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from host-92-17-176-162.as13285.net ([92.17.176.162]:65498 helo=quark)
	by ppsw-52.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:587)
	with esmtpsa (LOGIN:prlw1) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1VLrNF-0000rM-Ff (Exim 4.80_167-5a66dd3)
	(return-path <prlw1@cam.ac.uk>); Tue, 17 Sep 2013 10:15:10 +0100
Content-Disposition: inline
In-Reply-To: <vpqd2o77wbk.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234867>

On Tue, Sep 17, 2013 at 09:15:43AM +0200, Matthieu Moy wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
> > Patrick Welche <prlw1@cam.ac.uk> writes:
> >
> >> $ git diff
> >> ESC[1mdiff --cc glib/gmain.cESC[m
> >> ESC[1mindex 738e69c,5aaebd0..0000000ESC[m
> >> ESC[1m--- a/glib/gmain.cESC[m
> >> ESC[1m+++ b/glib/gmain.cESC[m
> >> ESC[36m@@@ -4953,32 -4921,32 +4953,48 @@@ESC[m ESC[mg_unix_signal_watch_dispatch (GSourcESC[m
> >>
> >>
> >> (same xterm, no change of TERM in both invocations above)
> >> git status in 1.8.4 does show red, so colour does work...
> >>
> >> Thoughts on how to help debug?
> >
> > Can you try:
> >
> > git -c color.ui=never diff
> > git -c color.ui=auto diff
> > git -c color.ui=always diff
> >
> > ?
> 
> ... and Junio suggested offline to look for a broken pager, so, you can
> try this too:
> 
> git --no-pager diff

Even better - colour works here too => I must look at my pager.

Thank you!

Patrick
