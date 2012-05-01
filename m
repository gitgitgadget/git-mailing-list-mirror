From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Tue, 01 May 2012 11:15:12 -0700
Message-ID: <4FA02830.3040407@palm.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org>	<4F9F3919.6060805@palm.com> <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com> <20120501111415.GD5769@thunk.org> <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Ted Ts'o" <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 20:15:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPHby-0007ku-HM
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 20:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758601Ab2EASPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 14:15:35 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:14741 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758555Ab2EASP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 14:15:27 -0400
X-IronPort-AV: E=Sophos;i="4.75,512,1330934400"; 
   d="scan'208";a="13245353"
Received: from unknown (HELO ushqusdns4.palm.com) ([148.92.223.164])
  by smtp-relay2.palm.com with ESMTP; 01 May 2012 11:15:13 -0700
Received: from fuji.noir.com ([10.100.2.1])
	by ushqusdns4.palm.com (8.14.4/8.14.4) with ESMTP id q41IFCJ7023605;
	Tue, 1 May 2012 11:15:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196721>

On 5/1/12 09:13 , Sitaram Chamarty wrote:
> On Tue, May 1, 2012 at 4:44 PM, Ted Ts'o<tytso@mit.edu>  wrote:
>> I wouldn't use the verb branch (and certainly not "hydra branch"),
> I coined that phrase for what was described as "[multiple] HEADS of
> the same branch at once in a single repository".
...keeping in mind here that HEAD is a misnomer as HEAD points to the 
currently checked out commit, regardless of where that commit might live 
in the commit graph.  It might be childless, but it might have children.

What I'm talking about is the situation where a branch can have 
multiple, childless commits.  I've switched to calling these "tips" for 
this discussion.
> Sure. What the original poster wants is that all these unnamed commits 
> be magically associated with the branch they were born in, and be 
> propagated via pushes and pulls. As I understand it, he would like a 
> one -> many relationship between branch name and SHA.
Really, what I want is for the push semantic to have a meaning.  I want 
push to work.  I want pull to work even without merging.  I want to be 
able to share a branch between different repositories and different 
users while the source code control system tracks this for me.  And I 
want to create arbitrary network graphs of repositories who all share 
code via push/pull without manual intervention.

These are facilities that we've had in other source code control systems 
for at least a decade.

It seems as though git is tracking all of the info that is needed - 
excepting multiple tips.  The fact that there are converters, including 
dynamic, real time converters, between git repositories and the hg user 
interface suggest that there is, indeed, a near one-to-one mapping 
between mercurial and git.  The only thing that's missing in git is the 
user interface to provide this semantic.  Instead, git simply doesn't do 
what it is asked to do, which seems like a silly user interface choice.

--rich
