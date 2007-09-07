From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Fri, 07 Sep 2007 09:40:00 +0200
Message-ID: <85k5r27wkv.fsf@lola.goethe.zz>
References: <46DDC500.5000606@etek.chalmers.se>
	<1189004090.20311.12.camel@hinata.boston.redhat.com>
	<vpq642pkoln.fsf@bauges.imag.fr>
	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	<alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
	<a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
	<alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
	<alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org>
	<fbqmdu$udg$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Walter Bright <boost@digitalmars.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 09:40:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITYRp-0000k9-I1
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 09:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbXIGHkI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 03:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbXIGHkI
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 03:40:08 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:40459 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964927AbXIGHkG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 03:40:06 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 55DFB17F5B9;
	Fri,  7 Sep 2007 09:40:05 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 457A42DA967;
	Fri,  7 Sep 2007 09:40:05 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-044-151.pools.arcor-ip.net [84.61.44.151])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 298D3292B61;
	Fri,  7 Sep 2007 09:40:01 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id A7B141CAD71B; Fri,  7 Sep 2007 09:40:00 +0200 (CEST)
In-Reply-To: <fbqmdu$udg$1@sea.gmane.org> (Walter Bright's message of "Thu\, 06 Sep 2007 22\:09\:26 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4176/Fri Sep  7 08:46:21 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57999>

Walter Bright <boost@digitalmars.com> writes:

> Linus Torvalds wrote:
>> And if you want a fancier language, C++ is absolutely the worst one
>> to choose. If you want real high-level, pick one that has true
>> high-level features like garbage collection or a good system
>> integration, rather than something that lacks both the sparseness
>> and straightforwardness of C, *and* doesn't even have the high-level
>> bindings to important concepts. 
>>
>> IOW, C++ is in that inconvenient spot where it doesn't help make
>> things simple enough to be truly usable for prototyping or simple
>> GUI programming, and yet isn't the lean system programming language
>> that C is that actively encourags you to use simple and direct
>> constructs.
>
> The D programming language is a different take than C++ has on growing
> C. I'm curious what your thoughts on that are (D has garbage
> collection, while still retaining the ability to directly manage
> memory). Can you enumerate what you feel are the important concepts?

A design is perfect not when there is no longer anything you can add
to it, but if there is no longer anything you can take away.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
