From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Tags
Date: Sat, 02 Jul 2005 01:00:29 -0600
Message-ID: <m1hdfdg0aa.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org>
	<Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org>
	<42C454B2.6090307@zytor.com>
	<Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org>
	<42C462CD.9010909@zytor.com>
	<Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org>
	<42C46B86.8070006@zytor.com>
	<m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com>
	<42C5714A.1020203@zytor.com>
	<m1u0jef8z9.fsf@ebiederm.dsl.xmission.com>
	<42C5C75F.4040100@zytor.com>
	<m1ll4qf7mg.fsf@ebiederm.dsl.xmission.com>
	<42C5DA77.4030107@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 08:54:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DobtE-0004kO-CI
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 08:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVGBHBr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 03:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVGBHBr
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 03:01:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51118 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261810AbVGBHBo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2005 03:01:44 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6270XOa003828;
	Sat, 2 Jul 2005 01:00:33 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6270THl003827;
	Sat, 2 Jul 2005 01:00:29 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42C5DA77.4030107@zytor.com> (H. Peter Anvin's message of "Fri,
 01 Jul 2005 17:06:15 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
>> If I really care what developer xyz tagged I will pull from them,
>> or a mirror I trust.  And since developer xyz doesn't pull his
>> own global tags from other repositories that should be sufficient.
>>
>
> You're missing something totally and utterly fundamental here: I'm talking about
> creating an infrastructure (think sourceforge) where there is only one git
> repository for the whole system, period, full stop, end of story.

Could be I'm certainly not up to speed on git yet.

However all you have to do for your single system git repository is
to filter tags at creation time.  So for a person to upload something
you need a git aware tool and you need authentication so you are certain
it is the right person creating the tag.  

Since it is a shared repository you probably want rules like you can
only create tags that belong to yourself or are owned by people 
who do not have accounts on the system.

Likewise in a system like sourceforge it is desirable to check all
of the committer information in commits as well, so you have a reasonable
audit trail, and it make sense to check little things like the file under
a sha1 key actually matches the sha1 key.

Downstream mirrors can happily rsync just fine.  So long as they
verify the upstream source.

Tags that you mirror are of course suspect but they will always be.
The primary tags created by people with accounts should be reliable
though.

So in essence I see nothing with my proposal that is any worse than
any other part of git.

That being said, it sounds like there is a slightly more git 
knowledgeable/native version suggested having to do with multiple
heads.

Eric
