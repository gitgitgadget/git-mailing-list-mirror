From: Florian Weimer <fweimer@bfk.de>
Subject: Re: [PATCH] instaweb: support for Ruby's WEBrick server
Date: Mon, 17 Sep 2007 14:25:12 +0200
Message-ID: <823axd32dz.fsf@mid.bfk.de>
References: <618c07250709161935g333f0536q31b453bd58f2d75d@mail.gmail.com>
	<20070917115518.GA26815@soma>
	<18071eea0709170502s397331c5j7d77aa9531f73704@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Eric Wong" <normalperson@yhbt.net>,
	"Mike Dalessio" <mike@csa.net>, git@vger.kernel.org
To: "Thomas Adam" <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 14:25:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXFfi-0003Be-8I
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 14:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbXIQMZq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 08:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753045AbXIQMZq
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 08:25:46 -0400
Received: from mx01.bfk.de ([193.227.124.2]:52954 "EHLO mx01.bfk.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752810AbXIQMZp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2007 08:25:45 -0400
Received: from mx00.int.bfk.de ([10.119.110.2])
	by mx01.bfk.de with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	id 1IXFfT-0005sM-Rg; Mon, 17 Sep 2007 14:25:35 +0200
Received: from fweimer by bfk.de with local id 1IXFf6-0005T1-Dl; Mon, 17 Sep 2007 14:25:12 +0200
In-Reply-To: <18071eea0709170502s397331c5j7d77aa9531f73704@mail.gmail.com> (Thomas Adam's message of "Mon, 17 Sep 2007 13:02:24 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58429>

* Thomas Adam:

> This is what /usr/bin/env is useful for, but it's not that portable.

Yeah, it's /bin/env exclusively on some systems. 8-(

--=20
=46lorian Weimer                <fweimer@bfk.de>
BFK edv-consulting GmbH       http://www.bfk.de/
Kriegsstra=DFe 100              tel: +49-721-96201-1
D-76133 Karlsruhe             fax: +49-721-96201-99
