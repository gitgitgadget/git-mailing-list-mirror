From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: merge result
Date: Fri, 9 Sep 2011 22:41:15 +1000
Message-ID: <CAH5451=BpiN9P8gjL5TYQO+NSH913oXo1-bmscMXyy8QhFg8KQ@mail.gmail.com>
References: <CAPgpnMRrSmVrXD__jxv3uNrek8up+scHp+_Kj8+=HX8tfweWzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Lynn Lin <lynn.xin.lin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 14:43:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R20QW-0000xD-Ia
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 14:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933755Ab1IIMnT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Sep 2011 08:43:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38427 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933296Ab1IIMnS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 08:43:18 -0400
Received: by fxd22 with SMTP id 22so579178fxd.19
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 05:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=/lt3yDWVtbzuBTuAuAHRvuNxpeWuXJrtYHbFWD472g0=;
        b=qWstUzmAZdKNBQjGgstd7D1Vcl4zTl9832k9PQVBJLmrOm+dbObF3ibS08x5cuvBeG
         tKHGqE3Ur/W1drLtB/CTi7eR1Tzex4bXxASz0gDr4ogO0RrhfxsOA9ZVTeeSwiAZrCJl
         yB3BC7z7E2wQiW3cbnyYV2g/7rSYm1cFZ3aSk=
Received: by 10.223.101.2 with SMTP id a2mr470968fao.2.1315572075473; Fri, 09
 Sep 2011 05:41:15 -0700 (PDT)
Received: by 10.152.8.226 with HTTP; Fri, 9 Sep 2011 05:41:15 -0700 (PDT)
In-Reply-To: <CAPgpnMRrSmVrXD__jxv3uNrek8up+scHp+_Kj8+=HX8tfweWzQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181058>

Hi Lynn,

If you merge two branches together you are merging the state of the
head of those trees, not re-applying commits on top of each other. The
changes introduced in commit 4 will therefore not be applied twice,
but will more-or-less be ignored.

Perhaps you are not trying a merge operation, but something else? Is
this issue hypothetical, or is it something you have experienced??

Regards,

Andrew Ardill



On 9 September 2011 20:54, Lynn Lin <lynn.xin.lin@gmail.com> wrote:
> Hi All,
> =C2=A0 When I merge branch A back to master branch,if there are same
> commit(developer do double commit) both in master and A branch, there
> will be two same commit in master branch.For example
>
>
> =C2=A0 1->2->3-4>5 =C2=A0 =C2=A0 =C2=A0 =C2=A0Master
> =C2=A0 =C2=A0 =C2=A0 |
> =C2=A0 =C2=A0 =C2=A0 4->6->7 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0A
>
> When I merge A branch into master,the two same 4 commit will present
> in master branch.
>
> Is there any wrong with my operation?
>
> Thanks for your help
> Lynn
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
