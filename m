From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Mon, 24 Sep 2007 15:57:45 +0200
Message-ID: <86odfstbc6.fsf@lola.quinscape.zz>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <loom.20070924T134013-959@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 16:08:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZoc1-0004qD-Oo
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 16:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbXIXOIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 10:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbXIXOIa
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 10:08:30 -0400
Received: from main.gmane.org ([80.91.229.2]:37389 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbXIXOI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 10:08:29 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IZoYY-0001Ua-5m
	for git@vger.kernel.org; Mon, 24 Sep 2007 14:05:02 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 14:05:02 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 14:05:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:AwpDJIYkkJmbt+bTisJRBKHw3DI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59051>

figo <rcc_dark@hotmail.com> writes:

> http://www.research.att.com/~bs/applications.html
>
> just as Bjarne once wrote in his TC++PL, its hard to teach an old dog new 
> tricks. Its even harder to give quality education about how to use something 
> to someone who doesnt want to learn.
>
> you hate high level, then continue programming operative systems,
> please NEVER DO something else. C++ was designed to give programmers
> high level tools and still being able to take care about
> performance.
>
> portability wont be possible after a standard is published and some
>couple of years given to the compiler developers. C++ had its
>standard in 1998, and add two or three years for compiler development
>= 2002. "Quite recently", way more recently that your last use of C++
>I can bet.

Care to explain why there are still not two numerical C++ libraries
with compatible matrix classes?

What use is talking about portability and high level when a basic
interoperability feature that has been available since the sixties
(more than 4 decades ago) in Fortran has not yet managed to make it
into C++?  C++ by now more or less offers a (somewhat deficient)
standardized way to work with complex numbers, but matrices are still
not standardized in any manner, and libraries won't interoperate.

So C++ should get its head wrapped around the _low_ level problems
first.  It is a bloody shame that it still has not caught up with
Fortran IV (or even Fortran II) with regard to usefulness for
numerical libraries.

It is not a matter of "hating high level" to see that C++ is mostly
focused about addressing the wrong kinds of problems in the wrong
ways.  The pain/gain ratio is just bad.

-- 
David Kastrup
