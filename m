From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 11:06:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 11:06:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGuYI-00072k-W6
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 11:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbXBMKGU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 05:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbXBMKGU
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 05:06:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:59124 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751235AbXBMKGT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 05:06:19 -0500
Received: (qmail invoked by alias); 13 Feb 2007 10:06:18 -0000
X-Provags-ID: V01U2FsdGVkX19cxKUnwV1cDJBUF7StcPkfRQrty2+RZ6bEyR8teC
	PDuw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702130932.51601.litvinov2004@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39508>

Hi,

On Tue, 13 Feb 2007, Alexander Litvinov wrote:

> When I have file that was converted from dos to unix format (or from 
> unix to dos) git genereta big diff. But anyway, c++ compiler works well 
> with both formats and in this case I simply convert file to dos format 
> and git shows again nice diff. If unix format was commited to git I 
> simply change the format and commit that file again.

That's awful!

> The only trouble is the rebase, it does not like \r\n ending and othen 
> produce unexpected merge conflict. But I don't use rebse to othen to 
> realy investigate and try to solve the problem.

Well, if everybody thinks like you, maybe we do not have to change 
anything for Windows after all?

Ciao,
Dscho
