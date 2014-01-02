From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Fix safe_create_leading_directories() for Windows
Date: Thu, 2 Jan 2014 22:10:06 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1401022209310.1191@s15462909.onlinehome-server.info>
References: <52C5A039.6030408@gmail.com> <alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info> <xmqqtxdmp39a.fsf@gitster.dls.corp.google.com> <52C5D0AB.7050309@gmail.com> <52C5D201.5070008@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 22:10:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VypWx-0003Rn-Gj
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 22:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbaABVKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 16:10:08 -0500
Received: from mout.gmx.net ([212.227.17.20]:55913 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928AbaABVKH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 16:10:07 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0LvV1X-1VGw8b2jHX-010g6R
 for <git@vger.kernel.org>; Thu, 02 Jan 2014 22:10:06 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <52C5D201.5070008@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:jG9mXPZtHhUQer26wlSPPU4SI/Gtf+XLiUTe01kX+dVpZOwLjxw
 b0ML9DUvgN2XxBoSb6O9srK1I0IcCSY5RpivFjPHcg14+/vOOZG4O4h2RzdEFdaf+NvoHr7
 rUxAfvy7NGAGW1SiL3A2pUUOuMJhVtcsl30bleyejyLdWjKtID4uyU0VDcshz1f4IL3CoNC
 Q8tegawLm+PeKfvrYMi5w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239882>

Hi,

On Thu, 2 Jan 2014, Sebastian Schuberth wrote:

> When cloning to a directory "C:\foo\bar" from Windows' cmd.exe where "foo"
> does not exist yet, Git would throw an error like
> 
> fatal: could not create work tree dir 'c:\foo\bar'.: No such file or directory
> 
> Fix this by not hard-coding a platform specific directory separator into
> safe_create_leading_directories().
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>

It would be nice to have links to the original discussion, but I guess
that that would not be accepted.

Ciao,
Dscho
