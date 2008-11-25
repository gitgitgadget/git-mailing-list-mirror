From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: How to hide a git repository?
Date: Tue, 25 Nov 2008 13:38:02 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0811251327480.19665@iabervon.org>
References: <900638.56188.qm@web37904.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Gary Yang <garyyang6@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 19:39:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L52or-0003Z9-B4
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 19:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbYKYSiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 13:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752321AbYKYSiG
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 13:38:06 -0500
Received: from iabervon.org ([66.92.72.58]:46583 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307AbYKYSiF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 13:38:05 -0500
Received: (qmail 15401 invoked by uid 1000); 25 Nov 2008 18:38:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Nov 2008 18:38:02 -0000
In-Reply-To: <900638.56188.qm@web37904.mail.mud.yahoo.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101674>

On Mon, 24 Nov 2008, Gary Yang wrote:

> Do I have to create two git servers? One is for public to download the 
> released code. For example: gitpub.mycompany.com:/pub/linux/kernel.

The public can't generally use this URL, because it's an ssh URL, and they 
won't be able to connect with ssh. They can only really use 
git://gitpub.mycompany.com/pub/linux/kernel or something similar.

The normal pattern is to have R/W access with ssh and anonymous read 
access via git://...; you can then have multiple repositories on the same 
host, with the git server only serving the public one. All of them will be 
accessible to the ssh methods (restricted by the user's UNIX permissions 
on the files in those directories).

	-Daniel
*This .sig left intentionally blank*
