From: Moritz Neeb <lists@moritzneeb.de>
Subject: Re: Starting on a microproject for GSoC
Date: Thu, 28 Jan 2016 11:37:28 +0100
Message-ID: <56A9EF68.5020803@moritzneeb.de>
References: <56A96380.3020308@moritzneeb.de>
 <CAGZ79kbKe8C6iDtRNXgNU4-8EAvgE4RvxVvi-Xzg5Tf++m7z3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 11:39:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOjxL-0005Ix-9n
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 11:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965266AbcA1Khf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 05:37:35 -0500
Received: from moritzneeb.de ([78.47.1.106]:45751 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964816AbcA1Khb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 05:37:31 -0500
Received: from [192.168.1.11] (x4db44a2d.dyn.telefonica.de [77.180.74.45])
	by moritzneeb.de (Postfix) with ESMTPSA id 101431C02A;
	Thu, 28 Jan 2016 11:37:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1453977449;
	bh=I+9OYp8iFYLw5UW2IIgxka/goZcvnesvf6c3IlcSU5M=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
	b=g5aHSXNM6dUYo3ksqklfTy8H2M8dWfq+rtd1TwdQI1b2bN4Ne91QqIq/B8wTLS9T9
	 Z1Av8q4OJUjrCcmXgVFl+EUIwwz4NS7brrG9Bfxtkbpo/0PKw6X6WSTjrv8l06U8Rg
	 MkaNSJHS9qgy9MC3P/x1VD7E3YoBqMEdYLKf0jGc=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <CAGZ79kbKe8C6iDtRNXgNU4-8EAvgE4RvxVvi-Xzg5Tf++m7z3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285005>

On 01/28/2016 02:18 AM, Stefan Beller wrote:
> On Wed, Jan 27, 2016 at 4:40 PM, Moritz Neeb <lists@moritzneeb.de> wrote:
>> Before I may introduce myself: I'm a Computer Science student in
>> Germany, coming towards the end of my Masters. I am an enthusiastic git
>> user that's why I'd like to give something back.
> 
> Giving back is a noble thing. To have most fun at it, you need to ask yourself:
> What is the most obnoxious part of Git that you personally use? What was
> the latest problem you had, which you'd want to fix? If you identified
> that, is that the right size to fix it? (Usually it is way bigger than thought,
> but you can ask around if there are approaches for solving that problem ;)

You're right, creating something that is in the end relevant and useful
for myself is even more fun. I have some itches, I will work on
specifying them. I have the feeling though, that for solving the daily
issues and itches it's not necessary to dig into the core of git.

For example, I sometimes create a commit with the wrong email address (I
try to separate between work/private stuff) and that annoys me. I think
this could be solved by some hook rather than modifying git itself.

> I just realized there are some micro projects on the 2014 page
> as well which haven't been solved yet. (maybe, they are not
> striked through)

Yeah, I realized too that there are some points not striked through in
[0]. Might be just not up to date, for example number 15. seems to be
solved ($gmane//244020). Looking into the code, 14. is solved as well.
For 17. there could be something left.

Thanks,
Moritz

[0] http://git.github.io/SoC-2014-Microprojects.html
