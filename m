From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Newbie to git
Date: Mon, 28 Dec 2009 11:51:54 -0500
Message-ID: <76c5b8580912280851k141bc6cev36df72b1993b8359@mail.gmail.com>
References: <1435.87.196.47.196.1261932152.squirrel@webmail.decimal.pt>
	 <3a9710ae6b01fabf3b462da607af2534@192.168.1.222>
	 <26ae428a0912271212j70857e29m6248f6ec653f7551@mail.gmail.com>
	 <0a78ff1d3ae5d236fa45c31f7bb8bd54@192.168.1.222>
	 <m27hs8t5b7.fsf@whitebox.home>
	 <7v8wcnx2lq.fsf@alter.siamese.dyndns.org>
	 <7a0ae9cb57a1bc55653872ab254ea922@192.168.1.222>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: mysql.jorge@decimal.pt
X-From: git-owner@vger.kernel.org Mon Dec 28 17:52:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPIp7-0006yt-TV
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 17:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbZL1Qv4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Dec 2009 11:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbZL1Qvz
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 11:51:55 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:39848 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbZL1Qvz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Dec 2009 11:51:55 -0500
Received: by iwn1 with SMTP id 1so7368160iwn.33
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 08:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1DaTREfzQqBNo3VLxLxwkOXCryiMGDKcHi5A93/RrhY=;
        b=eR3UZkuTDtXqZmH7wqg3oeCgI6eqpT3fWDItd2lNLInaFyOs4hSgU7xAUJykV9PJnx
         TGsA62kPlHvB31Jt7VwSmHAb0pkJUzOTVc22ZWUbg9kEtv8lG88iwSASQr8VqAy2s9Wl
         DqwPE+xPrHzVPs3ph6pD4CJdO0k35/qk+Zi5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lW0SrSRTIhCLuJUF2j78QrAsyhe70sGnymXESCcx2LFgLjJlwSB3So8qLkvQ0DlXba
         ZXSbNuw+XBaq87YniM0ZNGU9ifntcr/LNujakO4CsGkhKA8jWfw18MrPlCnhqNvDtOsT
         qNgv9LyjnzFMjEmUlzUerQUr0k796hlq4jaqg=
Received: by 10.231.170.136 with SMTP id d8mr687328ibz.17.1262019114260; Mon, 
	28 Dec 2009 08:51:54 -0800 (PST)
In-Reply-To: <7a0ae9cb57a1bc55653872ab254ea922@192.168.1.222>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135746>

On Mon, Dec 28, 2009 at 5:34 AM, =C2=A0<mysql.jorge@decimal.pt> wrote:
>> If you are addressing Andreas, why does your mail have:
>>
>> =C2=A0 =C2=A0 To: <git@vger.kernel.org>
>> =C2=A0 =C2=A0 Cc: <git@vger.kernel.org>
>>
>> and no other addressee???
>
> My error, sorry :)
>
>> You created "myproject1" somewhere you started "mkdir" in (perhaps i=
n
>> $HOME?) [*1*] and that project tracks a single file "a.txt"; you are
>> correct if that was what you wanted to do.
>>
>> The new repository "myproject1" doesn't have any relation to the bar=
e
>> repository at /home/apache/gitprojects/mydir.git/ you created earlie=
r.
>> The next steps I recommend new people are:
>>
>> =C2=A0(1) push into the public repository, by doing:
>>
>> =C2=A0 =C2=A0 =C2=A0cd myproject1
>> =C2=A0 =C2=A0 =C2=A0git push /home/apache/gitprojects/mydir.git/ mas=
ter
>>
>> =C2=A0(2) make sure push went correctly by trying to clone from ther=
e:
>>
>> =C2=A0 =C2=A0 =C2=A0cd ..
>> =C2=A0 =C2=A0 =C2=A0mv myproject1 myproject1.old
>> =C2=A0 =C2=A0 =C2=A0git clone /home/apache/gitprojects/mydir.git/ my=
project1
>>
>> =C2=A0(3) check if the clone is what you expect
>>
>> =C2=A0 =C2=A0 =C2=A0diff myproject1.old/a.txt myproject1/a.txt
>>
>> =C2=A0(4) once satisfied, remove the old one
>>
>> =C2=A0 =C2=A0 =C2=A0rm -fr myproject1.old
>>
>> And keep working in the myproject1 repository from there on.
>
> Thank you, i understood, i believe i really did. did that test and it=
's
> OK.
> But let me reask in another way:
>
> I want to setup the git server, to accept new branch's created in a r=
emote
> place that will be push'ed to it, please correct me, 'cause i'm doing
> something wrong and i don't know what yet.
>
> - setup git server to run with:
> /usr/lib/git-core/git-daemon --reuseaddr --syslog --export-all
> --enable=3Dreceive-pack --verbose --base-path=3D/home/apache/gitproje=
cts
>
> - created directory /home/apache/gitprojects
> - git init --bare /home/apache/gitprojects
>
> - what will be my link on the remote? "git://192.168.1.206" just?
> - From now on, how can I have access to push projects that exist on o=
ther
> machine?
>
> Sorry for the questions... they are newbie!
> Jorge,


Your /home/apache/gitprojects is a folder where your git repositories
are supposed to be placed.
Your Git repository =3D your project.

By running a git daemon the way you do - you say that you are going to
serve all repositories from /home/apache/gitprojects.

Bare repo =3D repo without working copy - the one which contains only
history and git objects (imagine it to be only .git folder from normal
repo) Therefore for bare repos there is a naming convention so they
have .git extension, while normal repo doesn't. So, myProject.git is
server based bare repo, while myProject is a local repo.

=46inally you have /home/apache/gitprojects/myProject.git

The URL to clone from there will be - should be shown to you by CGIT
if you have everything correctly set up
git://192.168.1.206/myProject.git

Hope that helps,
Eugene
