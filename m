From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 07 Sep 2007 08:52:44 +0200
Message-ID: <85642n7yrn.fsf@lola.goethe.zz>
References: <46DDC500.5000606@etek.chalmers.se>
	<1189004090.20311.12.camel@hinata.boston.redhat.com>
	<vpq642pkoln.fsf@bauges.imag.fr>
	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	<alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
	<a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
	<alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
	<a1bbc6950709061808q85cf75co75f2331dc2bdbcbe@mail.gmail.com>
	<alpine.LFD.0.999.0709070212300.5626@evo.linux-foundation.org>
	<a1bbc6950709062009x59a41cb7re6051739c11e370c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 08:52:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITXhz-00074B-9I
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 08:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbXIGGwr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 02:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbXIGGwq
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 02:52:46 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:55952 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932554AbXIGGwq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 02:52:46 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id A10BA32E72D;
	Fri,  7 Sep 2007 08:52:44 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id 925DA212FA9;
	Fri,  7 Sep 2007 08:52:44 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-044-151.pools.arcor-ip.net [84.61.44.151])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 6C8B912F599;
	Fri,  7 Sep 2007 08:52:44 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 17D991CAD71B; Fri,  7 Sep 2007 08:52:44 +0200 (CEST)
In-Reply-To: <a1bbc6950709062009x59a41cb7re6051739c11e370c@mail.gmail.com> (Dmitry Kakurin's message of "Thu\, 6 Sep 2007 20\:09\:23 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4175/Thu Sep  6 22:16:54 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57991>

"Dmitry Kakurin" <dmitry.kakurin@gmail.com> writes:

> ... and explain where I'm coming from:
> My goal is to *use* Git. When something does not work *for me* I want
> to be able to fix it (and contribute the fix) in *shortest time
> possible* and with *minimal efforts*. As for me it's a diversion from
> my main activities.
> The fact that Git is written in C does not really contribute to that goal.
> Suggestion to use C++ is the only alternative with existing C codebase.
> So while C++ may not be the best choice "academically speaking" it's
> pretty much the only practical choice.

Sorry, but for fixing things in C, I can look and work locally.  For
fixing things in C++, I first need to understand the class
hierarchies used in the project.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
