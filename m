From: fork0@t-online.de (Alex Riesen)
Subject: Re: comparing file contents in is_exact_match?
Date: Mon, 17 Jul 2006 00:36:07 +0200
Message-ID: <20060716223607.GA6023@steel.home>
References: <20060706055729.GA12512@admingilde.org> <87k66p8jee.fsf@mid.deneb.enyo.de> <Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de> <87fyh1ncm0.fsf@mid.deneb.enyo.de> <f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 17 00:36:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2FDu-0005aF-2A
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 00:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWGPWgS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Jul 2006 18:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWGPWgS
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Jul 2006 18:36:18 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:65471 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750752AbWGPWgR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jul 2006 18:36:17 -0400
Received: from fwd33.aul.t-online.de 
	by mailout10.sul.t-online.com with smtp 
	id 1G2FDi-0002hh-02; Mon, 17 Jul 2006 00:36:14 +0200
Received: from tigra.home (r1pyDsZC8eH5rxC0Pa4yWNHm7Be26-Fc-LN-xzewMHvLibcWuoGpkE@[84.160.88.78]) by fwd33.sul.t-online.de
	with esmtp id 1G2FDc-1vhUxc0; Mon, 17 Jul 2006 00:36:08 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 9D2D4277AF;
	Mon, 17 Jul 2006 00:36:07 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1G2FDb-0002f9-HV; Mon, 17 Jul 2006 00:36:07 +0200
To: Yakov Lerner <iler.ml@gmail.com>
Content-Disposition: inline
In-Reply-To: <f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com>
User-Agent: Mutt/1.5.6i
X-ID: r1pyDsZC8eH5rxC0Pa4yWNHm7Be26-Fc-LN-xzewMHvLibcWuoGpkE
X-TOI-MSGID: 67630f6b-e68f-4a8f-9bba-af251605cf8a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23957>

Yakov Lerner, Sun, Jul 16, 2006 17:03:49 +0200:
> Cygwin has mmap. But cygwin's mmap() not good enough for git.
> What happens is that git does rename() when target file has active mmap().
> In cygwin, this makes rename() to fail. This is what makes cygwin's
> mmap unusable for git. (BTW for read-only git access, mmap() will work
> on cygwin, for what I saw. But attempts to modify index will break).

It is not Cygwin really. It's windows. You can't rename or delete an
open or mmapped file in that thing.
