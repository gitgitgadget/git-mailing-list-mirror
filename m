From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: confused about preserved permissions
Date: Mon, 20 Aug 2007 22:07:19 +0200
Message-ID: <20070820200719.GE5544@steel.home>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net> <20070820174142.GA7943@glandium.org> <867inqhyuk.fsf@lola.quinscape.zz> <20070820181357.GA8264@glandium.org> <86zm0mgicy.fsf@lola.quinscape.zz> <20070820184829.GA8617@glandium.org> <20070820194328.GE8542@efreet.light.src> <20070820195037.GA9774@glandium.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 22:07:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INDX3-0006cQ-Nx
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 22:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbXHTUHW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 16:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbXHTUHW
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 16:07:22 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:62293 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbXHTUHV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 16:07:21 -0400
Received: from tigra.home (Fab03.f.strato-dslnet.de [195.4.171.3])
	by post.webmailer.de (fruni mo4) (RZmta 10.3)
	with ESMTP id h01b9cj7KJOFAK ; Mon, 20 Aug 2007 22:07:19 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 9830D277BD;
	Mon, 20 Aug 2007 22:07:19 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 7C60ABDFC; Mon, 20 Aug 2007 22:07:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070820195037.GA9774@glandium.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJAI
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56248>

Mike Hommey, Mon, Aug 20, 2007 21:50:37 +0200:
> On Mon, Aug 20, 2007 at 09:43:28PM +0200, Jan Hudec <bulb@ucw.cz> wrote:
> > Git does not have tracking of file's history either.
> 
> Well, it has ways to track file's history, with blame and log, for
> example. There is nothing similar for directories, though it could be
> possible to do.

It would be not exactly "tracking". You can present the history of
changes which involved the said directory.

And you could do it from day one: git log -- sub/dir
