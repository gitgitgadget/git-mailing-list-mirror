From: Anand Kumria <wildfire@progsoc.org>
Subject: Re: cvsimport: trying to convert freebsd cvs to git
Date: Sun, 23 Dec 2007 01:47:35 +0000 (UTC)
Message-ID: <pan.2007.12.23.01.47.29@progsoc.org>
References: <20071222171801.GE15286@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 23 03:18:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6GQb-0000UW-Ak
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 03:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbXLWCSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 21:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754633AbXLWCSe
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 21:18:34 -0500
Received: from main.gmane.org ([80.91.229.2]:33414 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754481AbXLWCSd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 21:18:33 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1J6GMS-0006A4-RP
	for git@vger.kernel.org; Sun, 23 Dec 2007 02:14:40 +0000
Received: from 203.7.227.147 ([203.7.227.147])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 23 Dec 2007 02:14:40 +0000
Received: from wildfire by 203.7.227.147 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 23 Dec 2007 02:14:40 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 203.7.227.147
User-Agent: Pan/0.132 (Waxed in Black)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.0 points;
 *  0.0 RCVD_BY_IP Received by mail server with no name
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  1.0 RAZOR2_CHECK Listed in Razor2 (http://razor.sf.net/)
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69160>

On Sat, 22 Dec 2007 18:18:01 +0100, Miklos Vajna wrote:

> hi,
> 
> recently Stefan reported that he tried to convert the freebsd cvs' src
> module to git and he failed. i tried to help him, but i failed, too.
> here are my efforts:
> 
> he made the cvs available on a (relatively) fast rsync mirror at:
> 
> rsync://ftp.spline.de/FreeBSD-CVS
> 
> (so you don't have to use cvsup if it's a problem for you)
> 
> so after mirroring it, i had:
> 
> $ ls cvs
> CVSROOT/  CVSROOT-ports/  CVSROOT-src/  ports/  src/
> 

A few days prior to your email, someone else asked a similar question:

Some tools you can use:

git-cvsimport (via cvsps)
parsecvs
fromcvs
cvs2svn (development branch)

There is a more detailed listing on the wiki at
<http://git.or.cz/gitwiki/
InterfacesFrontendsAndTools#head-8870e1c81cc93f9a7a7acb5e969924ee60182d6b>

If you have access to the raw ",v" files as you do, I would suggest you 
try out parsecvs. It will not do incremental imports but will you a good 
idea of how you can expect the converted repository to behave / act.

Anand
