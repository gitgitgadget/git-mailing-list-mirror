From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix 'git commit -a' in a newly initialized repository
Date: Thu, 22 Feb 2007 21:42:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702222140360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070222202812.8882.44375.stgit@c165>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 22 21:42:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKKly-0007ah-CU
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 21:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbXBVUmf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 15:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbXBVUmf
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 15:42:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:34475 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751856AbXBVUme (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 15:42:34 -0500
Received: (qmail invoked by alias); 22 Feb 2007 20:42:33 -0000
X-Provags-ID: V01U2FsdGVkX1/5eNgKLCz5sFnckCyYy3fjmfnDbd22nOU4KhiMoP
	2lAw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070222202812.8882.44375.stgit@c165>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40384>

Hi,

On Thu, 22 Feb 2007, Fredrik Kuivinen wrote:

> +		die 'nothing to commit (use "git add file1 file2" to include for commit)'

Would it not make more sense to tell the user about "git add ."? Maybe 
together with a hint about .gitignore?

This error message is important. The most likely recipients are total git 
newsters, and we really should try to help them here.

Ciao,
Dscho
