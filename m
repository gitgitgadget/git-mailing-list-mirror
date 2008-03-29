From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: why multiple password prompts?
Date: Sat, 29 Mar 2008 14:49:37 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803291439450.19665@iabervon.org>
References: <alpine.WNT.1.10.0803291141550.11992@znlsyl>  <alpine.LNX.1.00.0803291241020.19665@iabervon.org> <46a038f90803291137l20244abcke54941dc92c2c8b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul <lists@pote.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 29 19:50:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jfg8F-00058m-4I
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 19:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbYC2Stk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 14:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753921AbYC2Stk
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 14:49:40 -0400
Received: from iabervon.org ([66.92.72.58]:40232 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753875AbYC2Stj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 14:49:39 -0400
Received: (qmail 9925 invoked by uid 1000); 29 Mar 2008 18:49:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Mar 2008 18:49:37 -0000
In-Reply-To: <46a038f90803291137l20244abcke54941dc92c2c8b4@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78478>

On Sat, 29 Mar 2008, Martin Langhoff wrote:

> On Sat, Mar 29, 2008 at 12:48 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> >  One of the changes in the upcoming release is to reduce this to one,
> >  except for an occasional second one.
> 
> That's cool - didn't know a rework of the ssh interactions had
> happened.

It's not actually anything to do with ssh; it's that the git native 
protocol code tries to do as much as possible in each of its connections.

> It would be really good if we could detect if there's an
> existing "master" connection and piggyback over that (see options -M
> and -O). Reading man ssh_config it looks like we may be able to say
> something along the lines of " -o ControlMaster=auto ".

People who want that will presumably set it in their ssh configuration.

	-Daniel
*This .sig left intentionally blank*
