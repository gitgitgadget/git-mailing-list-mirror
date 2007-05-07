From: =?UTF-8?B?R8OhYm9yIEZhcmthcw==?= <gabor@nekomancer.net>
Subject: Re: FFmpeg considering GIT
Date: Tue, 08 May 2007 00:10:13 +0200
Message-ID: <463FA3C5.70101@nekomancer.net>
References: <loom.20070502T111026-882@post.gmane.org> <20070503180016.GB21333@informatik.uni-freiburg.de> <20070503200013.GG4489@pasky.or.cz> <loom.20070504T143538-533@post.gmane.org> <87y7k4lahq.wl%cworth@cworth.org> <20070505133543.GC3379@diana.vm.bytemark.co.uk> <alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org> <alpine.LFD.0.98.0705051511020.17381@woody.linux-foundation.org> <alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org> <17983.6136.147062.346626@cargo.ozlabs.ibm.com> <20070507175222.GA13927@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Karl Hasselstr?m <kha@treskal.com>,
	Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Tue May 08 00:10:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlBPV-00048z-Th
	for gcvg-git@gmane.org; Tue, 08 May 2007 00:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966586AbXEGWKV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 18:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966658AbXEGWKU
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 18:10:20 -0400
Received: from viefep13-int.chello.at ([213.46.255.15]:25886 "EHLO
	viefep17-int.chello.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966586AbXEGWKU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 18:10:20 -0400
Received: from omoikane.local ([89.173.70.91]) by viefep17-int.chello.at
          (InterMail vM.7.08.02.00 201-2186-121-20061213) with ESMTP
          id <20070507221016.WWEP18668.viefep17-int.chello.at@omoikane.local>;
          Tue, 8 May 2007 00:10:16 +0200
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <20070507175222.GA13927@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46496>

Jan Hudec wrote:
> On Mon, May 07, 2007 at 22:13:44 +1000, Paul Mackerras wrote:
>> I have thought about rewriting it in a different language, but I
>> haven't found anything that really appeals.  I don't want to go to
>> C/GTK or C/Qt since that would make it hard to port to Windows and
> 
> C/Gtk would be perfectly portable. As would C++/Gtk, Python/Gtk and Perl/Gtk.
> C++/Qt4 would be perfectly portable as well, so choose whichever you find
> easier to work with. For C/C++ they are on par, for Python/Perl/Ruby I think
> Gtk has better bindings.
> 
>> MacOS AFAIK.

GTK does not work natively on OSX (it only works using the X11 server ).
QT works fine.

gabor
