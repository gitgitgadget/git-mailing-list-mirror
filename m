From: Javier Domingo Cansino <javierdo1@gmail.com>
Subject: Re: Can we stage all files using "git add" command, except some
 specific files ?
Date: Tue, 27 May 2014 00:06:34 +0200
Message-ID: <CALZVapnUgEnw6rv630awF7AjnfhRzzK8H5wP6jTLN6XZGVJDEQ@mail.gmail.com>
References: <8392138.j8Dle5WGbS@linux-wzza.site> <1401135802.25483.1.camel@spirit>
 <11486854.4deTbW34tQ@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Arup Rakshit <aruprakshit@rocketmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 00:07:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp32q-0006ei-4a
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 00:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbaEZWG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 18:06:56 -0400
Received: from mail-vc0-f181.google.com ([209.85.220.181]:44406 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbaEZWGz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 18:06:55 -0400
Received: by mail-vc0-f181.google.com with SMTP id hy4so6275038vcb.26
        for <git@vger.kernel.org>; Mon, 26 May 2014 15:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Onx8aDfvWxCQsQU7l02unHa2fwwEMF8YkMIQz0xz+Lw=;
        b=OMyeUF1kecjdDQ4SZBMeS2XtH8hX6jO5wc7p4p8vDZ9/zN3lj0uF4gcZ9dD6iZg8Pp
         iaV++CCFFspj9vqOigkLSajfp1Y+OS7iYjtUncV+3w7ZweTptBHyeZLS3AUJlpn6ZtyV
         xiJEMPox9NgL8+7IMe8M6d+BJQtLvjW33aiPvFLTqGUutgXon89HW9ZS+nYpsSus3Gg0
         VDM7coDezMvGqRwo+CKDO/VrRoGCInZ1iiH7Ebn4iDbuyvyer96Gn+SR/Maj/YOweXnJ
         hBvHFq0zO2RbcvDQCpJXp6WkteE4+iPoGrvyTdYywSW2OwqSM4p03YsXtdK7kWR8Nzjc
         VJkw==
X-Received: by 10.52.246.42 with SMTP id xt10mr569159vdc.5.1401142015041; Mon,
 26 May 2014 15:06:55 -0700 (PDT)
Received: by 10.220.251.199 with HTTP; Mon, 26 May 2014 15:06:34 -0700 (PDT)
In-Reply-To: <11486854.4deTbW34tQ@linux-wzza.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250124>

If you don't want an specific file, but you neither the .gitignore,
just use .git/info/exclude file for project specific or
$HOME/.config/git/ignore for user level.

Anyway, this is all in man gitignore

[1] Git ignore man page: http://git-scm.com/docs/gitignore
Javier Domingo Cansino


2014-05-26 21:27 GMT+02:00 Arup Rakshit <aruprakshit@rocketmail.com>:
> On Monday, May 26, 2014 10:23:22 PM you wrote:
>> On di, 2014-05-27 at 00:33 +0630, Arup Rakshit wrote:
>> > Now, you can see, I have staged all the files first using *git add
>> > -A*, then _unstaging_ those I don't want to _stage_ right now. Now can
>> > this be done, in the *staging* time ? I mean any way to tell `git add`
>> > command, that add all the files from the current directory, except
>> > some specific files.
>>
>> No, there is no such option to do that, but you could use git add
>> --interactive and use its interface to quickly pick the files you want
>> to add.
>
> Hi,
>
> I tried it also.. But just didn't get it, how to use,, lots of options 1,2,3
> etc .. :)
>
> --
> ===============
> Regards,
> Arup Rakshit
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
