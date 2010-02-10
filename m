From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: What should I do to display the diff of even a simple merge 
	commit?
Date: Wed, 10 Feb 2010 01:07:01 +0100
Message-ID: <46d6db661002091607ka7a9c9bncc996bd5d8a26a88@mail.gmail.com>
References: <46d6db661002091545j74f625ffr74ca70a0474948fc@mail.gmail.com>
	 <20100209235707.GQ9553@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Feb 10 01:07:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf071-0005qF-HA
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 01:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208Ab0BJAHH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 19:07:07 -0500
Received: from mail-bw0-f223.google.com ([209.85.218.223]:48398 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab0BJAHF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Feb 2010 19:07:05 -0500
Received: by bwz23 with SMTP id 23so791233bwz.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 16:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bD39p+1IV5mGQh02vJdngIFh0TN+jaaiuAYvL1L8OEw=;
        b=iVfs6HWnyUKh5Q6oGKYJtAqnh15c1R4/ZSdsb7JRo99YbpSWGA1ysj3OSq0wgFfEjH
         rsvquXUDLyrsxIzbnbQMUxtWNpgXAqc28hGlct5DGptPWrLyOBvZWR0CUXE5rEG+KQOg
         yu9kgxBzjGt4yEpDyucOwxm9lt/PIc7K70lCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vAB6a6UWQFKiQi0a0MpVu5cfVWRx7q2erqb8x/HeENQwuWUS34ZKaXSY8hDT1JyVFg
         33PVhFJP7/yjnKd3J2mvB37ktTGqnBNQqKd3rSwZy/3XXaFjzfnAY85tl4YcY3FKyQ/I
         AMHqAd55nxArZo+L5RB1Gzd0V5tRMGZEXonAI=
Received: by 10.204.150.81 with SMTP id x17mr1816191bkv.200.1265760422000; 
	Tue, 09 Feb 2010 16:07:02 -0800 (PST)
In-Reply-To: <20100209235707.GQ9553@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139465>

On Wed, Feb 10, 2010 at 12:57 AM, Petr Baudis <pasky@suse.cz> wrote:
> =A0Hi!
>
> On Wed, Feb 10, 2010 at 12:45:44AM +0100, Christian MICHON wrote:
>> I'm performing many merges between developpers branches these days,
>> most of them not yielding into conflicts. (understand: simple merges=
)
>>
>> All is good, but sometimes, I would like to really like what has bee=
n changed.
>>
>> As I do not systematically do this "git merge --no-commit --stat
>> <list_to_merge>" and then fire "git gui" to inspect the diffs before
>> the real commit, I'm wondering: how could I do this using some
>> plumbing ?
>>
>> Right now, I've tried the obvious git log -c -p, git show -u --cc, b=
ut
>> since the merge are simple merges, I cannot get any diff output. I
>> believe this is by construction.
>>
>> Any hints ?
>
> =A0I'm not sure if there is any clever switch for this, but I usually
> just use one of
>
> =A0 =A0 =A0 =A0git diff mergecommit^1 mergecommit
> =A0 =A0 =A0 =A0git diff mergecommit^2 mergecommit
>
> depending on which parent I want the diff against. If you always do y=
our
> merges as "on mainline, merging in a topic" without fast-forwarding,
> diff against the first parent will be probably the right one and you =
can
> simply use:
>
> =A0 =A0 =A0 =A0git diff mergecommit^ mergecommit
>

Hi Petr,

unfortunately it does not ouput anything :-( the diff is empty, again..=
=2E

I'm fiddling now with "git checkout -f <that-commit>", and I'm faking
an "amend last commit" using "git gui". With this dirty trick, I get
the same diff I would have gotten from git gui with a merge
--no-commit.

Thanks for suggesting !

--=20
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git=
 inside !
