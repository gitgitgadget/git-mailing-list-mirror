From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule: make 'show' an alias for 'summary'
Date: Sat, 29 Sep 2012 17:27:32 +0200
Message-ID: <50671364.5030205@web.de>
References: <1348926195-4788-1-git-send-email-artagnon@gmail.com> <50670A94.2070504@web.de> <CALkWK0nCahg7165_JuJSj7u0UfYRGZgFjJ6O-o=HCwdsPwU-xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 17:28:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THyy6-0000bO-UK
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 17:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755347Ab2I2P1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 11:27:42 -0400
Received: from mout.web.de ([212.227.15.3]:50353 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752512Ab2I2P1l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 11:27:41 -0400
Received: from [192.168.178.41] ([91.3.175.36]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MDgLi-1TE9zh2TvC-00GbzV; Sat, 29 Sep 2012 17:27:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CALkWK0nCahg7165_JuJSj7u0UfYRGZgFjJ6O-o=HCwdsPwU-xg@mail.gmail.com>
X-Provags-ID: V02:K0:g1wtw+6KCHOkqxLvKZuSm1MOYpYlFh/U5qWy61Rk0zr
 5ZQIeyc2QF6HG/XyzYWlqNTUk0uoqr4avFzVh0FoO5UHiaQz1O
 8nd/5z33ssBVi2ry43TIU2VY33L5VENi9IFi5xQafBo1PWmmyc
 eGp4zl9jv4NdQr3HQV6/Is/hRFpn65A4+s/1rXYSubVANrSKZb
 Mr4vZSl8uAXg0au64mZLQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206654>

Am 29.09.2012 17:07, schrieb Ramkumar Ramachandra:
> Jens Lehmann wrote:
>> Am 29.09.2012 15:43, schrieb Ramkumar Ramachandra:
>>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>>> ---
>>>  Like 'git remote show', 'git stash show'.
>>
>> I understand the analogy to "git stash show" (as that also displays
>> a diff similar to what " git submodule summary" does). But "git
>> remote show" just displays a list of configured remotes, which is
>> something different. And the other command with a "show" option is
>> "git notes show", which causes it to display a note. So I think we
>> are pretty inconsistent here and I see no advantage of adding such
>> an alias for "git submodule summary". What am I missing?
> 
> I used submodules for the first time, and expected 'git submodule
> show' to work.  It may not be 100% consistent with the other commands,
> but I think the 'summary' is a good match.  Either way, I don't feel
> strongly about the patch, so feel free to drop it if you think it's
> inappropriate.

I'm very interested in your feedback as a first time submodule user,
what you wrote above makes sense and explains why you did that patch
(and it would have been nice to read some of it in the commit message
;-). What information did you expect to get from a "git submodule
show" which isn't already provided by "git status" and "git diff"
(especially as they give you some information the "git submodule"
commands don't)?
