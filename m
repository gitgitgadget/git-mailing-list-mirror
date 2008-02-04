From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-rebase.sh: Unchain the git-COMMAND into git
 COMMAND
Date: Mon, 4 Feb 2008 20:53:03 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802042050480.8543@racer.site>
References: <3as81nbn.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 21:54:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM8KV-0005Xm-33
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 21:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbYBDUxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 15:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752928AbYBDUxm
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 15:53:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:39784 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751989AbYBDUxl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 15:53:41 -0500
Received: (qmail invoked by alias); 04 Feb 2008 20:53:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp025) with SMTP; 04 Feb 2008 21:53:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+GDkFxjk2GBhKVyGQzGHWTu6VvkT7GYXrsLbhLX5
	5k15XvmVRJaBbZ
X-X-Sender: gene099@racer.site
In-Reply-To: <3as81nbn.fsf@blue.sea.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72563>

Hi,

On Mon, 4 Feb 2008, Jari Aalto wrote:

> -Example:       git-rebase master~1 topic
> +Example:       git rebase master~1 topic

>From 36e5e70e0f40cf7ca4351b8159d68f8560a2805f(Start deprecating 
"git-command" in favor of "git command"):

    (For non-builtins, the "git xyzzy" format implies an extra execve(), so
    this script leaves those alone).

Hth,
Dscho
