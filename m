From: Leila <muhtasib@gmail.com>
Subject: Re: [PATCH] git-status: Show empty directories
Date: Sun, 10 Jun 2012 14:17:02 -0400
Message-ID: <CAA3EhHJzyR1pWaEeDp_+xv8LaaxmJfVXi17pNtwW3dAD+9sbFw@mail.gmail.com>
References: <1339270806-65013-1-git-send-email-muhtasib@gmail.com>
 <7vr4tnab9e.fsf@alter.siamese.dyndns.org> <CAA3EhHLWDtUeNB+RZA064Omwxh7SEYhSc53U0nuiSTNzioKnug@mail.gmail.com>
 <20120610201256.Horde.dB69JnwdC4BP1OOoePf1xjA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Sun Jun 10 20:17:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdmhx-0000iP-R8
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 20:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665Ab2FJSRZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jun 2012 14:17:25 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:55948 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481Ab2FJSRY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jun 2012 14:17:24 -0400
Received: by vbbff1 with SMTP id ff1so1879275vbb.19
        for <git@vger.kernel.org>; Sun, 10 Jun 2012 11:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=OnEhK4Z++o4o83rqh9HAqBEXoZvoM8giApkm/pa/t60=;
        b=Nf4ng7zjz4tsJ+2AKuePQU6SuDVPRdsoNvs3Ead0eeAYOO7jH1F9kDwkm9QUD3CdWs
         bmPeZZnMXtyQ9BIOpvUZgH32r1Jro6oe6E3E76z7Dy0kntivY8HeUkDHd3G3dNHtynFa
         rE/lmn7SjcNukai0KV5gWW8BfUG/4vm7SP/KGmTQ1zScbadHgBjEycYhr8t80LIEWhhq
         jLihZtWAyVZhPuFrmcYECSXx6a5A9QsfUeKryFPTYVgw4jbzK7/sfPnZp3zfpYlOCIXz
         zmj8AtkevD3LeR14dA8vvdU471s0Cjg3YfZQjHc00xJDS3Ft9j0XYMOBy+UoV0/oQFnC
         HT+w==
Received: by 10.52.69.110 with SMTP id d14mr9359452vdu.124.1339352243717; Sun,
 10 Jun 2012 11:17:23 -0700 (PDT)
Received: by 10.52.37.233 with HTTP; Sun, 10 Jun 2012 11:17:02 -0700 (PDT)
In-Reply-To: <20120610201256.Horde.dB69JnwdC4BP1OOoePf1xjA@webmail.minatec.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199616>

On Sun, Jun 10, 2012 at 2:12 PM,  <konglu@minatec.inpg.fr> wrote:
>
> Leila <muhtasib@gmail.com> a =E9crit=A0:
>
>
>> The question 'why are empty dirs special', is issue no 1, which I'm
>> also happy to discuss. The rule empty dirs can't be added in git is
>> unintuitive, as people use git to keep track of things - all things.
>> So it's not about an empty dir being special, it's about how people
>> use git to keep track of things. Now why might people want empty dir=
s
>> tracked? 1) People often setup dir structure in projects before addi=
ng
>> any code. They often want to save that state for themselves or to
>> share it with other team members.
>
>
> Yup, that kind of situation is not unusual. Thus, having a reminder b=
y
> running 'git status' would help. But sharing empty dir with other tea=
m
> members is another issue, no ? Even with your implementation, the use=
r
> won't be able to share empty directories.
>

Yes, there are two issues. I'm advocating for the reminder when
running 'git status'.

Sharing empty dirs with other team members is another issue. My
implementation does not handle this case.

Thanks,
Leila
