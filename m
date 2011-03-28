From: Vicent Marti <vicent@github.com>
Subject: Re: GSoC questions
Date: Mon, 28 Mar 2011 23:52:13 +0300
Message-ID: <AANLkTink4wVb6O+yVm=HUh_s1GhKhyL4baqYGe=XFu04@mail.gmail.com>
References: <AANLkTinTM8hQpcahGgDyB4UJvGbdN0xyp65wL5PDQGKa@mail.gmail.com>
 <20110328001152.GA11294@elie> <AANLkTikGb1=Rtz-T9p=u+X32KpL2AXq0AELdSJ2NMHrW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	libgit2@librelist.org, Jeff King <peff@peff.net>
To: Alexandru Sutii <sutii.alex@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 22:52:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4JQW-000714-Sv
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 22:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600Ab1C1Uwg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2011 16:52:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38332 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab1C1Uwe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2011 16:52:34 -0400
Received: by wya21 with SMTP id 21so3209164wya.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 13:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=pM2M43vMnu+9NqnCJICsdkZNmWiilQfHelzr/zbuDlM=;
        b=OCP4E85MVQ4JxFFzS8wDFJqUxJYuPYSMyX49nrvgMiOSVwy7oVGuMqHvj1q0pHL26f
         YsAPWQKPxSQfYU2Y/IFRBUaMtPiwB/KPq7rLU7HlMXPSOmDhGAQaKTK1NWpQYOfhjrfg
         BvKGv2odBw39R2/RTbzNbH0+kMl3+nrFhidSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=eYxVXvKZCy9W//tqjkzuFYVHpu2m6tIAPaX21jXuTnavsLIAeBPvbJ10NtlaN680/F
         reiwxUrLTAhOYNw/v3ZZFc2jtgOiy1todA/of07O+oWUsWgLk7Ba+7T7dxOdlRkiuQY4
         Q+oS1jNeEEo0xFenFPF4Yto52SnZ1MCW7HBSk=
Received: by 10.216.46.135 with SMTP id r7mr3239294web.21.1301345553069; Mon,
 28 Mar 2011 13:52:33 -0700 (PDT)
Received: by 10.216.243.7 with HTTP; Mon, 28 Mar 2011 13:52:13 -0700 (PDT)
In-Reply-To: <AANLkTikGb1=Rtz-T9p=u+X32KpL2AXq0AELdSJ2NMHrW@mail.gmail.com>
X-Google-Sender-Auth: NlU39K-oLt8pwWbczIjNCbjfNnA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170190>

Hey Alex,

I'm glad to see you're interested on the minimal git client task.

Here are some places to get you started on writing your proposal:

http://libgit2.github.com/libgit2/index.html (the full API
documentation -- priceless)
http://libgit2.github.com/api.html (the usage guide, with examples)
https://github.com/libgit2 (the list of language bindings, so you can
see real-life usage samples)

Also, I have to agree with Jeff once again: Start researching and
impress us with an awesome application that shows how are you planning
to solve the problem you are facing -- in this case writing a minimal
git client.

Remember that the sooner your application gets on Melange, the more
feedback it will receive!

Cheers,
Vicent


On Mon, Mar 28, 2011 at 11:26 PM, Alexandru Sutii <sutii.alex@gmail.com=
> wrote:
>> Is there some particular part of git functionality you would like to
>> focus on (history creation, history mining, object store maintenance=
,
>> configuration, transport)? =A0The list of low-level commands (plumbi=
ng)
>> in the git manual might be a good place to get an idea of the scope.
>>
>> The ideas page mentions areas in which libgit2 functionality is
>> incomplete --- depending on your interest, you might want to focus o=
n
>> one of these (so the project would be to add functionality to libgit=
2
>> as well as using it) or to steer clear of them (to focus on
>> functionality libgit2 already has).
>
> Hello again! Thanks for your and Jeff's reply.
>
> I have decided on "minimal Git client based on libgit2" project. I ha=
ve looked
> over the git manual page and I would like to work on manipulation com=
mands
> functionality. I am also open for adding functionality to libgit2 as
> well as using it.
>
> I have read the references from your mail and I am currently trying t=
o
> understand project's architecture, as I am totally new to git's sourc=
e code.
> Hope I will manage to identify the source code parts that interest me=
 in
> a short time and maybe realize to implement something.
>
> In the meantime I would greatly appreciate some guidelines where to l=
ook.
>
> --Alex.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
