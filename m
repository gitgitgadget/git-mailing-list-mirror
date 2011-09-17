From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: zealous git convert determined to set up git server
Date: Sat, 17 Sep 2011 08:15:49 +0530
Message-ID: <CAMK1S_jgNxQLUv89pSpBjV964MRG=9AboUoxLcndq=6MvMNcWw@mail.gmail.com>
References: <CAOZxsTqtW=DD7zFwQLjknJR8g0nnh0WPUPna6_np4bVoGnSntQ@mail.gmail.com>
	<201109170039.22954.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Stoutenburg <jehoshua02@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 17 04:46:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4kv4-0008Q2-S7
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 04:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326Ab1IQCpw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Sep 2011 22:45:52 -0400
Received: from mail-vw0-f42.google.com ([209.85.212.42]:46981 "EHLO
	mail-vw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab1IQCpv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2011 22:45:51 -0400
Received: by vwl1 with SMTP id 1so8004126vwl.1
        for <git@vger.kernel.org>; Fri, 16 Sep 2011 19:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=LBlS6/UUSeFILbzD34CMKuhbgqxemxs2TzthohrVAyI=;
        b=Va/W/8phJgbICqt3HC+Q0U9ZVLlbNQwnxRCA+xhB506X/Sft+9+DghlpLdcD0GiODA
         19uiZW5dHBohylpf7+LU7Jzsp1e010lECf14JcNS1U6D4V04Izqvu8OPAYGuha0nZcRy
         EVcmPEmunUfhm4ZE+MWy6WW0RxBrLFxJhaNIU=
Received: by 10.52.115.98 with SMTP id jn2mr70233vdb.473.1316227549525; Fri,
 16 Sep 2011 19:45:49 -0700 (PDT)
Received: by 10.52.161.197 with HTTP; Fri, 16 Sep 2011 19:45:49 -0700 (PDT)
In-Reply-To: <201109170039.22954.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181571>

On Sat, Sep 17, 2011 at 4:09 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> Joshua Stoutenburg wrote:
>> 2011/9/15 Jakub Narebski <jnareb@gmail.com>:

>> Question 2: It seems gitolite is the popular choice for git user
>> management. =C2=A0Any reason why?
>
> From Gitosis and Gitolite, both git repository management tools, Gito=
sis
> requires setuptools beside Python, and looks like it is not developed
> anymore, while Gitolite (which started as rewrite of Gitosis in Perl)
> requires only Perl and is actively developed.
>
> Nb. even Gitosis author recommends Gitolite:
> http://scie.nti.st/2007/11/14/hosting-git-repositories-the-easy-and-s=
ecure-way
>
> =C2=A0Update (12-12-2010): For additional features not present in git=
osis,
> =C2=A0check out gitolite.

Minor correction.  That blog is someone else's (a friend of the
gitosis author).  I asked him to add that text because we constantly
had (still have) people land up on #git asking for help but neither he
nor the author are active in git-land anymore and won't answer
questions and no one else was willing to pick up the slack.

=46ortunately he agreed, and was gracious enough to put that in,
although I would have preferred wording that includes the word
"unsupported" (IMO lack of support is a bigger reason than lack of
features).
