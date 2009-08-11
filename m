From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: block-sha1: improve code on large-register-set machines
Date: Tue, 11 Aug 2009 18:13:16 -0500
Message-ID: <64Kyx_w-_2GgXIdUn26ky9qHnuvHBH2QTe9tAj1uuLv-1YDZNVLNKA@cipher.nrlssc.navy.mil>
References: <alpine.LFD.2.01.0908101637440.3417@localhost.localdomain> <alpine.LFD.2.00.0908102246210.10633@xanadu.home> <alpine.LFD.2.01.0908110758160.3417@localhost.localdomain> <alpine.LFD.2.00.0908111254290.10633@xanadu.home> <alpine.LFD.2.00.0908111517390.10633@xanadu.home> <fLYKSyures_wcvAvAV9-MgKQlhk959HJpx-pKz7T1n-Mel7f2RBkMw@cipher.nrlssc.navy.mil> <alpine.LFD.2.01.0908111553460.28882@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 01:13:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb0XM-0006eV-M8
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 01:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544AbZHKXNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 19:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755524AbZHKXNj
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 19:13:39 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40998 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbZHKXNi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 19:13:38 -0400
Received: by mail.nrlssc.navy.mil id n7BNDGSj022279; Tue, 11 Aug 2009 18:13:16 -0500
In-Reply-To: <alpine.LFD.2.01.0908111553460.28882@localhost.localdomain>
X-OriginalArrivalTime: 11 Aug 2009 23:13:16.0228 (UTC) FILETIME=[4E97D840:01CA1AD9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125618>

Linus Torvalds wrote:
> 
> On Tue, 11 Aug 2009, Brandon Casey wrote:
>> In that case, why not change the interface of blk_SHA1Block() so that its
>> second argument is const unsigned char* and get rid of __d and the { } ?
> 
> Because on big-endian, or on architectures like x86 that have an efficient 
> byte swap, that would be horrible.

Sorry, I missed Nicolas's first message where he said his SHA_SRC macro was
for arm only.

I started at your reply to him which only has the snippet which says
"...this provides the exact same performance as the ntohl() based version
except that this now cope with unaligned buffers too".

My mistake.

-brandon
