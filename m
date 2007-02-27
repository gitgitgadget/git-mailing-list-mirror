From: Simon Josefsson <simon@josefsson.org>
Subject: Replacement for cvs2cl, for generating ChangeLog
Date: Tue, 27 Feb 2007 12:41:28 +0100
Message-ID: <877iu3q13r.fsf@latte.josefsson.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 12:51:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM0rk-0006J0-Vd
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 12:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbXB0Lva (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 06:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbXB0Lva
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 06:51:30 -0500
Received: from 178.230.13.217.in-addr.dgcsystems.net ([217.13.230.178]:59972
	"EHLO yxa.extundo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbXB0Lv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 06:51:29 -0500
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Feb 2007 06:51:28 EST
Received: from localhost.localdomain (yxa.extundo.com [217.13.230.178])
	(authenticated bits=0)
	by yxa.extundo.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l1RBfTS2005031
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 27 Feb 2007 12:41:29 +0100
X-Hashcash: 1:22:070227:git@vger.kernel.org::LBC7E5EsssdPyLVO:Knko
OpenPGP: id=B565716F; url=http://josefsson.org/key.txt
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.94 (gnu/linux)
X-Spam-Status: No, score=-1.9 required=4.0 tests=AWL,BAYES_00,
	FORGED_RCVD_HELO autolearn=ham version=3.1.1
X-Spam-Checker-Version: SpamAssassin 3.1.1 (2006-03-10) on yxa-iv
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on yxa.extundo.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40713>

Hi!  I'm considering switching to git for my projects (shishi, gsasl,
gnutls, libtasn1, opencdk, ...) and I have some questions:

* How do I discard all locally modified or added files?  'cvs upd -C'
  does some of that, but I've been using a tool 'cvsco' which quickly
  restore a CVS checkout into a pristine state.

* Is there a tool that produce ChangeLog files in the GNU format,
  based on the git logs?  Similar to the 'cvs2cl' tool.  The output
  should look like:

2007-02-22  Simon Josefsson <simon@josefsson.org>

	* link-warning.h, gl/getaddrinfo.c, gl/gnulib.mk, gl/string_.h,
	gl/m4/gnulib-comp.m4, gl/m4/string_h.m4, lgl/Makefile.am,
	lgl/snprintf.c, lgl/snprintf.h, lgl/stdio_.h, lgl/string_.h,
	lgl/unistd_.h, lgl/m4/gnulib-comp.m4, lgl/m4/intdiv0.m4,
	lgl/m4/snprintf.m4, lgl/m4/stdio_h.m4, lgl/m4/string_h.m4,
	lgl/m4/unistd_h.m4: Update.

Thanks,
Simon
