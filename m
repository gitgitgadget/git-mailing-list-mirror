From: Matthieu Stigler <matthieu.stigler@gmail.com>
Subject: [SOLVED] Newbie question: how to move bunch of files
Date: Tue, 09 Nov 2010 11:22:16 +0100
Message-ID: <4CD920D8.5040202@gmail.com>
References: <4CD86204.1000805@gmail.com> <AANLkTik9aQaV1OvARuPchekYpQFANu-+k3c2n3wamzXh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 09 11:22:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFlLS-0001Xg-1w
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 11:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974Ab0KIKWY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 05:22:24 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58398 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857Ab0KIKWX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 05:22:23 -0500
Received: by wyb36 with SMTP id 36so4640958wyb.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 02:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=JxmlUaXQDkY45Se6WBm+tjNqkNiUJyc4HDUZ6GGgGj4=;
        b=jnlsOYWGGlB9qj3tF5MBe1uc7bN8BYFO7cPHelyqGyO/6gFIVe3ezJiCDMD4vRA02U
         zpmUA0aWw1qILYuardscwia3/vxNzJlqUaKng8iPOaIXS422PQFaHw/DqYUtTCM9xez7
         HAOPs4HFkrhdF6yOkGHhDiqvIsLY12V9uDxqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=XgAZpfsxN67CHh3+D5zmKFi7+D6I8x/Obi7JxtRyhS9V8wuVjtbS7JuCvjqWQXwo9l
         /HtMQprIUnSwwvqc59ToPFXOjsnf7SfVHfdcn/KGSjmpaCjdAfMR++LoaUjRVpvtN3ZV
         UCDUo2jhg1tbxgClbIH7MLug0ak7hbVxuzbgY=
Received: by 10.216.157.6 with SMTP id n6mr6606072wek.35.1289298141091;
        Tue, 09 Nov 2010 02:22:21 -0800 (PST)
Received: from [168.202.52.175] ([168.202.52.175])
        by mx.google.com with ESMTPS id x3sm730149wes.22.2010.11.09.02.22.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 02:22:19 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.15) Gecko/20101027 Lightning/1.0b1 Thunderbird/3.0.10
In-Reply-To: <AANLkTik9aQaV1OvARuPchekYpQFANu-+k3c2n3wamzXh@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161029>

Dear Chris

Thanks a lot for your fast and relevant reply! This was indeed the case=
,=20
i.e. non-tracek files in the folder, whiohc hindered to move it=20
properly! I had not understood it from the error message, but then I=20
removed those and it worked!

Thanks!!

Matthieu

Le 08. 11. 10 23:14, Chris Packham a =C3=A9crit :
> Hi,
>
> On Tue, Nov 9, 2010 at 9:48 AM, mat<matthieu.stigler@gmail.com>  wrot=
e:
>   =20
>> Dear list
>>
>> I am very sorry to bother you with such a simple question, but I sea=
rched
>> for a while on the net and did not come up with any satisfying answe=
r :-(
>>
>> I just want to move a bunch of files (from /R to /pkg/R ), but get t=
he
>> error:
>> $ git mv R/*.R pkg/R/
>> fatal: not under version control, source=3DR/nll_MSAR3.R,
>> destination=3Dpkg/R/nll_MSAR3.R
>>     =20
> This is the kind of error you get from asking git to move a file it
> isn't tracking.
>
> Have you got generated files in the same location as your repository?
> I get the same kind of thing if I ask git to move generated files
>
>     git mv foo/*.pyc bar/
>     fatal: not under version control, source=3Dfoo/ast.pyc, destinati=
on=3Dbar/ast.pyc
>
> To get around this you could change your wildcard to only include
> files you are tracking or specify them individually. Alternatively yo=
u
> could just use 'mv R/*.R pkg/R/'  then 'git rm' the old files and 'gi=
t
> add' the new files you want to track, git should detect the renames
> after the 'git rm' and 'git add'. As a final alternative you could
> also 'git clean -d' to remove the untracked files but be careful with
> that as you may not have added some files you are meaning to track.
>
>   =20
>> What do I do wrong? Would you kindly indicate me what I should do?
>>
>> Thanks a lot and sorry again!
>>
>> Matthieu
>>
>> PS: I am using git 1.7.0.4 on Ubuntu 10.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>     =20
