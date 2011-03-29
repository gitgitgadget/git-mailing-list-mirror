From: =?ISO-8859-1?Q?Daniel_Nystr=F6m?= <daniel.nystrom@timeterminal.se>
Subject: Re: [Q] Mark files for later commit?
Date: Tue, 29 Mar 2011 14:15:12 +0200
Message-ID: <AANLkTiktzbFUtRURaGxxm+dgG+KSOd6cbVQ49x8qK6EZ@mail.gmail.com>
References: <AANLkTi=rPAQas3gvHJ+EFYTXP_YXuULQMk8o8pgkj=9T@mail.gmail.com>
 <7voc4uto9o.fsf@alter.siamese.dyndns.org> <7v8vvytldk.fsf@alter.siamese.dyndns.org>
 <AANLkTik33jiKipcv8d8tY_FXa2nE0BtBdi9vro0gkdQc@mail.gmail.com> <4D91CA31.20908@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 14:15:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Xpe-0001jG-PJ
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 14:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166Ab1C2MP3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 08:15:29 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37904 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab1C2MP3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 08:15:29 -0400
Received: by iyb14 with SMTP id 14so109010iyb.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 05:15:28 -0700 (PDT)
Received: by 10.43.56.205 with SMTP id wd13mr2218665icb.135.1301400927048;
 Tue, 29 Mar 2011 05:15:27 -0700 (PDT)
Received: by 10.231.33.65 with HTTP; Tue, 29 Mar 2011 05:15:12 -0700 (PDT)
X-Originating-IP: [85.24.181.147]
In-Reply-To: <4D91CA31.20908@drmicha.warpmail.net>
X-Google-Sender-Auth: dobpqlE1FQtjeT_WXh7eoedhhcg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170261>

Den 29 mars 2011 14:01 skrev Michael J Gruber <git@drmicha.warpmail.net=
>:
> Daniel Nystr=F6m venit, vidit, dixit 29.03.2011 11:18:
>> Den 29 mars 2011 09:51 skrev Junio C Hamano <gitster@pobox.com>:
>>>> Daniel Nystr=F6m <daniel.nystrom@timeterminal.se> writes:
>>>>> How would you like a git feature like described above, marking fi=
les
>>>>> for later inclusion?
>>>>
>>>> That does not sound like a feature but merely a source of confusio=
n.
>>>
>>> If that is the case, then probably you shouldn't be even updating t=
he
>>> "changelog" file constantly to begin with. =A0Instead, how about cr=
eating a
>>> separate "changelog+" file that is not tracked, and keep its conten=
ts
>>> maintained continuously so stuff won't be forgotten? =A0When the ti=
me to
>>> release comes, you can "mv changelog changelog", and commit it.
>>
>> If we ignore this particular case, how would a "git hold <file>..." =
feature do?
>
> As Junio pointed out, your "hold file" (ChangeLog+) is really not
> versioned (tracked) at all, so it has no place in the worktree.
> Otherwise you'll have constant nagging during the release cycle one w=
ay
> or the other, if you want git to remind you of the files on hold. If =
you
> don't need the reminder, git does not need to know about the file.
> Simply store it somewhere else (such as in .git/description if you do=
n't
> use that, or under .git/info/).

Good points, indeed. But untracked files will be tracked on "git add
=2E" which files on hold won't.

But I agree, the "hold" feature requires a better motivation and more
actual use cases. I thought it may catch some interests on the list.
