From: demerphq <demerphq@gmail.com>
Subject: Re: push race
Date: Mon, 15 Oct 2012 16:13:50 +0200
Message-ID: <CANgJU+Vq7vnJh1NsZDh0mnTyHQba+oq3=MiwsWL5E5Wb0RiiAg@mail.gmail.com>
References: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com>
	<CACBZZX5keWVDZ-rvQfHFChKRC1YwXcUvfiqzgeMjVTydnQCdmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 16:14:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNlQh-0003cB-9Q
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 16:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761Ab2JOONw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 10:13:52 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:54078 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753614Ab2JOONv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2012 10:13:51 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so3688431iag.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 07:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ZjQCUhrpUfFT+1LuBUZE2246yERQLZxQ7GYeJu2l48M=;
        b=rfbnMt94XgBKKjJ9trjIH/nQXqqFS/l9nWBMKXeS2Sv0T3lvadU0E0L+VXwxDYT8V3
         Ujt+3gsfXtOPfmhltFrNo/J5z5PLOWpXtxAIJXMMysdDDZhCnMlYrl4h38SVY705Zfqs
         go62mzzasbF2OL3qs2/BqG+RBr+JorQJEcR9vlUftlvd+7mPY3tN86kCUEKmBIkWuqEL
         ReLQg++TKxAakrybPGvup6Y0rw8Jh/YnTW5gGrG9JVMBWwgPqsX/52voqwdRPJCc6Ypz
         NhMwPGiuUZ4SZe5SFOva1ISrwl6sIwzeX93I3FcXivGHrOsCAUIDUT/fJxGBlY7RFohq
         x/vA==
Received: by 10.50.219.233 with SMTP id pr9mr8851232igc.68.1350310430754; Mon,
 15 Oct 2012 07:13:50 -0700 (PDT)
Received: by 10.64.86.36 with HTTP; Mon, 15 Oct 2012 07:13:50 -0700 (PDT)
In-Reply-To: <CACBZZX5keWVDZ-rvQfHFChKRC1YwXcUvfiqzgeMjVTydnQCdmg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207748>

On 15 October 2012 16:09, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.c=
om> wrote:
> On Mon, Oct 15, 2012 at 11:14 AM, Angelo Borsotti
> <angelo.borsotti@gmail.com> wrote:
>> Hello,
>
> FWIW we have a lot of lemmings pushing to the same ref all the time a=
t
> $work, and while I've seen cases where:
>
>  1. Two clients try to push
>  2. They both get the initial lock
>  3. One of them fails to get the secondary lock (I think updating the=
 ref)
>
> I've never seen cases where they clobber each other in #3 (and I woul=
d
> have known from "dude, where's my commit that I just pushed" reports)=
=2E

Except that the error message is really cryptic. It definitely doesnt
shout out "maybe you collided with someone elses push".

Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
