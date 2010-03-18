From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git branch --current?
Date: Thu, 18 Mar 2010 09:00:45 +0700
Message-ID: <fcaeb9bf1003171900i261068d2m954cbc22499b1b07@mail.gmail.com>
References: <fcaeb9bf1003170743kc347d53jefe41039e3b9a69a@mail.gmail.com> 
	<76718491003170748h349c5ed0u7649864cc824f549@mail.gmail.com> 
	<fcaeb9bf1003170804s4c9fdbb6id2c045bdb90f8c6f@mail.gmail.com> 
	<76718491003170814v71e31e91q994daee849da4caf@mail.gmail.com> 
	<20100317190645.GA8304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 03:01:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ns52v-0001qz-7j
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 03:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062Ab0CRCBH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 22:01:07 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:38688 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954Ab0CRCBF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Mar 2010 22:01:05 -0400
Received: by yxe29 with SMTP id 29so255536yxe.4
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 19:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=17qjDdGzs5VguNphI050m1797NmeaPVpHbSoC2BBb5A=;
        b=b2setZzy4o0sN0uQTaCJg5Jvbm4pweOHsbjgV+whG0nKZ6cawpN1GolfJ1tgB8Eksm
         Cv71khtNmc1+PEpbl+AD/K3QV3l17e35cjTvexnhnNz8MQM+Sw9hH1GYum/miTcJvDCA
         CAQcA03utfC8HmmA8QslihPqZ9Iaj6pnOswy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ATauKXghtmMANdcF7BtwGR2zJ9N7QVsj8/geZ8OsefYfYRh1ORR7DYU0QeEDgybLfL
         wtGg2IdEbOvzV9GBp55h9vlhqko02sp6NXIBern7so9ir07hhcGweFSIjkjyhNI+7uLp
         O6YYwngXds2UdCHMPsDF1tAXGFFQ5HoP+D0UA=
Received: by 10.101.128.39 with SMTP id f39mr2670674ann.52.1268877665136; Wed, 
	17 Mar 2010 19:01:05 -0700 (PDT)
In-Reply-To: <20100317190645.GA8304@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142446>

On Thu, Mar 18, 2010 at 2:06 AM, David Aguilar <davvid@gmail.com> wrote=
:
> You caught my attention. =C2=A0I don't personally like csh. =C2=A0In =
fact,
> I'm actively working on a way to get us off of csh here at
> $dayjob. =C2=A0Hence, I usually shy away from anything that
> encourages csh usage.
>
> That said, I'm a practical person. =C2=A0We've written a
> git-completion.tcsh here so I figured I'd share.
>
> Caveats -- it sucks! =C2=A0I'm pretty sure that this is due
> to either a) csh's poor completion facilities, or b) my
> inability to use it to its best ability. =C2=A0The thing that really
> kills me is that I can't figure out how to get both path
> completion and --option completion at the same time.
> For a while I had 'echo *' in there to handle that but
> that breaks down once you start completing down a subdirectory
> (the "/" breaks it). =C2=A0Hence, we always use the '--' separator
> when specifying pathspecs.

But it works, from a user point of view.

> What I learned from this exercise?
> Bash completion is effin amazing! =C2=A0(typed from a bash terminal)
>
> I'm sure there's plenty of ways to improve this. =C2=A0Aside from
> throwing it in contrib/ and hoping others find it useful enough
> to improve it, I've probably hit my tcsh completion-foo limit.

I'll put it in my ~/.tcsh and see how it goes. Thanks.
--=20
Duy
