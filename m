From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: something like 'find' in revisions
Date: Sun, 6 Jul 2008 14:53:17 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807061452330.3486@wbgn129.biozentrum.uni-wuerzburg.de>
References: <4870A700.8040205@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ittay Dror <ittay.dror@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 14:54:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFTkv-0004iI-ET
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 14:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbYGFMxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 08:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753915AbYGFMxU
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 08:53:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:54455 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753393AbYGFMxU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 08:53:20 -0400
Received: (qmail invoked by alias); 06 Jul 2008 12:53:18 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp015) with SMTP; 06 Jul 2008 14:53:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18v8oMItZsvijKZHlccLRre/vGgmViXE/y+qy7uWJ
	DODfEnP5xE9zN8
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <4870A700.8040205@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87525>

Hi,

On Sun, 6 Jul 2008, Ittay Dror wrote:

> How can I find files with a given name (or pattern) in my history (where 
> I don't know the exact path and some files have been removed)?

I'd grep in the output of "git rev-list --objects".  Then I'd have the 
full name, and "git log --all -- <fullpath>" is my friend.

Ciao,
Dscho
