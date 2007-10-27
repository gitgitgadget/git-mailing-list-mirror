From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: merge vs rebase: Is visualization in gitk the only problem?
Date: Sat, 27 Oct 2007 13:33:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710271332030.4362@racer.site>
References: <8E86BDBA-A49A-49BB-8E00-8BF6DD7237E9@zib.de>
 <ee77f5c20710270116g45a644bp2b6783310e16ff20@mail.gmail.com>
 <CEA39C15-F9AE-46F5-BBE9-3F7AB0711494@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Symonds <dsymonds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Oct 27 14:34:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlksJ-0000Uz-81
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 14:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbXJ0Mef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 08:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752346AbXJ0Mef
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 08:34:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:51444 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752259AbXJ0Mee (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 08:34:34 -0400
Received: (qmail invoked by alias); 27 Oct 2007 12:34:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp016) with SMTP; 27 Oct 2007 14:34:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19dPWBsF/ZdZQoto6Whvmkl21hvu7n1v7slMPFAKB
	sGgi+8YBgLQ+vU
X-X-Sender: gene099@racer.site
In-Reply-To: <CEA39C15-F9AE-46F5-BBE9-3F7AB0711494@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62486>

Hi,

On Sat, 27 Oct 2007, Steffen Prohaska wrote:

> Could we somehow send rerere information together with a patch? This 
> would give the upstream maintainer (and everyone else who wants to test 
> the patch) the help needed to do a merge.

IMHO this is not sensible to send over email.  But think I that something 
like this could be done for pullers: they fetch from somewhere, and then 
recreate the rerere information from the merge commits they just got (this 
would have to be a new option to git-rerere, methinks).

Ciao,
Dscho
