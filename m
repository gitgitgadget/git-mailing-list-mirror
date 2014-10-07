From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [RFC/PATCH] git-merge: implement --ff-only-merge option.
Date: Wed, 08 Oct 2014 00:42:25 +0400
Message-ID: <87a957obm6.fsf@osv.gnss.ru>
References: <1412699710-3480-1-git-send-email-sorganov@gmail.com>
	<xmqqzjd7enet.fsf@gitster.dls.corp.google.com>
	<87fvezsk5k.fsf@osv.gnss.ru>
	<xmqqegujeibx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 22:42:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xbbaa-0008Bf-Ky
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 22:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbaJGUm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 16:42:28 -0400
Received: from mail.javad.com ([54.86.164.124]:44927 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264AbaJGUm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 16:42:28 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 4CA1061878;
	Tue,  7 Oct 2014 20:42:27 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XbbaT-0005kz-K4; Wed, 08 Oct 2014 00:42:25 +0400
In-Reply-To: <xmqqegujeibx.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 07 Oct 2014 13:27:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257960>

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> Why would it be useful to limit the history to a shape where all
>>> merges are the ones that could have been fast-forwarded?
>>
>> Except by true merge, how else can I express with git that 'n'
>> consequitive commits constitute single logical change (being originally
>> some topic branch)?
>
> You are justifying --no-ff, aren't you?

Yes, and I already said it's close. But I don't want such merge commit
to contain any non-trivialities. Currently I check it manually before
issuing "merge --no-ff" and was hoping for some automation.

>
>> Moreover, as topic branches are usually rebased before merge anyway,
>> why shouldn't I have simple capability to enforce it?
>
> Because rebasing immediately before is considered a bad manner,
> i.e. encouraging a wrong workflow?

Why? What is wrong about it?

Please also notice that I don't try to impose this on anybody who does
consider it wrong workflow.

-- 
Sergey.
