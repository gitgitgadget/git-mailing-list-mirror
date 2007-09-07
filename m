From: Walter Bright <boost@digitalmars.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Thu, 06 Sep 2007 22:09:26 -0700
Organization: Digital Mars
Message-ID: <fbqmdu$udg$1@sea.gmane.org>
References: <46DDC500.5000606@etek.chalmers.se>  <1189004090.20311.12.camel@hinata.boston.redhat.com>  <vpq642pkoln.fsf@bauges.imag.fr>  <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>  <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org> <alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 09:20:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITY8U-0004b8-3A
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 09:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbXIGHUI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 03:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbXIGHUI
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 03:20:08 -0400
Received: from main.gmane.org ([80.91.229.2]:47518 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964918AbXIGHUG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 03:20:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1ITY8I-0001vH-Gx
	for git@vger.kernel.org; Fri, 07 Sep 2007 09:20:02 +0200
Received: from c-24-16-50-251.hsd1.wa.comcast.net ([24.16.50.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 09:20:02 +0200
Received: from boost by c-24-16-50-251.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 09:20:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-50-251.hsd1.wa.comcast.net
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57994>

Linus Torvalds wrote:
> And if you want a fancier language, C++ is absolutely the worst one to 
> choose. If you want real high-level, pick one that has true high-level 
> features like garbage collection or a good system integration, rather than 
> something that lacks both the sparseness and straightforwardness of C, 
> *and* doesn't even have the high-level bindings to important concepts. 
> 
> IOW, C++ is in that inconvenient spot where it doesn't help make things 
> simple enough to be truly usable for prototyping or simple GUI 
> programming, and yet isn't the lean system programming language that C is 
> that actively encourags you to use simple and direct constructs.

The D programming language is a different take than C++ has on growing 
C. I'm curious what your thoughts on that are (D has garbage collection, 
while still retaining the ability to directly manage memory). Can you 
enumerate what you feel are the important concepts?
