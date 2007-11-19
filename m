From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation: fix git-clone manpage not to refer to
 itself
Date: Mon, 19 Nov 2007 14:35:43 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711191430460.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <87ejeq1131.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 14:36:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu6nD-0004wf-EN
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 14:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbXKSNfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 08:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752629AbXKSNfq
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 08:35:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:39366 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752040AbXKSNfq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 08:35:46 -0500
Received: (qmail invoked by alias); 19 Nov 2007 13:35:44 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp004) with SMTP; 19 Nov 2007 14:35:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19v331Ezw5vE8Nh3l2XysOSXrQRN3azjTp3eKdBtw
	KN9KY25djLWTCG
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <87ejeq1131.fsf@osv.gnss.ru>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65442>

Hi,

On Fri, 16 Nov 2007, Sergei Organov wrote:

> +ifndef::git-clone[]

It is laudable that you want to fix the _generated_ documentation, but 
there are two things to keep in mind:

- it does _nothing_ to help readers of the sources, and asciidoc was 
  chosen purposely because the source is human-readable, and

- it makes writing the perl script to do a very tiny subset of asciidoc 
  formatting much harder.  We encounter enough problems with the different 
  versions of asciidoc/docbook combinations that I think this perl script 
  would be actually useful.

I know that the user manual uses some advanced features, too, but it did 
not use ifdef in the main text, for example, let alone nested ifdefs, 
which your patch would encourage much more than the source before.

Ciao,
Dscho
