From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Another use of "@"?
Date: Fri, 3 May 2013 11:23:49 +0200
Message-ID: <8738u4pgbe.fsf@linux-k42r.v.cablecom.net>
References: <CACsJy8AcWV8hmbhG27dw+GdnZf8NnQEctYmowqd3sSzOOHf+xg@mail.gmail.com>
	<7vr4hozie1.fsf@alter.siamese.dyndns.org>
	<7vfvy4zhy5.fsf@alter.siamese.dyndns.org>
	<CACsJy8Btz6=4ZUjW3OR2v-LDaDcDaiK=7ucf8rO8MsG9cXt++g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Felipe Contreras" <felipe.contreras@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 03 11:23:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYCDd-0002TH-MB
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 11:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762899Ab3ECJXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 05:23:53 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:17185 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752315Ab3ECJXw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 05:23:52 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 3 May
 2013 11:23:42 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 3 May 2013 11:23:50 +0200
In-Reply-To: <CACsJy8Btz6=4ZUjW3OR2v-LDaDcDaiK=7ucf8rO8MsG9cXt++g@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 3 May 2013 16:51:21 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223300>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, May 3, 2013 at 4:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Duy Nguyen <pclouds@gmail.com> writes:
>>>
>>>> My setup is a bit peculiar where I do git development on three
>>>> different machines. Say I updated branch long-branch-name on machine
>>>> A. Then I continue my work on machine B. I would want to hard reset
>>>> that long-branch-name on machine B before resuming my work. What I
>>>> usually do is
>>>>
>>>> git co long-branch-name
>>>> git diff A/long-branch-name
>>>> git reset --hard A/long-branch-name
>>>
>>> Perhaps
>>>
>>>     git checkout long-bra<TAB>
>>>     git diff A/!$
>>>     git reset --hard !$
>
> "diff" does not have to follow "checkout".

At least in bash with readline, you can also use M-. to cycle through
the last arguments of the previous commands.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
