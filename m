From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Official git repository history?
Date: Tue, 30 Jun 2009 19:06:01 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0906301842430.2147@iabervon.org>
References: <h2aj43$ab0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 01:06:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLmOv-0003af-K4
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 01:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766AbZF3XGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 19:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754585AbZF3XF7
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 19:05:59 -0400
Received: from iabervon.org ([66.92.72.58]:60284 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753612AbZF3XF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 19:05:58 -0400
Received: (qmail 11194 invoked by uid 1000); 30 Jun 2009 23:06:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Jun 2009 23:06:01 -0000
In-Reply-To: <h2aj43$ab0$1@ger.gmane.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122551>

On Mon, 29 Jun 2009, Graeme Geldenhuys wrote:

> Hi,
> 
> Yesterday I cloned the official git repository and for fun I checkout
> out the first ever commit "e83c5163316f..."
> 
> So how did Linus get those first few commits / history into the official
> git repository? Was the first 8 C source code files already enough to
> work as a basic git repository?  Or did he use another revision control
> system and then later imported that history into the official git
> repository (when git was working)?
> 
> Just curious?  :-)

Take a look at http://lkml.org/lkml/2005/4/8/9 and the earliest commits in 
the git.git repository; the directory he mentions had a non-bare 
repository hosting the commits up to that point, which would have been 
e497ea2a9b6c378f01d092c210af20cbee762475.

	-Daniel
*This .sig left intentionally blank*
