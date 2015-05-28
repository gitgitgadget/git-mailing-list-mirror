From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH/RFC 1/2] git-rebase -i: Add key word "drop" to remove a commit
Date: Thu, 28 May 2015 10:12:19 -0700
Message-ID: <CAGZ79ka-Y2-2j=3WmoNmKG9=8JPtDZHGxPkkBkR6q-HYmHEYJw@mail.gmail.com>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<c78cd2ac17333a2e70d1113d95495c41@www.dscho.org>
	<1506177855.44397.1432738386768.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpq1ti23vva.fsf@anie.imag.fr>
	<xmqqsiahltbu.fsf@gitster.dls.corp.google.com>
	<vpq8uc9yfdp.fsf@anie.imag.fr>
	<xmqq382hlpwt.fsf@gitster.dls.corp.google.com>
	<CAGZ79kansAUWsjBsBznqaxRFeN3uF1u2hUZgO8b+OjOw8SKsUw@mail.gmail.com>
	<f5ed9832bba0381314d01fba13e20667@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 28 19:12:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy1M1-0006fi-Gp
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 19:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827AbbE1RMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 13:12:21 -0400
Received: from mail-qc0-f173.google.com ([209.85.216.173]:33793 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586AbbE1RMU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 13:12:20 -0400
Received: by qcbhb1 with SMTP id hb1so17117720qcb.1
        for <git@vger.kernel.org>; Thu, 28 May 2015 10:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sAeGfYZOcJ3cOoSJ7U592D6yFuEJ+KvrseooRbdf9nY=;
        b=TtVUY9wtyT6gXi4CxgXZj2AC0wkrtWQ9xIZ86NBD4ZZEEemDrD9YGjE36lM0fEiOC7
         kQ9U1Zqc0o9E2Dln3cubxDL8In/MXhXNmfboOYw83QWstBIrMHFSYqI2Qpfipl8/N06c
         nuWNp4qpgKfxwmTnGtyiEHkORLyO5dgBIS2SitLqPGYJqIs2SrJWnMt010VwtnHmRt8f
         tBtBaG1E+cPu8GqqlWHdFuaqufnJ1opM423zhD960Jqk0EyXf7sXyf14Vr2Mo3ka6Ktc
         Xx5Lroh9LpOt9xvPIwRpOwLSNUIJ2R3pqhC8zSoYeMXUKEgth/hfVkVfstUOU8pm1Fi6
         GXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=sAeGfYZOcJ3cOoSJ7U592D6yFuEJ+KvrseooRbdf9nY=;
        b=hMqdGrBmMeg5eGG3w2C5KnElaRhi0fwULCaYffVVR9qsbaLa1LeEjI/T/C0dGJBDSz
         krNFuIfgWnDwJ95bMjC/D5U4nSiFr/oeiHjYfHHw9ze6V6/8O6oKNCQ2tujY+hSMrZPD
         lMFa9ZjPDuybsqoLhO/31Y2CZBSPeOExheSWmASPIC2Xm2a/NzSEuyIAZwTLY3yv37D8
         vAAbPQUM3e3um2QOwqKLSRNEK1pZBOwCaN8AUOaD25qTBwqNEqf0M/rS4D2P70H0FLtZ
         3KEx6d7I4GRKkWgPUTpzg8dxe/5OUizWEkmDyWI2sbPbeQwMebjGrNAarW1W7AeLv/mh
         i8RQ==
X-Gm-Message-State: ALoCoQl3rwO95ctqjOZIq+BSLUCjQTUOitxS2zvoCHI8dympcRHCoO24LUV0+Q9Fy6zTRJ2jgaPe
X-Received: by 10.55.19.197 with SMTP id 66mr7568340qkt.24.1432833139303; Thu,
 28 May 2015 10:12:19 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Thu, 28 May 2015 10:12:19 -0700 (PDT)
In-Reply-To: <f5ed9832bba0381314d01fba13e20667@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270163>

On Thu, May 28, 2015 at 10:06 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Stefan,
>
> On 2015-05-27 23:47, Stefan Beller wrote:
>> On Wed, May 27, 2015 at 1:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Talking about ideas:
>> I sometimes have the wrong branch checked out when doing a small
>> fixup commit. So I want to drop that patch from the current branch
>> and apply it to another branch. Maybe an instruction like
>> cherry-pick-to-branch-(and-do-not-apply-here) would help me there.
>
> Oh, is it wish-anything time? *claps-his-hands*

Maybe my wording was bad, sorry about that.
I think throwing around ideas (which are closely related to what
is trying to be accomplished here IMHO) is not necessarily bad,
but the exchange of ideas helps in understanding the issue better
("I like your idea as I have not thought about it that way.", "What about
use case X", Your idea is nuts because Y")

>
> I would wish for a graphical tool which visualizes the commit graph in a
> visually pleasing manner, where I can select one or more commits and drop
> them onto a commit in the graph, and then it goes and magically cherry-picks-and-drops them.

Drag and Drop, I get it. ;)

Additionally, if dropped on an unnamed branch, it should come up with
a reasonable
new branch name.

>
> :-)
>
> Ciao,
> Dscho
>
