From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Is current HEAD pointing at a given revision ?
Date: Tue, 14 Jun 2011 21:17:39 +0200
Message-ID: <BANLkTikMQxEFEB0wMV0T6DfCFWiiU4ukmg@mail.gmail.com>
References: <BANLkTikFTHc4Qiu1YLxXgPhweNnVqMO11Q@mail.gmail.com>
	<m3mxhkvlcw.fsf@localhost.localdomain>
	<BANLkTimMkOS_Q9gb_ta2P3NSMGyNJtKgJA@mail.gmail.com>
	<201106141817.23585.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 21:17:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWZ7T-00049i-Fx
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 21:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420Ab1FNTRl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2011 15:17:41 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47824 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab1FNTRk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2011 15:17:40 -0400
Received: by pwi15 with SMTP id 15so2778556pwi.19
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 12:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rk0CecouF8G20pwC8ZpB7sm9uwIWMDHVrjMeItJNb38=;
        b=JIoyff1mA/Cz5sNFdxOBd3D1Iehu4kXxnP/TUeGjOaUWw/7ItrZ6plLWLKMlXeq8q9
         6PkQA18MzpaAhjIX4jSmtNIS2FzEcX9L0TX1rFpEusGyxo//bJJiaVhRcOvQ6aJIKJRx
         Ro9gcxabkYyezVfTi/TKIjysdfn+unt3XjwFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MMmVuSELQSdqR6Df7LLn8666ZcsJU3OHxln9r+HAijgJBhaAdSfEJ7RjtssBrUcc89
         JXqYf5Me29xLaBcmhqVphYdnoHwrzUE7cD9/G7HqLPSpcS7lgMXVf+RQtLrP2V9+HjpM
         /BIJUBl6sV9WbjYjqEt2IEG1aOt/kN4AigEWk=
Received: by 10.142.240.20 with SMTP id n20mr1199273wfh.401.1308079059986;
 Tue, 14 Jun 2011 12:17:39 -0700 (PDT)
Received: by 10.142.110.7 with HTTP; Tue, 14 Jun 2011 12:17:39 -0700 (PDT)
In-Reply-To: <201106141817.23585.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175788>

On Tue, Jun 14, 2011 at 6:17 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> Francis Moreau wrote:
>> On Tue, Jun 14, 2011 at 11:00 AM, Jakub Narebski <jnareb@gmail.com> =
wrote:
>> > Francis Moreau <francis.moro@gmail.com> writes:
>> >
>> > > I have a given revision (tag, sha1 ...) and I'd like to know if =
that
>> > > revisions corresponds to what the current HEAD is pointing at.
>> > >
>> > > Could anybody give me some advices for achieving this ?
>> >
>> > If you want to know if given revision (or ref) points at the same
>> > thing as HEAD, you can use
>> >
>> > =A0[ "$(git rev-parse HEAD)" =3D "$(git rev-parse $ref^{commit})" =
]
>> >
>> > or something like that. =A0The '^{commit}' is here in case $ref po=
ints
>> > only indirectly to commit, via a tag object.
>> >
>>
>> I see thanks.
>>
>> I'm not sure what the ^{commit} is for because in the case of tag
>> object, git-rev-parse seems to work fine without the suffix:
>>
>> git rev-parse v2.6.39
>> 8b0753a3df28c21b0570fa21362c5f1b3b4f59bf
>>
>> This is in a kernel git repository
>
> But that is the SHA-1 id of a _tag object_, not of commit (revision)
> it points to. '^{}' means peel to not tag, '^{commit}' means peel to
> commit.
>

Oh I see now, thanks a lot !

--=20
=46rancis
