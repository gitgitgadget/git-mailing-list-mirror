From: Jeff Garzik <jeff@garzik.org>
Subject: Re: why does git perpetually complain about include/asm-blackfin/macros.h?
Date: Mon, 02 Jul 2007 10:10:05 -0400
Message-ID: <4689073D.1020802@garzik.org>
References: <Pine.LNX.4.64.0707020800010.1972@localhost.localdomain>	 <4688EF9B.8020405@garzik.org> <9a8748490707020658t5e6542ag6edb435dbc4499ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 16:10:34 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Mbn-0002Pc-79
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 16:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756600AbXGBOKL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 10:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755788AbXGBOKK
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 10:10:10 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:51800 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755727AbXGBOKI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 10:10:08 -0400
Received: from cpe-065-190-165-210.nc.res.rr.com ([65.190.165.210] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1I5MbO-0002Q6-KN; Mon, 02 Jul 2007 14:10:07 +0000
User-Agent: Thunderbird 1.5.0.12 (X11/20070530)
In-Reply-To: <9a8748490707020658t5e6542ag6edb435dbc4499ab@mail.gmail.com>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.9 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51364>

Jesper Juhl wrote:
> On 02/07/07, Jeff Garzik <jeff@garzik.org> wrote:
>> Robert P. J. Day wrote:
>> >   for the umpteenth time, after doing a pull, i see this:
>> >
>> > $ git diff
>> > diff --git a/include/asm-blackfin/macros.h 
>> b/include/asm-blackfin/macros.h
>> > deleted file mode 100644
>> > index e69de29..0000000
>> > $
>>
>> I have the same problem.  git 1.5.0.6 on Fedora Core 5 or 6.
>>
>> I even tried a completely fresh clone, but the problem still appears.
>>
> I've seen that as well, but in my case doing a
> $ git reset --hard master
> fixed it.

Sure.  git checkout -f fixes it too.

But then it reappears the every time I switch branches.

	Jeff
