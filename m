From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH/RFC] blame: CRLF in the working tree and LF in the repo
Date: Mon, 27 Apr 2015 06:39:00 +0200
Organization: <)><
Message-ID: <20150427043900.GC1578@camelia.ucw.cz>
References: <553CD3DA.9090700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"johannes.schindelin@gmx.de >> Johannes Schindelin" 
	<johannes.schindelin@gmx.de>, sandals@crustytoothpaste.net
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 27 06:47:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymawv-0000dx-Lk
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 06:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbbD0ErN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 00:47:13 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59844 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbbD0ErM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 00:47:12 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Apr 2015 00:47:12 EDT
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (82-73-239-109.cust.centrio.cz [109.239.73.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id E3F091C0100;
	Mon, 27 Apr 2015 06:39:01 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id t3R4d1ox001628;
	Mon, 27 Apr 2015 06:39:01 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id t3R4d0rf001627;
	Mon, 27 Apr 2015 06:39:00 +0200
Content-Disposition: inline
In-Reply-To: <553CD3DA.9090700@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267845>

Hello,

thank you Torsten for the patch [I'm the reporter, but could not do
it myself]

> -test_expect_success 'blaming files with CRLF newlines' '
> +test_expect_failure 'blaming files with CRLF newlines in repo, core.autoclrf=input' '

Shouldn't the old test be rather removed?
It deals with an invalid situation.

I thought that having crlf in the repo is incorrect, so no wonder
that it fails if the files in the working tree are changed to LF.

And changing the autocrlf transformation is effectively the same,
no matter that the files _physically_ are the same as the files in
the repo.

Have a nice day,
    Stepan Kasal
