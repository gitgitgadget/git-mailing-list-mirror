From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Finding a branch point in git
Date: Thu, 31 May 2012 11:37:48 -0400
Message-ID: <CACPiFCLUae+gyymAXr9Bdux6Mohnp4tXuS5pgNCJ9w-gjBbrwA@mail.gmail.com>
References: <CAMP44s0f7AJPQSTDgvy0U7vx8nxzq2a3vMhSr2Tcc61fetFkJA@mail.gmail.com>
 <20120528062026.GB11174@sigill.intra.peff.net> <CAMP44s04msWMOaaH8U30XXg5yXJnEd=bULJ7VPxWSD0Wfh2=EA@mail.gmail.com>
 <20120528190639.GA2478@sigill.intra.peff.net> <CAMP44s0UBsVicuEcwACsm1zTT_jGau_Q20hJv4J_6uvancYJRQ@mail.gmail.com>
 <20120530215415.GB3237@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 31 17:38:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa7S3-0005KC-GJ
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 17:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607Ab2EaPiL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 11:38:11 -0400
Received: from mail-gh0-f180.google.com ([209.85.160.180]:54664 "EHLO
	mail-gh0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932487Ab2EaPiJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 11:38:09 -0400
Received: by ghbz12 with SMTP id z12so1071572ghb.11
        for <git@vger.kernel.org>; Thu, 31 May 2012 08:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=0vrHGnVLIm+6HioXzNzJpvaIuFNBnnQVnJZhfcEf1Jg=;
        b=CVUGzfmsnv/rFH7/MWBR1TbvLB9Ealyrfb2YMD8r7mlSecyIktwq+G6QQTzVM0drr8
         BfESWpVixQ3Ojo3uJ3SY66Zf1oEjniowZXMMvk6C2/o+NCxuVzo4BFkBTuyfO9Rb1/pU
         bYVdJVo3CNHMY8QMYVvQ5jOGCZcsvB54/SMi+6feFvUSzIUuXJxLBSobCd4Q52sIvCbB
         tQVyEuf0TQ08jDZ+QXxIRmg+qPk8uKfyIZw5CL5THFetGSrC98wG0ox1TK1DfWSly/Of
         taFH2ndfE1//YAzadyoWGu6/PVB1b5l6yAeIdKS2Jvw2fWRmQM1FL7LQLemAGvjwKvzg
         N4pg==
Received: by 10.50.173.102 with SMTP id bj6mr2229737igc.25.1338478688740; Thu,
 31 May 2012 08:38:08 -0700 (PDT)
Received: by 10.42.93.81 with HTTP; Thu, 31 May 2012 08:37:48 -0700 (PDT)
In-Reply-To: <20120530215415.GB3237@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198923>

On Wed, May 30, 2012 at 5:54 PM, Jeff King <peff@peff.net> wrote:
> > =A0% git log branch ^<any-other-branch>
> >
> > I could swear I saw such an option, but I've been looking for days =
and
> > I can't find it.
>
> I don't think there is such an option. You have to do something like:

I do

   gitk olpc-kernel-branch ^origin/master

to peruse OLPC's branch of the linux kernel without reading a
bazillion commits into memory.

Anyway, this whole discussion assumes a very simplistic branching and
development scenario. Some forks and merges are due to developers
working offline or in per-developer repos. No automatic way to know
what's an intentional branch.

cheers,



m
--
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
