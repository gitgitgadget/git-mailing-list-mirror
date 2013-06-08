From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sat, 8 Jun 2013 09:23:01 +0700
Message-ID: <CACsJy8BngfgTfXDXvzjmu0t__86LAivP+_VhGUSXmG5hTnM9SA@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org>
 <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
 <alpine.DEB.2.02.1306060904100.13204@nftneq.ynat.uz> <CALkWK0mwxfGJdZi6kSaAPr66o550RiT_p8_r_4mDvcd_VAFYQw@mail.gmail.com>
 <alpine.DEB.2.02.1306061308100.29361@nftneq.ynat.uz> <CALkWK0k8m16oy7u+a8bHK93pRxfomOZDne3k0voVHLGULO+uiw@mail.gmail.com>
 <7vd2ryueuu.fsf@alter.siamese.dyndns.org> <CAMP44s2f2RBGd0VwJaSB1FkHBXRGhrTs_sA80kcinmpzJX8UDg@mail.gmail.com>
 <7vsj0tsnjw.fsf@alter.siamese.dyndns.org> <CAMP44s2FaoL5T+eG9mKua1U5PN9SURtXOE_YE8WO8cUusf=mBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Lang <david@lang.hm>, Greg Troxel <gdt@ir.bbn.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 04:23:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul8ob-0008T1-Qq
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 04:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041Ab3FHCXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 22:23:34 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34983 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927Ab3FHCXd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 22:23:33 -0400
Received: by mail-lb0-f179.google.com with SMTP id w20so4835811lbh.38
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 19:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=euvtSy5rpe8dTw2VnjK3XsUCXkKoyoda+kh7fW4cT6c=;
        b=vA490/Uu4jwbCWTS9sBEnJbhA3Q05jGzSQ7TZij3Pnm8N7A3vK8YeyXIrtPuRpCDeG
         El68BhvU1OoNE4GIO9BdmIFdkMdBB2cSOOTgjEYCFvxZonxL6XRnI7ib3UP17K0c9HXF
         cQk/Onjofz3ztiVzFzecAIsb508fmS7rz+FqtyV/U0Um0xQvigd+6jMf3L/bGcHAkQUx
         akJ9vf8uLXE/gMaV+US4kyqTeE6DAupwTOLev0l0vRXm5OBudY5djuSFJAdy7+vWJvX5
         PuF1LTGW3zPLBtLKR4R7izGY/2BXYjphf7OWDmbSUw7zCAnVUqPvXn0tcPQ0t97h+r3h
         2cYA==
X-Received: by 10.152.121.73 with SMTP id li9mr598304lab.42.1370658211905;
 Fri, 07 Jun 2013 19:23:31 -0700 (PDT)
Received: by 10.114.24.234 with HTTP; Fri, 7 Jun 2013 19:23:01 -0700 (PDT)
In-Reply-To: <CAMP44s2FaoL5T+eG9mKua1U5PN9SURtXOE_YE8WO8cUusf=mBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226779>

On Sat, Jun 8, 2013 at 3:24 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>> The reviewer pool for code written in a new language _must_ be
>> seeded by some from the current set of reviewers whose judgement
>> I/we can trust.
>
> By that standard nothing will ever change. Ever.
>
> Even twenty years from now, you will still only trust people that are
> familiar with shell, Perl, and C. Because the only way to gain your
> trust, is by being proficient in shell, Perl, and C.

I don't see why a trusted person cannot learn a new language and
convince the community to give it a try (well given that enough
reviewers support the new language, which was Junio's point).
--
Duy
