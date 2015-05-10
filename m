From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] sequencer.c: abbreviate hashs placed in the middle of messages
Date: Sun, 10 May 2015 21:36:23 +0200
Message-ID: <vpqegmow7go.fsf@anie.imag.fr>
References: <1431104035-2056-1-git-send-email-ralf.thielow@gmail.com>
	<CAPig+cSeNn0r7N6vp+qs4NTNwfYx5p-zUX3tkifuXLu+nB2yNQ@mail.gmail.com>
	<xmqqbnhvm1f5.fsf@gitster.dls.corp.google.com>
	<CAN0XMOKPbKUMwU5-T78m_knt=9O2GkKaqmXKViSi5k-Z7Damrg@mail.gmail.com>
	<xmqqtwvmlxlo.fsf@gitster.dls.corp.google.com>
	<CAN0XMO+ZY-oXb1aWK3TzUxDRuBEEoasxjdagYQQoB+JVheju9Q@mail.gmail.com>
	<xmqqa8xekeb2.fsf@gitster.dls.corp.google.com>
	<vpqwq0g2462.fsf@anie.imag.fr>
	<xmqqzj5cfdit.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 10 21:36:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrX1l-0004p2-Um
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 21:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbbEJTgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2015 15:36:37 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49510 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbbEJTgg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2015 15:36:36 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4AJaK7i013850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 10 May 2015 21:36:20 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4AJaNdm022917;
	Sun, 10 May 2015 21:36:23 +0200
In-Reply-To: <xmqqzj5cfdit.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sun, 10 May 2015 12:17:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 10 May 2015 21:36:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4AJaK7i013850
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1431891381.12247@fukzNsWkdJ4zZhDjFhXLFg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268739>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> I am not sure how that changes anything.
>>>
>>>     $ git cherry-pick 38e70713119c25ab5699df6b2fb13e4133d399ab
>>>     error: that commit is a merge and you didn't give me -m <which-parent>
>>>
>>>     $ git cherry-pick 38e70713119c25ab5699df6b2fb13e4133d399ab
>>>     error: the commit 38e707... is a merge and you didn't give me -m <which-parent>
>>
>> But ...
>>
>>     ./myscript.sh
>>     error: that commit is a merge and you didn't give me -m <which-parent>
>
> If myscript.sh did not take the user input, what would the first
> thing you (who tried to run the script) would do?  At that point,
> figuring out which wrong commit was fed to underlying cherry-pick
> becomes a lot less important issue than figuring out _why_ the buggy
> script fed a wrong commit to it, doesn't it?

True, but knowing which commit was fed to cherry-pick may explain why it
did so. Sure, a developer could find out, but a user asking a question
or reporting an issue is more effective when the error message contains
as much information as possible.

(Admittedly, in this senario, I should have written
./someone-else-s-script.sh ;-) )

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
