From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: how to squash commits
Date: Sun, 12 Apr 2009 17:54:10 +0200
Message-ID: <vpq1vrxvpel.fsf@bauges.imag.fr>
References: <85b5c3130904111627l7cdd15a1n78271c8e113c4b7a@mail.gmail.com>
	<cd4419280904120508v37314166pb35db8b50ec54839@mail.gmail.com>
	<87d4bhlxlf.fsf@iki.fi> <vpqocv1vr1y.fsf@bauges.imag.fr>
	<871vrxlw4h.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mercurial@selenic.com
To: Teemu Likonen <tlikonen@iki.fi>
X-From: mercurial-bounces@selenic.com Sun Apr 12 18:01:20 2009
Return-path: <mercurial-bounces@selenic.com>
Envelope-to: gcvmd-mercurial@gmane.org
Received: from waste.org ([66.93.16.53] helo=mail.waste.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lt27T-0006bA-1p
	for gcvmd-mercurial@gmane.org; Sun, 12 Apr 2009 18:01:19 +0200
Received: from waste.org (staticwaste [66.93.16.53])
	by mail.waste.org (Postfix) with ESMTP id 052EA5C807B;
	Sun, 12 Apr 2009 11:01:58 -0500 (CDT)
Received: from imag.imag.fr (imag.imag.fr [129.88.30.1])
	by waste.org (8.13.8/8.13.8/Debian-3) with ESMTP id n3CFxb3L007814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <mercurial@selenic.com>; Sun, 12 Apr 2009 10:59:42 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n3CFsCRZ014937
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 12 Apr 2009 17:54:12 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50) id 1Lt20Y-00027g-Un; Sun, 12 Apr 2009 17:54:10 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Lt20Y-000319-SR; Sun, 12 Apr 2009 17:54:10 +0200
In-Reply-To: <871vrxlw4h.fsf@iki.fi> (Teemu Likonen's message of "Sun\,
	12 Apr 2009 18\:39\:10 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0
	(imag.imag.fr [129.88.30.1]);
	Sun, 12 Apr 2009 17:54:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
X-Virus-Scanned: by amavisd-new
X-BeenThere: mercurial@selenic.com
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: <mercurial.selenic.com>
List-Unsubscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=unsubscribe>
List-Archive: <http://selenic.com/pipermail/mercurial>
List-Post: <mailto:mercurial@selenic.com>
List-Help: <mailto:mercurial-request@selenic.com?subject=help>
List-Subscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=subscribe>
Sender: mercurial-bounces@selenic.com
Errors-To: mercurial-bounces@selenic.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116381>

Teemu Likonen <tlikonen@iki.fi> writes:

> Let's add the Git mailing list to the Cc list if someone there wants to
> comment. The whole thread is here:
>
> http://thread.gmane.org/gmane.comp.version-control.mercurial.general/13283/focus=13295
>
>
> On 2009-04-12 17:18 (+0200), Matthieu Moy wrote:
>
>> Teemu Likonen <tlikonen@iki.fi> writes:
>>
>>> With the default settings user has 30 days to
>>> recover the branch's previous state,
>>
>> Actually, s/30 days/90 days/ according to "man git-gc".
>
> I understand it that objects which are not reachable form the tip of
> current branches are subject for garbage-collecting in 30 days. For
> example, let's say we are in "master" branch and do "git reset --hard
> master~1". It makes the previous HEAD commit unreachable from "master"
> branch and it can be GCd in 30 days (?).
>
> My understanding can be wrong, of course. The manual explainst options
> like gc.reflogExpire and gc.reflogExpireUnreachable separately but does
> not draw the big picture how things work.

Oops, I think you're right. I didn't read about
gc.reflogExpireUnreachable carrefully enough.

-- 
Matthieu
