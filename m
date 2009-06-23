From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: push.default???
Date: Tue, 23 Jun 2009 18:32:28 +0200
Message-ID: <f865508f0906230932n4a2f2b54s1e76ab1d70d95073@mail.gmail.com>
References: <h1nks1$vdl$1@ger.gmane.org> <20090623103428.GA4214@pvv.org> 
	<4A40D19E.60606@gmail.com> <20090623131131.GA7011@pvv.org> 
	<4A40D864.8040208@gmail.com> <20090623144805.GB24974@pvv.org>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Jun 23 18:33:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJ8vy-0004qv-2m
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 18:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758788AbZFWQcu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jun 2009 12:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760422AbZFWQcu
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 12:32:50 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:52352 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760847AbZFWQcr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2009 12:32:47 -0400
Received: by bwz9 with SMTP id 9so195162bwz.37
        for <git@vger.kernel.org>; Tue, 23 Jun 2009 09:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=LBKZMBxmNxn6iPeJhJi4vNi5yhOQAytNe6tK4YRo2Uc=;
        b=V88MNl7lg2TwH7FrrzA2P/IPiEwUeGPVTA3vbIk1bUPxMv0T/px2vOIr4Be1GQXLkK
         EVgqyiIlbtJQCvAGuGw+yChC9eDU5qSw6t/EfDSzdKR0TI0aZTe9Zsr0QtuHfXm40st7
         6KZEMU+R47elHLzCBzlFhf8QQUBW4iB150R/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=UC9cZnALYLaJGRZiwDLWHT0UqGT4vPXLMMQ25YFALEl/jCrmAIGMypdnpJL+e6IDFN
         AAj0zJZKXdwMzXyyGHZObOcI75bWv3g4fmL2Y0a9j404sX3xkxY8P5AO6E+0KHrJm3iT
         kaTimZYyLGkloEk4ueHxaB9PcgQ0cHGvS9esQ=
Received: by 10.223.108.196 with SMTP id g4mr327239fap.36.1245774768179; Tue, 
	23 Jun 2009 09:32:48 -0700 (PDT)
In-Reply-To: <20090623144805.GB24974@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122098>

>> 1) I have the permission to push to them (as opposed to sending a pu=
ll
>> request)? =A0If I have permission to push only to the mob branch, fo=
r
>> example, I would still set my tracking branch to the master branch.
>>
>> 2) I *do* want to push to them often? =A0If I use tracking for my to=
pic
>> branches, push.default=3Dtracking seems a sure way to big mess when =
I do
>> "git push" on the wrong branch.
>
> In our shared repositories, we have a few protected branches that onl=
y
> integrators can push to, so no one else can accidentally push to
> them. These are typically the branches that it makes sense to track
> "by default".

Yes, on the other hand you cannot push to them, so talking about them
in the context if push.default is moot. :-)

> If a group sets up a shared public branch, it is typically for
> working together on some feature.
>
> For people used to CVS, this is a nice way to start working with git.
> It requires --tracking to work properly though (--current only works
> if you remember to use the same branch name).

Ok, this *is* a usecase.  Your local branch is named as a feature but
it pushes into master.  Thanks, I have something to reason about now.
:-)

Paolo
