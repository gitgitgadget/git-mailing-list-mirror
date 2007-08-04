From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [MinGW PATCH] 'git clone git://...' was failing inside git-read-tree
 with 'fatal: Not a valid object name HEAD'
Date: Sat, 4 Aug 2007 15:16:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708041515251.14781@racer.site>
References: <F7C35F51E58245FDA1EE1C2F2B4EB204@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, johannes.sixt@telecom.at
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 16:17:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHKRK-000064-Pr
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 16:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762463AbXHDORH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 10:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762182AbXHDORG
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 10:17:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:33427 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760778AbXHDORF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 10:17:05 -0400
Received: (qmail invoked by alias); 04 Aug 2007 14:17:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 04 Aug 2007 16:17:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18thrp7VQQtyq8arOp+SqIMZ+zWn+DnMaFSTscfSu
	xGWObPaE6Ww0ht
X-X-Sender: gene099@racer.site
In-Reply-To: <F7C35F51E58245FDA1EE1C2F2B4EB204@ntdev.corp.microsoft.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54854>

Hi,

On Sat, 4 Aug 2007, Dmitry Kakurin wrote:

> NOTE: This fix uses is_absolute_path from msysGit-0.3.exe that is not in
> mingw.git yet.

Ooops.  I think I did not even check that into msysgit.git.  Thanks.

> - if (gitdirenv[0] != '/') {
> + if ( !is_absolute_path( gitdirenv ) ) {

Our coding style does not want them extra spaces...

+ if (!is_absolute_path(gitdirenv)) {

is the way we prefer it.

Ciao,
Dscho
