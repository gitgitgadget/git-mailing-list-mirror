From: robert mena <robert.mena@gmail.com>
Subject: Re: Pointers to setup an internal git repository with access control
Date: Tue, 30 Aug 2011 08:35:22 -0400
Message-ID: <CAAZ43xYhFQzBVmjfnvRoboNPQ1OLtyq57=0ZL3B6p+dRWnJZ-g@mail.gmail.com>
References: <CAAZ43xZPsw2CnqOtb6wO7dRC1eMd0eweQ30w-wfzUHL5cqw=Yw@mail.gmail.com>
	<20110830162223.1cbf9f98.kostix@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Aug 30 14:35:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyNXM-0004XK-9G
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 14:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489Ab1H3MfY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Aug 2011 08:35:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42017 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800Ab1H3MfX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Aug 2011 08:35:23 -0400
Received: by fxh19 with SMTP id 19so5310119fxh.19
        for <git@vger.kernel.org>; Tue, 30 Aug 2011 05:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=/jfymbWn7F53rDEgbvj5UbEi8cwpCE163/efJQ42lFQ=;
        b=sIPI/KQFe79oM2y4Kuq7a12UMARQFBKxc9+j6z6RS05XqSWc2rwETeIUiJV38Kz2tq
         ObnvRqTmXojDcxg4jFoPjVmsZGEPLfU3yLF5jQzjj1abAsYlKPdcQtF/Ak/z/W4Ug+vJ
         J7fWqmtC/JCeNglUY2lyOozriMO1YoxbrtAD0=
Received: by 10.223.58.13 with SMTP id e13mr5402694fah.41.1314707722110; Tue,
 30 Aug 2011 05:35:22 -0700 (PDT)
Received: by 10.223.119.140 with HTTP; Tue, 30 Aug 2011 05:35:22 -0700 (PDT)
In-Reply-To: <20110830162223.1cbf9f98.kostix@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180406>

Hi,

Thanks for the reply.  I'll take a look.

I don't have to use https+dav, it can be ssh as long as it is
encrypted and I have some sort of access control.  The branches item
is to be able to control who can merge/commit things back to, for
example, the trunk or whatever I call the "live" branch.

This way the devs can do what they want but the final merge to the
"live" branch would be done after the Q&A approves.

On Tue, Aug 30, 2011 at 8:22 AM, Konstantin Khomoutov
<flatworm@users.sourceforge.net> wrote:
> On Tue, 30 Aug 2011 08:01:44 -0400
> robert mena <robert.mena@gmail.com> wrote:
>
>> I am trying to migrate from SVN to git and so I am looking for tools
>> that help me create an interal repository. =A0I currently use SVN ov=
er
>> HTTPS/Dav using the access.conf to be able to control which uses can
>> read/write to the repos or given branches.
>>
>> Ideally I am looking for tools that enable me to do the same with gi=
t.
> Possibly look at smart http protocol [1], [2].
>
> I may be wrong, but this access method cannot be used to implemet
> access control with branch-level granularity. =A0If you really need t=
his,
> use gitolite [3].
>
> 1. http://progit.org/2010/03/04/smart-http.html
> 2. http://www.kernel.org/pub/software/scm/git/docs/git-http-backend.h=
tml
> 3. https://github.com/sitaramc/gitolite
>
