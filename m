From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Tue, 01 May 2012 15:07:27 -0700
Message-ID: <4FA05E9F.9090709@palm.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com> <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com> <20120501111415.GD5769@thunk.org> <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com> <4FA02830.3040407@palm.com> <86havzoi8h.fsf@red.stonehenge.com> <4FA04D02.6090702@palm.com> <86mx5rmx32.fsf@red.stonehenge.com> <4FA055D0.7040102@palm.com> <86aa1rmvhb.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sitaram Chamarty <sitaramc@gmail.com>, "Ted Ts'o" <tytso@mit.edu>,
	Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Wed May 02 00:07:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPLEM-0005xc-Fo
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 00:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084Ab2EAWH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 18:07:29 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:7800 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab2EAWH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 18:07:28 -0400
X-IronPort-AV: E=Sophos;i="4.75,513,1330934400"; 
   d="scan'208";a="13250105"
Received: from unknown (HELO ushqusdns3.palm.com) ([148.92.223.90])
  by smtp-relay2.palm.com with ESMTP; 01 May 2012 15:07:28 -0700
Received: from fuji.noir.com ([10.100.2.1])
	by ushqusdns3.palm.com (8.14.4/8.14.4) with ESMTP id q41M7R2G009110;
	Tue, 1 May 2012 15:07:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <86aa1rmvhb.fsf@red.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196761>

On 5/1/12 14:39 , Randal L. Schwartz wrote:
>>>>>> "Rich" == Rich Pixley<rich.pixley@palm.com>  writes:
>
>>> I can always "git fetch origin" in my repo, and the remote
>>> branches are in "origin/master, origin/foo, origin/bar".  Totally
>>> separate from my working tree.
>
> Rich>  Sure.  You can fetch other branches, (unless you happen to be
> Rich>  checked out from them).  But you can't fetch to master if you're
> Rich>  checked out from master.
>
> No, you are still missing it.
>
> "git fetch" updates the remote tracking branches, which you commonly
> reference preceded by "origin".  So "git fetch" DOES NOT TOUCH "master".
> It touches only "origin/master".

Yes.  I understand that that is how git typically works in a non-bare 
repository.

Do you understand what I'm saying?

> Only when you merge that remote in to your local master do you need to
> worry about dirty trees or broken merges.
>
> Rich>  My particular situation is that I'm developing a "feature" and to
> Rich>  do that, I need to be testing on multiple machines.  Tens of them.
>
> I think you're now confusing git with a deploy system.  That is also
> something that will lead you to unnecessary grief.  Pick a deploy system
> that's not git, and integrate git with it.

No, not a deploy system.  You use a deploy system to set up something 
like multiple server http farms.  What I'm doing is more akin to porting 
the same piece of software to 20 different operating system 
distributions.  I'm not "deploying" the source code.  I'm developing it.

Thank you for acknowledging that git is a poor match for this scenario, 
though.

> Rich>  I really don't want hundreds of named branches that I must
> Rich>  manually merge from constantly.
>
> I don't see how you would end up with this.

Yup.  I'm beginning to see that.

--rich
