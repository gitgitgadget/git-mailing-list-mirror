From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Mon, 22 Nov 2010 16:24:30 -0500
Message-ID: <1290461070.5468.5.camel@drew-northup.unet.maine.edu>
References: <m2oc9hkurl.fsf@gmail.com>
	 <1290458128.29678.23.camel@drew-northup.unet.maine.edu>
	 <m2k4k5ks0b.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 22:31:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKdzO-00067Y-7m
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 22:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118Ab0KVVbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 16:31:49 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:44023 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755747Ab0KVVbs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 16:31:48 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id oAMLObWO026071
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Nov 2010 16:24:37 -0500
In-Reply-To: <m2k4k5ks0b.fsf@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oAMLObWO026071
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1291065886.06158@R9QO1cT7ueONMQcrv4GuEQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161914>


On Mon, 2010-11-22 at 21:44 +0100, Francis Moreau wrote:
> Drew Northup <drew.northup@maine.edu> writes:
> 
> > On Mon, 2010-11-22 at 20:45 +0100, Francis Moreau wrote:
> >> Hello,
> >> 
> >> I'm trying to build the git's documentation, but after pulling v1.7.3.2,
> >
> >> it fails:
> >> 
> >>   $ make prefix=/usr/local doc
> >>   make -C Documentation all
> >>   make[1]: Entering directory `/home/fmoreau/git/Documentation'
> >>   make[2]: Entering directory `/home/fmoreau/git'
> >>   make[2]: `GIT-VERSION-FILE' is up to date.
> >>   make[2]: Leaving directory `/home/fmoreau/git'
> >>       XMLTO git-fetch.1
> >>   xmlto: /home/fmoreau/git/Documentation/git-fetch.xml does not validate (status 3)
> >>   xmlto: Fix document syntax or use --skip-validation option
> >>   I/O error : Attempt to load network entity http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
> >>   /home/fmoreau/git/Documentation/git-fetch.xml:2: warning: failed to load external entity "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
> >>   D DocBook XML V4.5//EN" "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
> >>                                                                                  ^
> >>   I/O error : Attempt to load network entity http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
> >>   warning: failed to load external entity "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
> >>   validity error : Could not load the external subset "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
> >>   Document /home/fmoreau/git/Documentation/git-fetch.xml does not validate
> >>   make[1]: *** [git-fetch.1] Error 13
> >>   make[1]: Leaving directory `/home/fmoreau/git/Documentation'
> >> 
> >> Could anybody tell me what's now wrong ?
> >
> > Without more information, not specifically. However, the fix may be
> > fairly simple.
> 
> What do you need exactly ?
> 
> Sorry but I know nothing about these documentation generation tools.
> 
> > Some distributions are apparently so ancient that they don't include the
> > version 4.5 and newer Docbook XML XSL & DTD files. RHEL 5 and older make
> > this list.
> 
> Well I'm running Fedora 14, which I wouldn't call 'ancient'.

Supposedly docbook-dtds-1.0-53.fc14 contains the files needed. I would
check to make sure that your /usr/share/sgml/docbook/xmlcatalog file is
correct. If it is it will contain a line an awful lot like the
following:
<public publicId="-//OASIS//DTD DocBook XML V4.5//EN" uri="xml-dtd-4.5/docbookx.dtd"/>


-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
