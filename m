From: Sebastien Douche <sdouche@gmail.com>
Subject: Re: git push default behaviour?
Date: Sat, 17 Mar 2012 10:36:53 +0100
Message-ID: <CAAGHeXHWfEAym63jXFNvcBddp00joBzNuFEjhKZpqDQcn1d0kA@mail.gmail.com>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeremy Morton <jeremy@configit.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 10:37:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8q4z-0004GJ-KL
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 10:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756364Ab2CQJhg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Mar 2012 05:37:36 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42922 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677Ab2CQJhf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 05:37:35 -0400
Received: by bkcik5 with SMTP id ik5so3377202bkc.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 02:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=EzJ4fqME5cE5rAYEj5x/zQc/kJq88KCvaAGSAHA/KOY=;
        b=arqbUJGJz8xavq3V+Wy8y32R8QcT0d++gmSvMeCiOvJ8LifN96QxE1Zc5Qoz9f89bO
         /QL1zh8X74HijCwf/NyYasbLAzUoFGozvPaZr14ARnXgZIP8wCWgPshma8XLlZtuDsEw
         t7hq4+xdFdc3B7AxOMEukmeNKo4e4a/apZgUvcY+TIvdKvn5cJsH67Z1s/1ZMaTySyeL
         +TlK1/SDFZMcjTzwWIb9vvOsfMrzrrIF+gdGfsFk8CkMeev5BkCVF1K0u4jODSiqpAs9
         LAGmB1Hmt5eE5MN3Bm5xKN43P6dHwfYFsOv6fI8iHHRkIc/4fnt86irt0LrQevywSit+
         WUcw==
Received: by 10.205.137.15 with SMTP id im15mr2079670bkc.54.1331977053394;
 Sat, 17 Mar 2012 02:37:33 -0700 (PDT)
Received: by 10.204.224.204 with HTTP; Sat, 17 Mar 2012 02:36:53 -0700 (PDT)
In-Reply-To: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193312>

On Thu, Mar 8, 2012 at 11:01, Jeremy Morton <jeremy@configit.com> wrote=
:
> Hi everyone,

Hi Jeremy (sorry to be late, back from holiday)

> I've noticed that the default behaviour of 'git push' is to push to
> *all* branches that have a remote branch set up.=C2=A0 In order to pu=
sh
> just to one branch, you must specify 'git push repo branchname'.
>
> This seems rather unintuative to me

I made many Git presentation and managed a lot of training[1] and the
first thing I explain on the configuration is :

1. set your name and email
2. change the default push option[2]

Moreover, most people I see don't understand the default behaviour:
it's a frequently ask question by beginner.


[1] For git French : http://gitfr.net/blog
[2] I recommend tracking


--=20
Sebastien Douche <sdouche@gmail.com>
Twitter: @sdouche / G+: +sdouche
