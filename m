From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: why does git perpetually complain about
	include/asm-blackfin/macros.h?
Date: Mon, 2 Jul 2007 16:29:26 +0200
Message-ID: <20070702142926.GB10400@fiberbit.xs4all.nl>
References: <Pine.LNX.4.64.0707020800010.1972@localhost.localdomain> <4688EF9B.8020405@garzik.org> <9a8748490707020658t5e6542ag6edb435dbc4499ab@mail.gmail.com> <4689073D.1020802@garzik.org> <81b0412b0707020722q25e8eb41t456e7316fe4a7b40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Jeff Garzik <jeff@garzik.org>, Jesper Juhl <jesper.juhl@gmail.com>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 16:29:34 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5MuC-0006i3-9o
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 16:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbXGBO3a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 10:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754566AbXGBO3a
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 10:29:30 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:35122 "EHLO
	fiberbit.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbXGBO33 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 10:29:29 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.63)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1I5Mu6-0002li-3D; Mon, 02 Jul 2007 16:29:26 +0200
Content-Disposition: inline
In-Reply-To: <81b0412b0707020722q25e8eb41t456e7316fe4a7b40@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51370>

On Monday July 2nd 2007 at 16:22 Alex Riesen wrote:

> Do some of your branches miss the commit by which it was removed?
> (It was removed in df30b1171714bbf0e55ffe02138be4b8447e4235)
> Than it will reappear every time you switch to a branch which still has
> the file.

The problem is that this commit didn't delete the file, but truncated it
to zero size. How it got to be like that is another matter. Within the
kernel zero sized files are not supposed to be there, by widely accepted
practice. So lots of tools assume they should delete them!
-- 
Marco Roeland
