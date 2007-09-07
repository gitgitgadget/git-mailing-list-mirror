From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Sat, 08 Sep 2007 00:28:03 +0200
Message-ID: <85sl5q1570.fsf@lola.goethe.zz>
References: <46DDC500.5000606@etek.chalmers.se>
	<vpq642pkoln.fsf@bauges.imag.fr>
	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	<alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
	<a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
	<alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
	<a1bbc6950709061808q85cf75co75f2331dc2bdbcbe@mail.gmail.com>
	<alpine.LFD.0.999.0709070212300.5626@evo.linux-foundation.org>
	<a1bbc6950709062009x59a41cb7re6051739c11e370c@mail.gmail.com>
	<46E0F04D.7040101@op5.se>
	<a1bbc6950709071517n7e7e99ffl3dd351092e7f19d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 00:28:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITmJQ-0001Yy-K9
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 00:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758638AbXIGW2Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 18:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758618AbXIGW2X
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 18:28:23 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:54018 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758599AbXIGW2X (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 18:28:23 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id D02FC4C5A7;
	Sat,  8 Sep 2007 00:28:21 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id BC6C22D29B9;
	Sat,  8 Sep 2007 00:28:21 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-039-212.pools.arcor-ip.net [84.61.39.212])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 3F0A48C461;
	Sat,  8 Sep 2007 00:28:05 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 45F281CAD71D; Sat,  8 Sep 2007 00:28:04 +0200 (CEST)
In-Reply-To: <a1bbc6950709071517n7e7e99ffl3dd351092e7f19d6@mail.gmail.com> (Dmitry Kakurin's message of "Fri\, 7 Sep 2007 15\:17\:43 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4187/Fri Sep  7 23:12:52 2007 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58087>

"Dmitry Kakurin" <dmitry.kakurin@gmail.com> writes:

> On 9/6/07, Andreas Ericsson <ae@op5.se> wrote:
>> They already have, but every now and then someone comes along and suggest
>> a complete rewrite in some other language. So far we've had Java (there's
>> always one...), Python and now C++.
>
> Since this "complete rewrite" was mentioned in multiple emails I'd
> like to rectify that:
> What I'm offering (for Git) is to use C++ as a "better C".
> Don't change any existing *working* code, but start introducing simple
> C++ constructs in the new code.

You are aware that the Linux kernel was kept compilable under g++ for
a while in its history?  You'll need more than vague words to erase
the memories from that experiment...

Just compiling under C++, with no source changes, is likely to impact
performance and compile time rather badly, not to mention portability
(you need the C++ runtime, for one thing).

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
