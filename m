From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-grep to operate across who repository and not just CWD?
Date: Tue, 01 Mar 2011 09:54:55 +0100
Message-ID: <4D6CB45F.1030800@drmicha.warpmail.net>
References: <AANLkTimnOSzF1o-fX-n7b26Qx2aLP3aU3pTMGY_f5hKy@mail.gmail.com> <4D6B6A8B.20709@drmicha.warpmail.net> <4D6C20F6.3070905@cisco.com> <4D6CA8B7.5000608@drmicha.warpmail.net> <AANLkTim78nQgS7NPXWErQyrqmt41OUXY6gzJmMwjtxo9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <hordp@cisco.com>,
	David Chanters <david.chanters@googlemail.com>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 09:58:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuLPW-0000aW-84
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 09:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755638Ab1CAI6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 03:58:21 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35306 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754364Ab1CAI6U (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 03:58:20 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 39D6620BBA;
	Tue,  1 Mar 2011 03:58:20 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 01 Mar 2011 03:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=eCoQWgQHA0grW08Z4pc2S2wUKVE=; b=K9qm6uQbPoYyToKCbfF4lv6bDWoAWGxGflgDWofJhjHSvID5uLbv0/hCVR+anYQZMA0ttG4L4uZp5bstw4VhiiuN2VWMUc6+sYuvVqq3KeTe2bgG8gN2Jeo5cFVQ28rKXo1Vk6dtjcxjV57K6MC428UXGXhYyMGNaSuadi5LBz0=
X-Sasl-enc: zH4yKgKOamAQo1u/8D/Ymbw7jh7TzVriEUfAPcWqqaXm 1298969899
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 792FE400DD8;
	Tue,  1 Mar 2011 03:58:19 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTim78nQgS7NPXWErQyrqmt41OUXY6gzJmMwjtxo9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168193>

Nguyen Thai Ngoc Duy venit, vidit, dixit 01.03.2011 09:16:
> On Tue, Mar 1, 2011 at 3:05 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> I would love "git grep" to be repowise, with the simple "git grep ." to
>> make it relative to cwd. We've discussed making more commands repowise,
>> and the consensus (which I've stated above, accepting the majority vote)
>> was that some should stay, e.g. git-grep. The discussion started with
>>
>> <http://permalink.gmane.org/gmane.comp.version-control.git/166135>
>>
>> and the consensus is stated here:
>>
>> <http://permalink.gmane.org/gmane.comp.version-control.git/167149>
>>
>> This does not prevent you from submitting a "--full-tree" patch for
>> git-grep, of course.
> 
> In fact Junio wrote one:
> 
> http://mid.gmane.org/7vk4xggv27.fsf@alter.siamese.dyndns.org

Oh yes, thanks for reminding me. And guess who replied first back then?
Oh well...

> If I remember correctly, it was dropped because of the interaction
> with pathspecs (relative to cwd vs to worktree's root). I'd be great
> if someone can pick it up and finish it.

Rereading that thread, I don't think there was any objection against
"--full-tree", but it suffered from DTD (discussed-to-death). To make it
really usefull, one would need a short-cut/option/whatever, and that's
where the discussion went astray. I have an idea, though :)

Michael
