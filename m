From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Allow git alias to override existing Git commands
Date: Tue, 10 Nov 2015 22:57:51 +0100
Message-ID: <5642685F.9070405@web.de>
References: <56421BD9.5060501@game-point.net>
 <CAGZ79kZxQWVMe3N1ti8npyp9_4DUPAVy9Uk5a75Jwh3Eud2eZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>,
	Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Tue Nov 10 22:58:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwGvh-0002gA-CG
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 22:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbbKJV6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 16:58:13 -0500
Received: from mout.web.de ([212.227.15.3]:65171 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749AbbKJV6M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 16:58:12 -0500
Received: from [192.168.178.41] ([79.211.101.61]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0Lbrk4-1afTdE2OcW-00jFSn; Tue, 10 Nov 2015 22:58:00
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kZxQWVMe3N1ti8npyp9_4DUPAVy9Uk5a75Jwh3Eud2eZQ@mail.gmail.com>
X-Provags-ID: V03:K0:BjfZFFQEiMvvm2d+rnx6VDXSAOyHXV8926GiPLBOhvGP2krcywF
 46uSvi4i5tdwjOxw11vbpLZvzC0RyQk3tgMbsR7kMBFA6iOD9gimR/qBeZbS0Wq1Rx5d6o/
 drcsf2iQJvuJ2D62DCfpsqvPs3B7V6lYbCG4knkS3jEDJKLjJTsK+zazwAOja5dNI20VkYY
 9NX+gnHWkBxIjK4QQP6/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9OA1GTljTT8=:LkyG89zY8uxrb5lXrgA4PZ
 vq+J8JXRRoqRAaglxNkfUamn2JcSQ9mZ/zZEnYXYmEuDr960xFECuhmxkT2Fr299Un4A7cZzG
 l38m5nzc79G4cGmQKVTwMTGKUEARO8VCfTfSeDu4vn2IuHQemPaucZDqiFLdePFWLCDq3NeGT
 Igbfcy7RknShorzPTCwQUV7PPzVaMx5o6iAIWckiBmJD/b2IfYhcp7SC9MzCNIFfejbY+fezN
 dhWiqdw4qJI45AThtF8a3Ykxb/9wDNgmpmSzTBdOERZhT3EKaVxZ6Wf5SxP1W38GYP8aVTcVj
 j6u71mc2qRrjO8twZTSU44XJGpSt+if6YEbR9s7wTDFdb3QVnRuRglB+LDYB3o+rPHlHjnVxe
 3W8vqkxr21rxGS2yhUPVrfXphnE8OrN167RW+sYFvY90X3ObIbstgoH/OmGZhoRLCse1weCAb
 kKNi/0k76xll1o0hEU8JJVF2Vh3q++AnNwgnbkQra9zI9ybXpdt2Kwp2mvOPt8I8hzL2inbz7
 gsjxl2s3luJ+Qd4FX8OyNQNV6XqK0eRzXu9qa7F/Ua7XlBJVmmck+UGQVt9tdK4kSIhYOjtCr
 XPcZ+VD5G2Sjvj/8jJTVr1usxtYsU9Lw9lD6/rjS0tdg60BTFI0E7ZB1KAEZq8StTFlN1v3Cv
 Y1hNWlKhnfJKW9VTPXsjAO3v3plil5+cLP88yGo15ZLGOxTl/lDv3WJ3mM7BJBLdVATIKkNDB
 ba1uER1OGAj8DOdjwXPkDhFQkLYFhjFZWMl00FhCqrCsNoOeAqdMUHikK1Zl3CVUEJmaxoIf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281135>

Am 10.11.2015 um 19:12 schrieb Stefan Beller:
> On Tue, Nov 10, 2015 at 8:31 AM, Jeremy Morton <admin@game-point.net> wrote:
>> It's recently come to my attention that the "git alias" config functionality
>> ignores all aliases that would override existing Git commands.  This seems
>> like a bad idea to me.
>
> This ensures that the plumbing commands always work as expected.
> As scripts *should* only use plumbing commands, the scripts should
> work with high probability despite all the crazy user configuration/aliases.

Exactly.

>> For example, I wanted to setup "git clone" to automatically act as "git
>> clone --recursive".  Sure I could do it in the shell, but it's more of a
>> pain - any tutorial I set up about doing it would have to worry about what
>> shell the user was using - and if you're going to make that argument, why
>> have "git alias" at all?  It can all be done from the shell.
>
> I think the git way for your example would be to configure git to include that
> option by default, something like
>
>      git config --global submodules.recursiveClone yes
>
> though I was skimming through the man page of git config and did not find
> that option there. I guess it's missing.

We thought about adding such a config option, but I believe that would
fall a bit short. If I want to have recursive clone I also want to init
all those submodules appearing in later fetches too (otherwise the end
result would depend on whether you cloned before or after a submodule
was added upstream, which is confusing). Extra points for populating
the submodule in my work tree when switching to a commit containing
the new submodule.

So what about a "submodule.autoupdate" config option? If set to true,
all submodules not marked "update=none" would automatically be fetched
and inited by fetch (and thus clone too) and then checked out (with my
recursive update changes) in every work tree manipulating command
(again including clone).

Users who only want the submodules to be present in the work tree but
not automagically updated could set "submodule.autoupdate=clone" to
avoid the extra cost of updating the work tree every time they switch
between commits. Now that Heiko's config-from-commit changes are in
master, someone could easily add that to fetch and clone as the first
step. We could also teach clone to make "submodule.autoupdate=true"
imply --recursive and execute the "git submodule" command to update
the work tree as a first step until the recursive checkout patches
are ready.

Does that make sense?
