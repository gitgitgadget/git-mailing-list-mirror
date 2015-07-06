From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/12] Improve git-am test coverage
Date: Mon, 06 Jul 2015 13:42:42 -0700
Message-ID: <xmqq8uatyq4d.fsf@gitster.dls.corp.google.com>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
	<CAGZ79kaisrdsguxrwMCr5TK9RQaGF-WgVE7d9_=s7GXELqYxXA@mail.gmail.com>
	<341ac4ca31dabe768c106be1b11e8ea4@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Paul Tan <pyokagan@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 06 22:42:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCDE1-0003Po-FF
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 22:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbbGFUmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 16:42:45 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37458 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001AbbGFUmo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 16:42:44 -0400
Received: by igau2 with SMTP id u2so21107678iga.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 13:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=FuH26haXs/HWGCldtVYXxGMshlRBdxDUZnv+17dRjPc=;
        b=Fg66o5WQea2ZQocqfAAssGNDI7zGgiudWXFGg/GHeOVXX76G6gPkpiICOxUHbGzXVA
         O6QEd7SkkpowDqcqwPeYC91haHiUxnu9GLP+P10k88msA6/vp2qL3L9SB95aWEBgEFbl
         9Vkw73NUVoC52v+mEg3gdDwP6HcJRUbEyZqj/i1KCQpHcwsm/1UmV8rJNrnhfXFyrgMX
         QDR8sQtwWEgaB/n5Ji5Z7ei22mnMSnReWyblMEOfWBDHaFrmU/4Z4BPzF9jS7ptplMU3
         84bQ6RZ6Dk9kSup/xYo9IT10VuE68r9UBORInFtJ8CPCqzFjSEDZhWjVHHOW/rlTEk5i
         8nJQ==
X-Received: by 10.43.74.131 with SMTP id yw3mr34735253icb.97.1436215364222;
        Mon, 06 Jul 2015 13:42:44 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by mx.google.com with ESMTPSA id p4sm10387544igg.20.2015.07.06.13.42.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 13:42:43 -0700 (PDT)
In-Reply-To: <341ac4ca31dabe768c106be1b11e8ea4@www.dscho.org> (Johannes
	Schindelin's message of "Sun, 05 Jul 2015 18:02:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273458>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> On 2015-07-03 18:24, Stefan Beller wrote:
>> On Thu, Jul 2, 2015 at 11:16 AM, Paul Tan <pyokagan@gmail.com> wrote:
>>> Increase test coverage of git-am.sh to help prevent regressions
>>> that could arise
>>> from the rewrite of git-am.sh to C. This patch series, along with
>>> pt/am-foreign, improved test coverage as measured by kcov from 56.5%[1] to
>>> 67.3%[2].
>>>
>>> No tests for git-am's interactive mode, though, as test_terminal does not seem
>>> to attach a pseudo-tty to stdin(?), thus making git-am's "test -t
>>> 0" check fail.
>>>
>>> This is part of my GSoC project to rewrite git-am.sh to a C builtin[3].
>> 
>> The whole series looks good to me.
>
> I concur (my two comments really are minor nit picks).
>
> Thanks,
> Dscho

Yeah, looked more-or-less ready for 'next' to me, too.

Thanks, all.
