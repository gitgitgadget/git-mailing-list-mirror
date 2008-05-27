From: "=?ISO-8859-1?Q?Barra_Mac_Math=FAna?=" <barrymac@gmail.com>
Subject: Re: cvsimport in cron
Date: Tue, 27 May 2008 15:31:17 +0000
Message-ID: <ce7555260805270831j648a0e36laaac7b0a7c349e7@mail.gmail.com>
References: <17476529.post@talk.nabble.com>
	 <46a038f90805261613v4ad72ddcxe6ee78fa0b54f89e@mail.gmail.com>
	 <ce7555260805270345x353cfc76ja3f7ec83a0ab5c61@mail.gmail.com>
	 <g1gq3u$jb$1@ger.gmane.org>
	 <1211895207.7877.4.camel@isidore.myhome.westell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: "John J. Franey" <jjfraney@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 17:32:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K11A5-0004YB-IA
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 17:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755800AbYE0PbU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 May 2008 11:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755905AbYE0PbU
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 11:31:20 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:13378 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755743AbYE0PbT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 May 2008 11:31:19 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1966706wxd.4
        for <git@vger.kernel.org>; Tue, 27 May 2008 08:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5cqVJPHRq7tMpYOg8RTGaazYYCTtYghpNNM334uhqdM=;
        b=JClsvbXw7cukFa/A1kDERh5thKuEPGDaDvgX1CH5rdfjj6Ap0dqF03xDjDO/McldpcgkSwBcEXi5g/PxkWVxNMeOE7ZozeaDqHUKb5XT1PQDqhocWICU1V9AaXjzTCOq+IArXZOSZfxcmollGCQ5SPEWmpVJiraaMqjDG+RbidA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k11SklSZl6ye1vRPNHXdd4qkwTc7Dw1+iKkwe039448sbSXs+0Cl1+HaxvotdVWdkQZjwpdeDzDclONXxJ1YjfpaxqpgAgAL6J9b8n6BpTepTu8882z190HTfjlSBm7ywU9JA6A0GqCDfoGbDCuQj7b2QfenL7KZCTXoA48Tfqc=
Received: by 10.70.13.6 with SMTP id 6mr1811998wxm.17.1211902278062;
        Tue, 27 May 2008 08:31:18 -0700 (PDT)
Received: by 10.70.51.9 with HTTP; Tue, 27 May 2008 08:31:17 -0700 (PDT)
In-Reply-To: <1211895207.7877.4.camel@isidore.myhome.westell.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83025>

Wow thanks so much!!

It's great to get such a quality response from the mailing list!

On to the next problem :-)


On Tue, May 27, 2008 at 1:33 PM, John J. Franey <jjfraney@gmail.com> wr=
ote:
> On Tue, 2008-05-27 at 13:08 +0200, Michael J Gruber wrote:
>> Barra Mac Math=FAna venit, vidit, dixit 27.05.2008 12:45:
>> > Thanks Martin,
>> >
>> > Nice to know how to log the progress! Good tip to try normal cvs o=
ver
>> > ssh, which works fine.
>> >
>> > I wish it was possible to get more verbose output from the git
>> > cvsimport command. The connection refused error seems to me to be
>> > misleading. I would expect at least some output from cvsps but it
>> > doesn't even get to the first step.
>> >
>> > So if everything works at the command line, what significant thing=
s
>> > can be different in a cron job?
>>
>> The environment! Put "env" in your cron job and compare the output t=
o
>> "env" on the command line. cvs or cvsps may be in $PATH on the comma=
nd
>> line but not in cron, or $PERL5LIB might be different.
>>
>> Cheers,
>> Michael
>>
>
> Great suggestion!
>
> I am also having this problem.  To debug, I inserted env as you
> suggested.  (Doh, why didn't this occur to me weeks ago?).  I compare=
d
> the output of cron and login-shell runs.
>
> So what is the critical env diff between cron run and login run?
>
> The answer is:  CVS_RSH=3Dssh
>
> Be sure to export.
>
> Thanks.
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>



--=20
I must Create a System, or be enslaved by another Man's
Wm. Blake 1757 - 1827
