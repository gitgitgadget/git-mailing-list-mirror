From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 11/13] Allow helpers to request the path to the .git
 directory
Date: Wed, 4 Nov 2009 16:35:56 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911041621400.14365@iabervon.org>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com> <1257364098-1685-12-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 22:36:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5nWM-0001Ul-Lc
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 22:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758237AbZKDVfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 16:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758235AbZKDVfw
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 16:35:52 -0500
Received: from iabervon.org ([66.92.72.58]:53843 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758230AbZKDVfv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 16:35:51 -0500
Received: (qmail 1028 invoked by uid 1000); 4 Nov 2009 21:35:56 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Nov 2009 21:35:56 -0000
In-Reply-To: <1257364098-1685-12-git-send-email-srabbelier@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132154>

On Wed, 4 Nov 2009, Sverre Rabbelier wrote:

> The 'gitdir' capability is reported by the remote helper if it
> requires the location of the .git directory. The location of the .git
> directory can then be used by the helper to store status files even
> when the current directory is not a git repository (such as is the
> case when cloning).
> 
> The location of the .git dir is specified as an absolute path.

I thought we cd into the repository in the middle of clone somewhere, 
before running stuff. In any case, I think it would be good to have 
something like that, but I think maybe we should tell it where it can put 
its status files, rather than telling it where the .git dir is. It would 
also be nice if this is the absolute path that gfi will base a relative 
path for the "marks" options on when importing.

	-Daniel
*This .sig left intentionally blank*
