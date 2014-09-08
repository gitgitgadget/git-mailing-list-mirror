From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 1/2] strbuf: export strbuf_addchars()
Date: Mon, 08 Sep 2014 23:36:11 +0200
Message-ID: <540E214B.3060400@web.de>
References: <540C0344.9060002@web.de> <xmqqvboym09h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 23:36:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR6c3-0007TR-Pj
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 23:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730AbaIHVgf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Sep 2014 17:36:35 -0400
Received: from mout.web.de ([212.227.17.12]:60829 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754254AbaIHVgf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 17:36:35 -0400
Received: from [192.168.178.27] ([79.253.187.29]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LxOHm-1YSYGI0Dus-016zyL; Mon, 08 Sep 2014 23:36:32
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <xmqqvboym09h.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:ye0jlMh18kLC/9GKJQswt/J7n9/q/dbbz+fp+j5Cgq30wTNehcp
 pc9HN+2ZAOrWn3JIItpyrH0G4raPPBHHNbnyLHsJ80haJM49VK4GgPe16H4Ouzi0uXIFNaH
 RiJEG6F4WrQMVM2WKZjCx0L7J0FMwJT+aJKWvHjZTjdV5nt9fGcQ1aRC0Ug3GdsqaOUpDmb
 BkPgra6AnEABSRfD4chSg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256678>

Am 08.09.2014 um 20:32 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Move strbuf_addchars() to strbuf.c, where it belongs, and make it
>> available for other callers.
>>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>
> Wow, fixing up v1.7.0.2~9^2~2?

About time, isn't it? ;)

> Both patches look correct, but I have to wonder where you are
> drawing these clean-up opportunities from?  Almost as if reading
> through dormant part of the codebase one of your hobbies or
> something ;-)

That, and I'm sitting on a pile of cleanup patches that grew whenever I=
=20
looked at some piece of code for the first time, e.g. due to bug=20
reports, or when I took a static analyzer for a test drive etc.  I'm=20
trying to filter out the good ones and to send them at opportune moment=
s=20
in order to avoid conflicts with real changes.

Ren=C3=A9
