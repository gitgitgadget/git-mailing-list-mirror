From: "Steven Burns" <royalstream@hotmail.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Tue, 25 Sep 2007 13:19:19 -0600
Message-ID: <fdbmve$8lj$1@sea.gmane.org>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <loom.20070924T134013-959@post.gmane.org> <86odfstbc6.fsf@lola.quinscape.zz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 25 21:19:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaFwi-0008PQ-Gb
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 21:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512AbXIYTTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 15:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbXIYTTl
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 15:19:41 -0400
Received: from main.gmane.org ([80.91.229.2]:55972 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394AbXIYTTk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 15:19:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IaFwO-0001wz-05
	for git@vger.kernel.org; Tue, 25 Sep 2007 19:19:28 +0000
Received: from 200.9.63.21 ([200.9.63.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Sep 2007 19:19:27 +0000
Received: from royalstream by 200.9.63.21 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Sep 2007 19:19:27 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 200.9.63.21
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.3138
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3138
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59155>

The C++ community in general suffers a lot from the NIH Syndrome.
Matrixes, Strings, Vectors, everybody creates their own which are always, or 
course, superior to what's already available.

Again, is not the language's fault, a language is just a language.
It's the way it has been driven.

My two cents.


"David Kastrup" <dak@gnu.org> wrote in message 
news:86odfstbc6.fsf@lola.quinscape.zz...
> figo <rcc_dark@hotmail.com> writes:
>
>> http://www.research.att.com/~bs/applications.html
>>
>> just as Bjarne once wrote in his TC++PL, its hard to teach an old dog new
>> tricks. Its even harder to give quality education about how to use 
>> something
>> to someone who doesnt want to learn.
>>
>> you hate high level, then continue programming operative systems,
>> please NEVER DO something else. C++ was designed to give programmers
>> high level tools and still being able to take care about
>> performance.
>>
>> portability wont be possible after a standard is published and some
>>couple of years given to the compiler developers. C++ had its
>>standard in 1998, and add two or three years for compiler development
>>= 2002. "Quite recently", way more recently that your last use of C++
>>I can bet.
>
> Care to explain why there are still not two numerical C++ libraries
> with compatible matrix classes?
>
> What use is talking about portability and high level when a basic
> interoperability feature that has been available since the sixties
> (more than 4 decades ago) in Fortran has not yet managed to make it
> into C++?  C++ by now more or less offers a (somewhat deficient)
> standardized way to work with complex numbers, but matrices are still
> not standardized in any manner, and libraries won't interoperate.
>
> So C++ should get its head wrapped around the _low_ level problems
> first.  It is a bloody shame that it still has not caught up with
> Fortran IV (or even Fortran II) with regard to usefulness for
> numerical libraries.
>
> It is not a matter of "hating high level" to see that C++ is mostly
> focused about addressing the wrong kinds of problems in the wrong
> ways.  The pain/gain ratio is just bad.
>
> -- 
> David Kastrup
> 
