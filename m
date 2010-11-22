From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Mon, 22 Nov 2010 15:35:28 -0500
Message-ID: <1290458128.29678.23.camel@drew-northup.unet.maine.edu>
References: <m2oc9hkurl.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 21:36:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKd7I-0004dS-Nb
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 21:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757481Ab0KVUfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 15:35:55 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:54351 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757362Ab0KVUfy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 15:35:54 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id oAMKZYaM030758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Nov 2010 15:35:34 -0500
In-Reply-To: <m2oc9hkurl.fsf@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oAMKZYaM030758
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1291062934.78187@CGUeMKcQj3nvRceVb+oWOQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161910>


On Mon, 2010-11-22 at 20:45 +0100, Francis Moreau wrote:
> Hello,
> 
> I'm trying to build the git's documentation, but after pulling v1.7.3.2,
> it fails:
> 
>   $ make prefix=/usr/local doc
>   make -C Documentation all
>   make[1]: Entering directory `/home/fmoreau/git/Documentation'
>   make[2]: Entering directory `/home/fmoreau/git'
>   make[2]: `GIT-VERSION-FILE' is up to date.
>   make[2]: Leaving directory `/home/fmoreau/git'
>       XMLTO git-fetch.1
>   xmlto: /home/fmoreau/git/Documentation/git-fetch.xml does not validate (status 3)
>   xmlto: Fix document syntax or use --skip-validation option
>   I/O error : Attempt to load network entity http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
>   /home/fmoreau/git/Documentation/git-fetch.xml:2: warning: failed to load external entity "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
>   D DocBook XML V4.5//EN" "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
>                                                                                  ^
>   I/O error : Attempt to load network entity http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
>   warning: failed to load external entity "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
>   validity error : Could not load the external subset "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
>   Document /home/fmoreau/git/Documentation/git-fetch.xml does not validate
>   make[1]: *** [git-fetch.1] Error 13
>   make[1]: Leaving directory `/home/fmoreau/git/Documentation'
> 
> Could anybody tell me what's now wrong ?

Without more information, not specifically. However, the fix may be
fairly simple. 

Some distributions are apparently so ancient that they don't include the
version 4.5 and newer Docbook XML XSL & DTD files. RHEL 5 and older make
this list. Putting those files in the local cache and fixing the
appropriate configuration file quiets the errors.

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
