From: Patrick Welche <prlw1@cam.ac.uk>
Subject: Re: 1.8.4 rebase regression?
Date: Tue, 17 Sep 2013 11:07:26 +0100
Message-ID: <20130917100726.GF289@quark>
References: <20130915235739.GA712@quark>
 <vpqioy1815z.fsf@anie.imag.fr>
 <20130917091333.GB289@quark>
 <vpq8uyv6btk.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 17 12:07:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLsBx-0005Qs-Dj
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 12:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907Ab3IQKH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 06:07:29 -0400
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49752 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab3IQKH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 06:07:29 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from host-92-17-176-162.as13285.net ([92.17.176.162]:65431 helo=quark)
	by ppsw-52.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:587)
	with esmtpsa (LOGIN:prlw1) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1VLsBs-00070K-Dz (Exim 4.80_167-5a66dd3)
	(return-path <prlw1@cam.ac.uk>); Tue, 17 Sep 2013 11:07:28 +0100
Content-Disposition: inline
In-Reply-To: <vpq8uyv6btk.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234869>

On Tue, Sep 17, 2013 at 11:23:51AM +0200, Matthieu Moy wrote:
> Patrick Welche <prlw1@cam.ac.uk> writes:
> 
> > Got it: the change between 1.8.3.4 and 1.8.4 is that colour is on by
> > default. If I take 1.8.3.4 and git -c color.ui=always log, I see
> > the same ESC codes => not a regression! I'll just have to sort my
> > box out if I want colour. (The only oddity is that git status is
> > correctly colourful.)
> 
> Maybe you disabled the pager for "git status"?

Interesting: I didn't disable it on purpose, but indeed, it is not
used for status.

Can't believe this:

$ echo $PAGER
more

unset PAGER, and git diff is fine...

Thanks for all the help!

Cheers,

Patrick
