From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Should git-remote-hg/bzr be part of the core?
Date: Mon, 12 May 2014 14:05:52 +0200
Message-ID: <5370B920.2060506@alum.mit.edu>
References: <537008f06ceb8_8e47492f89f@nysa.notmuch> <53709788.2050201@alum.mit.edu> <5370a47bee98c_139611a92fc29@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Richard Hansen <rhansen@bbn.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1cw==?= <tboegi@web.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Christophe Simonis <christophe@kn.gl>,
	Dusty Phillips <dusty@linux.ca>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	git-fc@googlegroups.com
X-From: git-owner@vger.kernel.org Mon May 12 14:06:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wjozg-0005b5-Cw
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 14:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154AbaELMGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 08:06:03 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:55069 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755043AbaELMGC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 May 2014 08:06:02 -0400
X-AuditID: 1207440c-f79656d000003eba-13-5370b9283c32
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 22.7B.16058.829B0735; Mon, 12 May 2014 08:06:00 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1CF6.dip0.t-ipconnect.de [93.219.28.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4CC5qlG029644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 12 May 2014 08:05:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <5370a47bee98c_139611a92fc29@nysa.notmuch>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUgTYRznubvdbnMXt9Pc0wytiSjqrCjqqIg+RByEIlp9KMFOPd1ou627
	rVSEJq2oaTU/RLleqFApM98Qc2JUkzKLqb0gQu8vWkrvWtgbdddQ+/Z7/r83Hv5/AqVfq4yE
	VXDxosDZTLgWo9UbFptTgs7cpcffpDE/wt0Yc2LijZq5OP0RZ268EpjuxgGc8T2sQpiRwW4V
	M+2tRpmQt4A5dPArWK9ljw1uYYOBJ2q2p6YfZ8Mvn6PscOM1nB29+UXNjh3uAexkezz7aKwT
	y9Zsi1pbwLl251pLhCXrdkRZ/DXNmHMkvTTc9wnzgAeJPqAhILUChuuqQQTHwqGnLbgPaAma
	egBg/af3IPIYRODA5++4oiKpNHjyXCuqYIxKgqNNv1UKxikzPF+9D/EBgphP5cBf4cURuR72
	177GFBxDWeCfofF/VpRqReD3H0YFR1Or4bvmq//mNLUXVj0bVitYQ62C+ye9mBIJKQOsrsxR
	IEolw5YzdCQlAV55fwr1A33gv7LAnCrwn+osQBtBPGdz2812zmqT+EKzVMgJAi+al2XYra4M
	vsjdDiJb0nWBb80LQ4AigElHsqgzl1Zxu6UyewgsIBDTfPJwqzyaV+AoKrNwkiVfdNt4KQQg
	gZpiyJ/tMkcWcWXlvOiYoeIIzGQgk+qSs2iqhHPxO3neyYsz7EKCMEEyoUs26kW+hC8tttpc
	czRCaJRwrTFG4oUiXuTcLku+st18SV6vQunk3kWKnZScnF2eRqx3gJkY8lzwIjQmOATeaCD1
	iohSRBa3MFsxc5wTwCD/OJpUKyqdfLqzSRNyCSKXrI5zKCUubo4yegDyMevIvKcN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248700>

On 05/12/2014 12:37 PM, Felipe Contreras wrote:
> Michael Haggerty wrote:
>> On 05/12/2014 01:34 AM, Felipe Contreras wrote:
>>> Recently Junio said he was willing to hear the opinion of other people
>>> regarding the move from contrib to the core[1]. This move is already
>>> under way, but suddenly Junio changed his mind.
>>
>> I agree with Junio.  There are good technical arguments for and against
>> moving git-remote-hg out of contrib.
> 
> Saying you agree with Junio is content-free. You have to say *why* you
> agree.

Actually, I don't have to, not even if you tell me to.  And anyway, I
think the small technical advantages/disadvantages of the possible
different locations for git-remote-hg are dwarfed by the social
considerations so I think dwelling on technical considerations would
sidetrack this discussion.

> [...]
> 
>> 1. That subproject has not been maintained to the standards of the Git
>> project;
> 
> The quality of the subjproject has not been called into question, stop
> taiting the discussion with red herrings.

On the contrary.  I just called the quality of the subproject into
question, and I stated exactly which aspects of its quality I find to be
inadequate in the text that you omitted from your response:

> [...] specifically, Git project standards include good commit
> messages and a willingness to engage with the community on a friendly
> and constructive way and to welcome feedback.  Because of your
> confrontational and nit-picking style, Felipe, many people who have
> tried to help you improve your work are rebuffed and end up giving up
> out of frustration or exhaustion.  Because of this, your commits do not
> benefit from the usual amount of help from the community and therefore
> their quality is not as high as required for commits to core Git.

Commit quality very definitely includes the quality of log messages and
the quality of the discussion on the mailing list that can inform people
working on those areas of the code in the future.

>> 2. Moving git-remote-hg into the core would require even *more* of your
>> presence on the Git mailing list.
> 
> That's not true. I sent my patches at my own pace, it doesn't matter if
> they are in contrib or in the core, I would have kept sending them at
> the same pace. I have addressed all issues and responded to all
> questions as if they were already part of the core, which is why they
> have more quality than other tools already in the core. I only stopped
> doing that when Junio changed the direction we had since day one.
> 
> Also a red herring.

OK, maybe you are technically correct there.  There is indeed a
difference between > and >=.  Let me amend my claim:

2. Moving git-remote-hg into the core would require you to continue your
   presence on the Git mailing list.

>>> [...] Does it make sense to you that
>>> you get thrown in jail for a crime you haven't committed merely because
>>> someone thinks it's likely you will?
>>
>> Being the leader of your own valuable open-source project is nothing
>> like jail.  It is an opportunity for you to shine in an environment that
>> is more suited to your personality.
> 
> Don't be ridiculous. There is no out-of-tree tool that could possibly
> compete in popularity against core tools.

I never made that claim.  I claimed that it was "nothing like jail", and
I stand by that claim.  I also think that the Git community is a place
unsuited to someone with your personality, and that you might truly
shine more in an independent project.

> If you think being out-of-tree is not a negative, lets throw out
> git-archimport, git-quiltimport, git-p4, git-cvs, git-svn. Let us give
> them an "opportunity to shine".

In my opinion, the technical issues for moving importers are not
overwhelming.  Therefore, I don't have a strong opinion about the future
of these other tools, because their presence in the Git tree is not
coupled to the continued presence of a problematic subproject maintainer.

> You know that those tools do better in the core, and you know
> git-remote-hg/bzr would do better in the core. Don't act as if you
> didn't.

I maintain cvs2svn/cvs2git outside of the Git core.  In fact, one of
cvs2git's competitors, "git cvsimport" *is* in Git core.  Nevertheless,
users have no problem finding cvs2git, and I think it's safe to say that
its reputation exceeds that of "git cvsimport", even though some people
accidentally use "git cvsimport" out of laziness.

People who need to do a conversion from A to B only have to Google for
"A B" and they will find the best conversion tools pretty easily.  If
the tools are packaged for their OS then they are just an "apt-get
install" away from happiness.  And given that tools like cvs2git or
git-remote-hg, don't even need to be compiled, users can install them
pretty easily themselves.

>> This email is written in sorrow, not in anger.  Felipe, you seem to have
>> so much potential.  If you would put as much effort in conducting social
>> interactions as you do in coding, the whole balance would change
>> entirely, and any software project would be happy to have you.  With all
>> my heart I truly wish you the best in your future endeavors.
> 
> Let's see how sincere you are in your sentiment. I'll reply to you
> personally about the points that I consider to be red herrings and ad
> hominem attacks so we don't taint the dicussion. If you don't reply I'll
> know you were not being sincere.

Jumping at your every demand is not a prerequisite for being sincere.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
