From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Tue, 23 Nov 2010 12:06:56 -0500
Message-ID: <1290532016.10892.40.camel@drew-northup.unet.maine.edu>
References: <m2oc9hkurl.fsf@gmail.com>
	 <1290458128.29678.23.camel@drew-northup.unet.maine.edu>
	 <m2k4k5ks0b.fsf@gmail.com>
	 <1290461070.5468.5.camel@drew-northup.unet.maine.edu>
	 <m2bp5glbrp.fsf@gmail.com> <4CEB7F1F.809@drmicha.warpmail.net>
	 <1290517990.10366.17.camel@drew-northup.unet.maine.edu>
	 <4CEBC8C9.4010905@drmicha.warpmail.net>  <m2d3pwj8th.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 18:08:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKwLY-0007UR-6k
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 18:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755824Ab0KWRHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 12:07:53 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:56146 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157Ab0KWRHw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 12:07:52 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id oANH70NP005426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 23 Nov 2010 12:07:05 -0500
In-Reply-To: <m2d3pwj8th.fsf@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=2
	Fuz1=2 Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oANH70NP005426
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1291136840.23683@K4uKq0M8b+15ydXsHnJZeg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161982>


On Tue, 2010-11-23 at 17:36 +0100, Francis Moreau wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> [...]
> 
> >> I recommend re-installing the docbook-dtds package alone and in
> >> isolation from other Yum/RPM transactions. If the xmlcatalog file is
> >> correctly regenerated AND the docbook files are there AND you have
> >> (re)run ./configure prior to running make AND you don't have filesystem
> >
> > Don't do that unless you're using configure for git usually. I don't
> > think Francis is, he's setting make variables.
> >
> 
> I won't, I just call make with some variables set.
> 
> >> errors THEN you should have a successful build. (Barring something that
> >> crawls up out of the rabbit hole--other than a rabbit.)
> >> 
> >> Fix the most obvious possible problems first before seeking
> >> off-the-beaten-path solutions or worse blaming somebody.
> >> 
> >
> > ???
> >
> > catalog sent to Francis off-list, which closes this topic for me.
> 
> Not really I'm afraid...
> 
>   xmlto -m manpage-normal.xsl --skip-validation man git-diff-index.xml
>   I/O error : Attempt to load network entity http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
>   /home/fmoreau/git/Documentation/git-diff-index.xml:2: warning: failed to load external entity "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
>   D DocBook XML V4.5//EN" "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
> 
> This is with your catalog.

I really hope you don't have any filesystem errors. May be worth
checking before attempting to reinstall the docbook-dtds package.

In any case, you are apparently missing the docbook XML 4.5 DTD/XSL
files (from your local cache). It automagically fails over to trying to
fetch them over the internet (which I've noted doesn't work very well).

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
