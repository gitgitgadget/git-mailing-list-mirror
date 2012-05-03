From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Thu, 03 May 2012 11:20:56 -0700
Message-ID: <4FA2CC88.9000207@palm.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com> <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com> <20120501111415.GD5769@thunk.org> <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com> <4FA02830.3040407@palm.com> <86havzoi8h.fsf@red.stonehenge.com> <4FA04D02.6090702@palm.com> <86mx5rmx32.fsf@red.stonehenge.com> <7v62cf8v2d.fsf@alter.siamese.dyndns.org> <4FA054BA.80601@palm.com> <86ipgfmw05.fsf@red.stonehenge.com> <4FA05C66.2060608@palm.com> <CAMOZ1BuiznhrzEOHe0N+uu=mLEw5wWTQyDpnwG8PuF1f_aNaXw@mail.gmail.com> <5ADB8D763B2B4CDA889052A1AA45F089@PhilipOakley> <67e635d73b952088917d197cbbd06684@ulrik.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Philip Oakley <philipoakley@iee.org>,
	Michael Witten <mfwitten@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Thu May 03 20:32:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ0ox-0007Nk-RF
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 20:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758006Ab2ECScA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 14:32:00 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:24523 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757977Ab2ECSb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 14:31:59 -0400
X-IronPort-AV: E=Sophos;i="4.75,526,1330934400"; 
   d="scan'208";a="13293433"
Received: from unknown (HELO ushqusdns4.palm.com) ([148.92.223.164])
  by smtp-relay2.palm.com with ESMTP; 03 May 2012 11:20:59 -0700
Received: from fuji.noir.com ([10.100.2.12])
	by ushqusdns4.palm.com (8.14.4/8.14.4) with ESMTP id q43IKuaL022745;
	Thu, 3 May 2012 11:20:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <67e635d73b952088917d197cbbd06684@ulrik.uio.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196932>

On 5/3/12 09:08 , Hallvard Breien Furuseth wrote:
>   Philip Oakley wrote:
>> A bit of browsing found
>> http://stevelosh.com/blog/2009/08/a-guide-to-branching-in-mercurial/
>> which helped with some of the confusion about the different meanings
>> of "branch". It looks like an Hg branch is a Git clone.  Git can be
>> hard work until one 'gets' how and why the new DVCS approach works.
>> Plus learing the UI.
>   Aha, now this thread finally makes some sense.  So when Rich
>   wants a "branch" with several tips, he actually wants several
>   Git clones (repositories) with the same Git branch checked out -
>   and some of them with local commits to it.
Yes.
>   And these commits can be shared as remote branches between the
>   clones, which in Hg-speak means that in one particular clone,
>   Git will "bookmark" the other clones' tips.
Well, no.  In hg, these are all managed.  So there's no scaling issue.  
They can all push/pull together, since they are really all just one 
shared branch.  Adding a new repository to the mix is trivial.  And 
either pushes or pulls can be used, or any combo.

With git, I must manually make space for each and every repository, 
manually track which set of changes are where, manually track which need 
to be merged, and manually track which repositories are looking at which 
git branches so that they don't collide, or only collide in the current 
repository and only when I'm prepared to merge them.

(The bookmark solution appears to be what hg-git uses.  Hg-git is an hg 
extension to allow push/pull/clone from git repositories using hg.  
Unfortunately, it doesn't translate git submodules into hg 
subrepositories - yet.)

--rich
