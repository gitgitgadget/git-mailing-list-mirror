From: David Kastrup <dak@gnu.org>
Subject: Re: [OT] Re: C++ *for Git*
Date: Sun, 23 Sep 2007 23:31:20 +0200
Message-ID: <85ejgpkr13.fsf@lola.goethe.zz>
References: <877imishdp.fsf@catnip.gol.com> <46F55E03.2040404@krose.org>
	<5e4707340709221550o6d0a6062qd51c16a278727c29@mail.gmail.com>
	<20070923020951.GF24423@planck.djpig.de>
	<20070923062527.GA8979@old.davidb.org> <851wcpsv4z.fsf@lola.goethe.zz>
	<e5bfff550709230229t79004ce2j5ce8c2ae7744a7f2@mail.gmail.com>
	<20070923104525.GC7118@artemis.corp>
	<e5bfff550709230642v7fa5e837s7a5b9082b043672d@mail.gmail.com>
	<alpine.LFD.0.999.0709230911360.16478@woody.linux-foundation.org>
	<20070923212239.GA7249@potapov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Alex Unleashed <alex@flawedcode.org>,
	Kyle Rose <krose@krose.org>, Miles Bader <miles@gnu.org>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@nbs-eng.ru>
X-From: git-owner@vger.kernel.org Sun Sep 23 23:31:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZZ35-0007Gc-J3
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 23:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685AbXIWVb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 17:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753635AbXIWVb0
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 17:31:26 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:47762 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752717AbXIWVbZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Sep 2007 17:31:25 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 397B332F74B;
	Sun, 23 Sep 2007 23:31:24 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 29EDD2D3D04;
	Sun, 23 Sep 2007 23:31:24 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-000-085.pools.arcor-ip.net [84.61.0.85])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id F2663292B62;
	Sun, 23 Sep 2007 23:31:23 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 22E891C1F3DC; Sun, 23 Sep 2007 23:31:20 +0200 (CEST)
In-Reply-To: <20070923212239.GA7249@potapov> (Dmitry Potapov's message of "Mon\, 24 Sep 2007 01\:22\:39 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4371/Sun Sep 23 20:52:06 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58987>

Dmitry Potapov <dpotapov@nbs-eng.ru> writes:

> On Sun, Sep 23, 2007 at 09:54:10AM -0700, Linus Torvalds wrote:
>
>>  - the stuff C++ *does* have is usually nasty. Implicit
>>  initializers and destructors and the magic lifetime rules of
>>  objects etc
>
> I am not sure what is wrong with initializers and destructors in
> C++, but certainly there is no magic lifetime rules in C++, as it is
> fully determined by the scope.

It has been some time since I last looked, but the lifetime of objects
constructed in return statements was a moving target through several
standards.  The last standard I bothered looking at had the object
survive until the statement with the function call expression ended:
quite a strange synchronization point with regard to language design.

> In fact, other high level languages that use GC have much more
> unpredictable lifetime rules for objects.

Mostly objects are alive as long as you can refer to them.  Not really
complicated.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
