From: Walter Bright <boost@digitalmars.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Fri, 07 Sep 2007 13:49:23 -0700
Organization: Digital Mars
Message-ID: <fbsdga$iat$1@sea.gmane.org>
References: <46DDC500.5000606@etek.chalmers.se>	<1189004090.20311.12.camel@hinata.boston.redhat.com>	<vpq642pkoln.fsf@bauges.imag.fr>	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>	<alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>	<a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>	<alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>	<alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org>	<fbqmdu$udg$1@sea.gmane.org> <20070907094120.GA27754@artemis.corp>	<fbs79k$tac$1@sea.gmane.org> <85wsv22ry8.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 22:49:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITklj-0005Ra-Td
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 22:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167AbXIGUtb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 16:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752346AbXIGUta
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 16:49:30 -0400
Received: from main.gmane.org ([80.91.229.2]:51372 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752465AbXIGUta (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 16:49:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ITklW-0000k6-45
	for git@vger.kernel.org; Fri, 07 Sep 2007 22:49:22 +0200
Received: from c-24-16-50-251.hsd1.mn.comcast.net ([24.16.50.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 22:49:22 +0200
Received: from boost by c-24-16-50-251.hsd1.mn.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 22:49:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-50-251.hsd1.mn.comcast.net
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <85wsv22ry8.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58072>

David Kastrup wrote:
> In my opinion there is basically one area which C has botched up
> seriously in order to be useful as a general purpose language, and
> that is conflating pointers and arrays, and allowing pointer
> arithmetic.  The consequences are absolutely awful with regard to
> compilers being able to optimize, and it is pretty much the primary
> reason that Fortran is still quite in use for numerical work.

I agree. It's one of those things that probably sounded like a good idea 
at the time. The consequences were not foreseen. All languages have a 
few of these (C++ has the infamous use of < > for template arguments).
