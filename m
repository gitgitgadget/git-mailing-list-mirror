From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: msysgit clone/pull/fetch broken
Date: Thu, 2 Dec 2010 13:43:50 +0100
Message-ID: <AANLkTi=cPj2poOpZa3M-UVjQmjQ3BKj3FBJHQc_+Z6Vb@mail.gmail.com>
References: <loom.20101201T141924-761@post.gmane.org> <AANLkTinaxO1FVb-MvY91mscUcpNtbxQH0vTvE4YJrJtB@mail.gmail.com>
 <loom.20101202T081807-557@post.gmane.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?B?Wm9sdOFuRvx6ZXNp?= <zfuzesi@eaglet.hu>
X-From: git-owner@vger.kernel.org Thu Dec 02 13:44:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO8WH-0002m9-Fg
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 13:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078Ab0LBMoM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 07:44:12 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33174 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394Ab0LBMoL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Dec 2010 07:44:11 -0500
Received: by fxm20 with SMTP id 20so1084291fxm.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 04:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=+dGHNHwgwaZGZgAZ1XHp28Rw6GYVo7o/mg1FFE6n3IU=;
        b=NmXp7hPfAAsj4PD498yTNID3SwJWR2B/MQfkZ8TCwf2/zYrdId2ugNKhR/abrASSaj
         udMr+/1FdOAiZcn+MTdHwsbyU4Vb/6E2OlVbJokfrFwr94ukYogYxu+emL5QcXsnV7kz
         V6y8tV4JsgH1X3wDOb3R4ND2poLcoMKnUxHDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=OemQPd1bMGPRqVGtfbfr1TaY6i7wGsmsu8bJBg9bi+pfKV7IZ0o2fjl19J+DJPE4Wg
         9ZeS2FeTjwdU1J7ADt2I6xFNz6mEP47BMKunzBvAj/c2bw9L3B4PfeR1gwUEL4bcBQ5f
         ZrukhFwYrrfYILdw4yzxsQmp1slU/x+FKDKUY=
Received: by 10.223.81.70 with SMTP id w6mr537384fak.18.1291293850343; Thu, 02
 Dec 2010 04:44:10 -0800 (PST)
Received: by 10.223.95.202 with HTTP; Thu, 2 Dec 2010 04:43:50 -0800 (PST)
In-Reply-To: <loom.20101202T081807-557@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162699>

On Thu, Dec 2, 2010 at 8:28 AM, Zolt=E1nF=FCzesi <zfuzesi@eaglet.hu> wr=
ote:
> Erik Faye-Lund <kusmabite <at> gmail.com> writes:
>
>>
>> On Wed, Dec 1, 2010 at 2:31 PM, Zolt=E1nF=FCzesi <zfuzesi <at> eagle=
t.hu> wrote:
>> > Hi, I can't clone/pull/fetch from any of my repositories with the =
latest
> stable
>> > version (1.7.3.2.430.g208247) on Windows.
>> >
>> > $ git clone --recursive git://server/user/project.git
>> > Cloning into project...
>> > fatal: failed to read object <sha1>: No error
>> >
>> > After reverting commit 3ba7a065527a27f45659398e882feaa1165cbb4c ("=
A loose
> object
>> > is not corrupt if it cannot be read due to EMFILE") it works.
>> >
>> > On Linux everything is fine.
>>
>> I've already submitted a patch-series that address this issue:
>> <1290533444-3404-1-git-send-email-kusmabite <at> gmail.com>
>>
>
> Thanks! Could you give me the sha1(s) of those patches? I've found so=
me of your
> recent patches, but they have already been merged into master.
>

I don't think the patches has been merged yet, so I don't really have
a SHA-1 for the series. But you could pull the topic from
git://repo.or.cz/git/kusma.git work/win32-dirent
