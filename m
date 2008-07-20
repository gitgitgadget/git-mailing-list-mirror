From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v2] Support gitlinks in fast-import.
Date: Sun, 20 Jul 2008 14:07:49 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807201404280.3305@eeepc-johanness>
References: <200807191621.25654.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 14:08:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKXhr-0002ou-5S
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 14:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756598AbYGTMHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 08:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756475AbYGTMHB
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 08:07:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:51216 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755427AbYGTMHA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 08:07:00 -0400
Received: (qmail invoked by alias); 20 Jul 2008 12:06:58 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp003) with SMTP; 20 Jul 2008 14:06:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7rPwIKRe78B2liXtKxTiknsMQp9bdqBfJrCsFv6
	GRmrkJIJYU9vXv
X-X-Sender: user@eeepc-johanness
In-Reply-To: <200807191621.25654.angavrilov@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89189>

Hi,

On Sat, 19 Jul 2008, Alexander Gavrilov wrote:

> Links can be represented by two forms of the
> Modify command:
> 
> M 160000 SHA1 some/path
> 
> which sets the link target explicitly, or
> 
> M 160000 :mark some/path
> 
> where the mark refers to a commit. The latter
> form can be used by importing tools to build
> all submodules simultaneously in one physical
> repository, and then simply fetch them apart.

It seems that people like to do this, have their submodule branches in the 
superproject.  I wonder if we should bless this by installing an alternate 
in the "git submodule init"ed submodules, or even do it during a "git 
submodule update".

> +			/* Links refer to objects in another repositories, so

s/another/other/

Thanks, especially for the tests,
Dscho
