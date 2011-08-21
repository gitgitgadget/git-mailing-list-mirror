From: PJ Weisberg <pjweisberg@gmail.com>
Subject: Re: Merging one file only
Date: Sun, 21 Aug 2011 14:52:31 -0700
Message-ID: <CAJsNXT=UkNT4kk1t9Ji5h_vm+ApahzaTzBwrzwPJCuWMzezw7Q@mail.gmail.com>
References: <1313958819073-6709333.post@n2.nabble.com>
	<CAMOZ1BvY13ynmtCkhFNU9Dc8PqwVQUrp8ham5zHrdq2vbMY5JQ@mail.gmail.com>
	<6EE456FC-9671-4CAF-9067-743AE2526717@maieul.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Ma=EFeul_Rouquette?= <maieul@maieul.net>
X-From: git-owner@vger.kernel.org Sun Aug 21 23:52:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvFwd-00020T-Mm
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 23:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755829Ab1HUVwd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Aug 2011 17:52:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45449 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab1HUVwd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2011 17:52:33 -0400
Received: by fxh19 with SMTP id 19so2932902fxh.19
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 14:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=/6fB1H1MnUdVM7KVLG3wdKIpDzC+lkyIH0X6MYSCn7o=;
        b=rAfbm6M6HqsIHzXTMK/08cysoHvpQhaTHKO7sDdI0O1mUJuTXToZNjzveNwEgFaACw
         hRcAVdyXR4tv7cGko8Pf37h0t+kKQv0Qv/8HDbR5ld6ZvQQrVVRWMW6WqzK1JkkwB3tR
         KwtqC8vUDaIPfg2bzYNW8UNcxITH/vixvJK6A=
Received: by 10.223.88.22 with SMTP id y22mr2566364fal.144.1313963551706; Sun,
 21 Aug 2011 14:52:31 -0700 (PDT)
Received: by 10.223.89.133 with HTTP; Sun, 21 Aug 2011 14:52:31 -0700 (PDT)
In-Reply-To: <6EE456FC-9671-4CAF-9067-743AE2526717@maieul.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179819>

On Sunday, August 21, 2011, Ma=EFeul Rouquette <maieul@maieul.net> wrot=
e:
>
> Le 21 ao=FBt 2011 =E0 23:32, Michael Witten a =E9crit :
>
>> On Sun, Aug 21, 2011 at 20:33, Ma=EFeul <maieul@maieul.net> wrote:
>>> Hello,
>>>
>>> my problem is :
>>> - I have 2 branches : "master" and "sty"
>>> - In the branch sty, I have commit that i don't want to merge on th=
e branch
>>> master. The only file that I want merge are the *dtx files.
>>>
>>> My question is : how can i do to merge *dtx files from "sty" to "ma=
ster",
>>> and have log of commit on the *dtx ? Is it possible ?
>>
>> There are a number of ways to do this, some more general than others=
=2E
>>
>> Do you know all of the names of the files for which you don't want
>> associated commits? Do the files that you don't want get changed in
>> some of the commits that you do want?
> I found the solution "git merge hashofcommit". My commits one the fil=
e are only on the file, so the solution is very simple !
> Thank for helping :)-

Good if the commits you don't want come *after* the commits you do
want. =A0Use "git cherry-pick <hash>" if you want one commit and *not*
all the commits leading up to it.
