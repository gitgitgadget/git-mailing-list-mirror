From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix the MacOS X compile of gitk by pinching po2msg.sh
 from git-gui
Date: Wed, 9 Jan 2008 13:40:46 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801091339390.31053@racer.site>
References: <20080109132953.GA12489@hashpling.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Wed Jan 09 14:41:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCbBF-0004f5-Iw
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 14:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbYAINkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 08:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbYAINkt
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 08:40:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:50757 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751100AbYAINks (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 08:40:48 -0500
Received: (qmail invoked by alias); 09 Jan 2008 13:40:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp010) with SMTP; 09 Jan 2008 14:40:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+5luMgii+5QmWlEwvl15juMGEN0POfbeLh8vhQcU
	6Qehn9zWmhqsRf
X-X-Sender: gene099@racer.site
In-Reply-To: <20080109132953.GA12489@hashpling.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69990>

Hi,

On Wed, 9 Jan 2008, Charles Bailey wrote:

> Make the behaviour of a top level make NO_MSGFMT=Yes consistent when 
> performing the subdirectory builds in gitk-git and git-gui.
> 
> Signed-off-by: Charles Bailey <charles@hashpling.org>
> ---
>  gitk-git/Makefile                   |    7 ++++++-
>  {git-gui => gitk-git}/po/.gitignore |    0 
>  {git-gui => gitk-git}/po/po2msg.sh  |    0 
>  3 files changed, 6 insertions(+), 1 deletions(-)
>  copy {git-gui => gitk-git}/po/.gitignore (100%)
>  copy {git-gui => gitk-git}/po/po2msg.sh (100%)

Since gitk and git-gui are separate projects (pulled at irregular 
intervals into git.git), your patch looks sane, but would be better done 
as a patch against gitk.git.

Ciao,
Dscho
