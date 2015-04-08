From: Koosha Khajehmoogahi <koosha@posteo.de>
Subject: Re: [PATCH v2 2/5] log: honor log.merges= option
Date: Wed, 08 Apr 2015 12:42:50 +0200
Message-ID: <5525062A.2010905@posteo.de>
References: <1428110521-31028-1-git-send-email-koosha@posteo.de>	<1428110521-31028-2-git-send-email-koosha@posteo.de>	<xmqqy4m7ek9q.fsf@gitster.dls.corp.google.com>	<5524571C.90007@posteo.de> <xmqq4morcq0l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 12:43:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfnSY-0001jU-Fv
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 12:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbbDHKnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 06:43:45 -0400
Received: from mx02.posteo.de ([89.146.194.165]:50125 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752898AbbDHKnp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 06:43:45 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id 1D7D625B17E7;
	Wed,  8 Apr 2015 12:43:43 +0200 (CEST)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3lMMf74plMz5vMr;
	Wed,  8 Apr 2015 12:43:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <xmqq4morcq0l.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266951>



On 04/08/2015 04:28 AM, Junio C Hamano wrote:
> Koosha Khajehmoogahi <koosha@posteo.de> writes:
> 
>> On 04/04/2015 10:00 PM, Junio C Hamano wrote:
>>> Koosha Khajehmoogahi <koosha@posteo.de> writes:
>>>
>>>> From: Junio C Hamano <gitster@pobox.com>
>>>>
>>>> [kk: wrote commit message]
>>>
>>> Ehh, what exactly did you write ;-)?
>>>
>>> I think the most important thing that needs to be explained by the
>>> log message for this change is that the variable is honored only by
>>> log and it needs to explain why other Porcelain commands in the same
>>> "log" family, like "whatchanged", should ignore the variable.
>>>
>> So, what would be the reason? 
> 
> It is strange that you have to ask me to give you the reason why you
> chose it that way, isn't it?

AFAIK, the only other command that supports --merges and --no-merges options is
rev-list. This new feature aims to make a default behavior for the commands
that have these options. The command-line option is supported by the two commands.
However, the config var is only used by git-log and rev-list ignores it. I didn't
exclude rev-list for any particular reason. If we need, I could also handle it in
rev-list.
