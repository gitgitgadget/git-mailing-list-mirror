From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 07 Sep 2007 08:50:03 +0200
Message-ID: <85abrz7yw4.fsf@lola.goethe.zz>
References: <46DDC500.5000606@etek.chalmers.se>
	<1189004090.20311.12.camel@hinata.boston.redhat.com>
	<vpq642pkoln.fsf@bauges.imag.fr>
	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	<alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
	<a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
	<alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
	<a1bbc6950709061808q85cf75co75f2331dc2bdbcbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 08:50:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITXfX-0006Qs-MD
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 08:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbXIGGuH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 02:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbXIGGuG
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 02:50:06 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:56624 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964965AbXIGGuF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 02:50:05 -0400
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id EEA9315B57A;
	Fri,  7 Sep 2007 08:50:03 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id DD20B279402;
	Fri,  7 Sep 2007 08:50:03 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-044-151.pools.arcor-ip.net [84.61.44.151])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 9BC1F22D163;
	Fri,  7 Sep 2007 08:50:03 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 47D341CAD71B; Fri,  7 Sep 2007 08:50:03 +0200 (CEST)
In-Reply-To: <a1bbc6950709061808q85cf75co75f2331dc2bdbcbe@mail.gmail.com> (Dmitry Kakurin's message of "Thu\, 6 Sep 2007 18\:08\:40 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4175/Thu Sep  6 22:16:54 2007 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57990>

"Dmitry Kakurin" <dmitry.kakurin@gmail.com> writes:

> I'll give you reasons why to use C++ for Git (not why C++ is better
> for any project in general, as that again would be pointless):
>
> 1. Good String class will make code much more readable (and
> significantly shorter)
> 2. Good Buffer class - same reason
> 3. Smart pointers and smart handles to manage memory and
> file/socket/lock handles.

But all of those are incompatible with another and require major
headaches and/or interface code to get to run with one another.  And
then might use different interface styles, anyway.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
