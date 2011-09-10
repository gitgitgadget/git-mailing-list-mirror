From: Lynn Lin <lynn.xin.lin@gmail.com>
Subject: Re: merge result
Date: Sat, 10 Sep 2011 09:07:35 +0800
Message-ID: <CAPgpnMTF4NEjPPXiBjRBG4yhDAdFpM0UM9kjBp7A06n=knfmmA@mail.gmail.com>
References: <CAPgpnMRrSmVrXD__jxv3uNrek8up+scHp+_Kj8+=HX8tfweWzQ@mail.gmail.com>
	<CAH5451=BpiN9P8gjL5TYQO+NSH913oXo1-bmscMXyy8QhFg8KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 10 03:08:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2C3p-00034u-6y
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 03:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756633Ab1IJBHg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Sep 2011 21:07:36 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:63759 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754864Ab1IJBHg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 21:07:36 -0400
Received: by vxi9 with SMTP id 9so1557069vxi.19
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 18:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=aNVv3cvsnmqHFcC6bRs5xWCITjFmr+SUAhXv/NAjCD0=;
        b=L0LT08sVGSPSooAk1rkWrFH5LOAEWvJUGH05zSP3V26amVUK/dACNGzYNzmgkMDhkG
         OAypTIa8yq6nTnCgGAEP0f8yDMUx4RpNJ7YfBVRAVbLVdjaW/vExRsNp3oB9SLjNCI5m
         RyAHH7Q+liepEz9/bvOyQmj5UoGphyQvbbvMw=
Received: by 10.52.20.37 with SMTP id k5mr1421170vde.282.1315616855685; Fri,
 09 Sep 2011 18:07:35 -0700 (PDT)
Received: by 10.52.166.6 with HTTP; Fri, 9 Sep 2011 18:07:35 -0700 (PDT)
In-Reply-To: <CAH5451=BpiN9P8gjL5TYQO+NSH913oXo1-bmscMXyy8QhFg8KQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181132>

On Fri, Sep 9, 2011 at 8:41 PM, Andrew Ardill <andrew.ardill@gmail.com>=
 wrote:
> Hi Lynn,
>
> If you merge two branches together you are merging the state of the
> head of those trees, not re-applying commits on top of each other. Th=
e
> changes introduced in commit 4 will therefore not be applied twice,
> but will more-or-less be ignored.
>
> Perhaps you are not trying a merge operation, but something else? Is
> this issue hypothetical, or is it something you have experienced??


1$ git checkout master
2$ git edit  and commit
3$ git checkout branchA
4$ git edit and commit
5$ git checkout master
6 $ git merge branchA

2 and 4 change is the same

> Regards,
>
> Andrew Ardill
>
>
>
> On 9 September 2011 20:54, Lynn Lin <lynn.xin.lin@gmail.com> wrote:
>> Hi All,
>> =A0 When I merge branch A back to master branch,if there are same
>> commit(developer do double commit) both in master and A branch, ther=
e
>> will be two same commit in master branch.For example
>>
>>
>> =A0 1->2->3-4>5 =A0 =A0 =A0 =A0Master
>> =A0 =A0 =A0 |
>> =A0 =A0 =A0 4->6->7 =A0 =A0 =A0 =A0 =A0A
>>
>> When I merge A branch into master,the two same 4 commit will present
>> in master branch.
>>
>> Is there any wrong with my operation?
>>
>> Thanks for your help
>> Lynn
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
