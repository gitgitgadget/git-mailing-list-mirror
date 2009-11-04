From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 11/13] Allow helpers to request the path to the .git
  directory
Date: Wed, 4 Nov 2009 18:17:11 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911041748150.14365@iabervon.org>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>  <1257364098-1685-12-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0911041621400.14365@iabervon.org>  <fabb9a1e0911041406tce0956ai2ad3fe6cfbdc546d@mail.gmail.com> 
 <alpine.LNX.2.00.0911041723010.14365@iabervon.org> <fabb9a1e0911041442k493c5d7cx493c2e5dac9d892c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 00:19:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5p6T-0006a9-QV
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 00:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933077AbZKDXRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 18:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933073AbZKDXRI
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 18:17:08 -0500
Received: from iabervon.org ([66.92.72.58]:37872 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933063AbZKDXRH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 18:17:07 -0500
Received: (qmail 7369 invoked by uid 1000); 4 Nov 2009 23:17:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Nov 2009 23:17:11 -0000
In-Reply-To: <fabb9a1e0911041442k493c5d7cx493c2e5dac9d892c@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132169>

On Wed, 4 Nov 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Wed, Nov 4, 2009 at 23:27, Daniel Barkalow <barkalow@iabervon.org> wrote:
> >> The marks option has been dumped in favor of 'feature import-marks='
> >> and 'feature export-marks=' which will be in the reroll of
> >> sr/gfi-options.
> >
> > Right, but the values of those have to be paths, and I think they should
> > be relative paths, relative to the helper's state directory.
> 
> Hmmm, I don't remember exactly what we decided the paths should be
> releative, pretty sure it was somewhere in .git/ though.

Well, gfi is used with different native systems, each of which will 
presumably put it somewhere different.

	-Daniel
*This .sig left intentionally blank*
