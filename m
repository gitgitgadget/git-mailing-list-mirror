From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: confused about preserved permissions
Date: Mon, 20 Aug 2007 20:35:11 +0200
Message-ID: <20070820183511.GA5544@steel.home>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Mon Aug 20 20:35:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INC6U-0005UR-RO
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 20:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbXHTSfW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 14:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbXHTSfV
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 14:35:21 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:61964 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbXHTSfU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 14:35:20 -0400
Received: from tigra.home (Fab03.f.strato-dslnet.de [195.4.171.3])
	by post.webmailer.de (fruni mo35) (RZmta 10.3)
	with ESMTP id a01b70j7KFYaGX ; Mon, 20 Aug 2007 20:35:14 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 69367277BD;
	Mon, 20 Aug 2007 20:35:13 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 302ECBDFC; Mon, 20 Aug 2007 20:35:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070820164411.GA15637@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJAI
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56236>

martin f krafft, Mon, Aug 20, 2007 18:44:11 +0200:
> Hello,
> 
> I am a bit confused about how git stores and restores permissions.
> I went to the web but found little other than this post from Linus
> in 2005:
> 
>   http://www.gelato.unsw.edu.au/archives/git/0504/0870.html
> 
> where he basically says that git will *not* save permissions and
> that it also does not save symlinks. I thus discarded the
> information as being outdated. ...

Git tracks just the x-bit. Everything else is controlled by your
umask.

Symlinks are supported since long time.
