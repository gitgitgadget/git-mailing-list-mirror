From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule: make 'show' an alias for 'summary'
Date: Mon, 01 Oct 2012 19:26:34 +0200
Message-ID: <5069D24A.6060101@web.de>
References: <1348926195-4788-1-git-send-email-artagnon@gmail.com> <50670A94.2070504@web.de> <CALkWK0nCahg7165_JuJSj7u0UfYRGZgFjJ6O-o=HCwdsPwU-xg@mail.gmail.com> <50671364.5030205@web.de> <CALkWK0nRKopT4fm36UVyR4Jy1gfeSY4zGy+-nzxm=H=NGcR=DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 19:32:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIjlo-00059J-VN
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 19:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952Ab2JAR0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 13:26:48 -0400
Received: from mout.web.de ([212.227.17.12]:60351 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169Ab2JAR0g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 13:26:36 -0400
Received: from [192.168.178.41] ([91.3.164.110]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0Lud4y-1TRMhG4AzI-0104eA; Mon, 01 Oct 2012 19:26:35
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CALkWK0nRKopT4fm36UVyR4Jy1gfeSY4zGy+-nzxm=H=NGcR=DQ@mail.gmail.com>
X-Provags-ID: V02:K0:zofjAx4q0WfJAadXnzJElQZL3yuL4/7ztLvvyLzf7QL
 gLx0mPeXqYHtv7d0khskVSRYWEEuflvBznv6Sp+o9PB/aIdK5J
 SPslspQcilA0D2JVlH69flZovcy6U2VfVnblf/gK+pN8t9zyQx
 nRbC2xqhoZtVtCRiVAVD0vxK1YKgzlyTU4rOCTi+4+oP3sIxTf
 pOuvYCm6cWlIACS708+Ag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206745>

Am 01.10.2012 08:45, schrieb Ramkumar Ramachandra:
> Jens Lehmann wrote:
>> I'm very interested in your feedback as a first time submodule user,
>> what you wrote above makes sense and explains why you did that patch
>> (and it would have been nice to read some of it in the commit message
>> ;-). What information did you expect to get from a "git submodule
>> show" which isn't already provided by "git status" and "git diff"
>> (especially as they give you some information the "git submodule"
>> commands don't)?
> 
> I expected 'git submodule show' to list all the submodules, and show
> changes to specific submodules like the 'git submodule summary'
> output.

Ok, but "git submodule summary" doesn't list all the submodules,
only those with changes. Maybe "git submodule status" is closer
to what you expect (except for the missing changes)?

And - apart from the list of all submodules - the changes to them
are given by "git status" and "git diff --submodule" too, right?
(sometimes I forget that "--submodule" is not enabled by default,
as I'm a heavy "git gui" user, and that option is used there. We
might need a config option to turn that on) Or is there something
you are missing from their output?

Me too would expect a show command to show me a list of all the
submodules and maybe some extra information (is it populated or
not, does it have its .git directory embedded, does it contain
changes). So maybe "show" should be a slightly pimped "status"?
