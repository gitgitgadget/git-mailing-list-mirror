From: David Lang <david@lang.hm>
Subject: Re: Is there any efficient way to track history of a piece of
 code?
Date: Thu, 8 May 2014 23:56:36 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1405082354100.17457@nftneq.ynat.uz>
References: <CAHz2CGW4rRWzGMPxM1XsoYvrwrrddrxAr+AKAi5SdMx+3rBjNg@mail.gmail.com> <20140508070051.GA4532@sigill.intra.peff.net> <CAHz2CGV6==abb0SrXOyqwumxEVLFnTtqe1Z4j2A7XcvJNuoAHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jianyu Zhan <nasa4836@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 08:56:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wiejb-0001RK-Vp
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 08:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbaEIG4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 02:56:38 -0400
Received: from mail.lang.hm ([64.81.33.126]:58742 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880AbaEIG4i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 02:56:38 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id s496uaEv008872;
	Thu, 8 May 2014 23:56:36 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <CAHz2CGV6==abb0SrXOyqwumxEVLFnTtqe1Z4j2A7XcvJNuoAHw@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248518>

On Thu, 8 May 2014, Jianyu Zhan wrote:

> That being said, storing abstract syntax tree, instead of raw object in git.
> But that goes too far...

well, there are the clean/smudge filters, you can have it run everything through 
a prettyprinter as it's checked in.

with a little effort, you could do something along the lines of git filterbranch 
that could create a clone of a repo with all commits cleaned up.

David Lang
