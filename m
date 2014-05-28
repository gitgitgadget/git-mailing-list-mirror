From: David Lang <david@lang.hm>
Subject: Re: Git chokes on large file
Date: Wed, 28 May 2014 12:05:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1405281200570.32611@nftneq.ynat.uz>
References: <201405271647.s4RGlDJc024596@hobgoblin.ariadne.com> <CACsJy8BM1f1pJPzGPf--a-kUim6wyX+Mr1AfMupY3mpREY+8DA@mail.gmail.com> <201405281815.s4SIF5hF025886@hobgoblin.ariadne.com> <alpine.DEB.2.02.1405281121200.32611@nftneq.ynat.uz>
 <201405281847.s4SIlW5K027160@hobgoblin.ariadne.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: pclouds@gmail.com, git@vger.kernel.org
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 28 21:05:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpjA0-00027t-0N
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 21:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbaE1TFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 15:05:05 -0400
Received: from mail.lang.hm ([64.81.33.126]:38993 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753464AbaE1TFE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 15:05:04 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id s4SJ509Z014101;
	Wed, 28 May 2014 12:05:00 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <201405281847.s4SIlW5K027160@hobgoblin.ariadne.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250317>

On Wed, 28 May 2014, Dale R. Worley wrote:

>> From: David Lang <david@lang.hm>
>
>> Git was designed to track source code, there are warts that show up
>> in the implementation when you use individual files >4GB
>
> I'd expect that if you want to deal with files over 100k, you should
> assume that it doesn't all fit in memory.

well, as others noted, the problem is actually caused by doing the diffs, and 
that is something that is a very common thing to do with source code.

And I would assume that files of several MB would be able to fit in memory 
(again, this was assumed to be for development, and compilers take a lot of ram 
to run, so having enough ram to hold any individual source file while the 
compiler is _not_ using ram doesn't seem likely to be a problem)

David Lang
