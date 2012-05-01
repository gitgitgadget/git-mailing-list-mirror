From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Tue, 01 May 2012 11:52:01 -0700
Message-ID: <4FA030D1.5030301@palm.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com> <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com> <20120501111415.GD5769@thunk.org> <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com> <4FA02830.3040407@palm.com> <CAMOZ1Bue4r7aP75xaeKkFC08WfOqD8O41pkSQGx7RSbW5xWcdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sitaram Chamarty <sitaramc@gmail.com>, "Ted Ts'o" <tytso@mit.edu>,
	Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 20:52:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPIBG-0000af-77
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 20:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757770Ab2EASwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 14:52:04 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:64576 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab2EASwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 14:52:03 -0400
X-IronPort-AV: E=Sophos;i="4.75,512,1330934400"; 
   d="scan'208";a="13246246"
Received: from unknown (HELO ushqusdns3.palm.com) ([148.92.223.90])
  by smtp-relay2.palm.com with ESMTP; 01 May 2012 11:52:02 -0700
Received: from fuji.noir.com ([10.100.2.1])
	by ushqusdns3.palm.com (8.14.4/8.14.4) with ESMTP id q41Iq1a4016208;
	Tue, 1 May 2012 11:52:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAMOZ1Bue4r7aP75xaeKkFC08WfOqD8O41pkSQGx7RSbW5xWcdg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196727>

On 5/1/12 11:20 , Michael Witten wrote:
> On Tue, May 1, 2012 at 18:15, Rich Pixley<rich.pixley@palm.com>  wrote:
>
>> I want pull to work even without merging.  I want to be able to share a
>> branch between different repositories and different users while the source
>> code control system tracks this for me
>
> I believe you are missing the point that a `pull' in git is a `fetch'
> followed by a `merge'. You should read about the `fetch' command by
> reading (`git help fetch'), and make sure you understand how to use
> refspecs; you will probably find it very instructive to play around
> by specifying explicit refspecs to `git fetch' rather than relying
> on the implicit rules (which can be somewhat confusing).

Yes, I'm aware of the distinction within git.  Confusing is an 
understatement.  It seems that in most cases git has no defaults nor 
implicit rules and when it does, they are frequently surprising or 
unfathomable.  I suppose it's nice that they can be set explicitly, but 
sad that they pretty much must be.

That git uses the word "pull" to mean something different than previous 
source code control systems only adds to the confusion.  I was using 
"pull" in the more general sense of pushing and pulling data, not in the 
very narrow meaning of "git fetch + git merge".

I'm still pretty much lost on refspecs and refs.  The terms are 
apparently not used in the manuals I've been reading and they don't seem 
to be used consistently even within git error messages.

Is "refspec" the git word for the branch pointer that points to the 
childless commit that defines a branch?

--rich
