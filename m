From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: fetch <repo> <branch>:<branch> fetches tags?
Date: Tue, 29 Jan 2008 02:41:28 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801290240240.23907@racer.site>
References: <479E9063.5000403@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jan 29 03:42:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJgQY-0008C0-6Z
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 03:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbYA2Clv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 21:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbYA2Clv
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 21:41:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:52842 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751196AbYA2Clu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 21:41:50 -0500
Received: (qmail invoked by alias); 29 Jan 2008 02:41:48 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO [192.168.1.69]) [86.138.198.40]
  by mail.gmx.net (mp018) with SMTP; 29 Jan 2008 03:41:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19kTJEqO/5kPEJrLBT3Hhvf4hXaAH0Iob3NZ7prKk
	exIOx4Q3Jd239b
X-X-Sender: gene099@racer.site
In-Reply-To: <479E9063.5000403@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71920>

Hi,

On Mon, 28 Jan 2008, Brandon Casey wrote:

> Is this the intended behavior?

AFAICT yes.  Whenever you say "git fetch" without "--no-tags", it should 
fetch those tags that reference objects that were fetched, and _only_ 
those.

Hth,
Dscho

P.S.: What does the Navy do with git?
