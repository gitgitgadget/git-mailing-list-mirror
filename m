From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: GSoC 2014: Summary so far, discussion starter: how to improve?
Date: Sat, 26 Oct 2013 10:14:21 +0200
Message-ID: <87txg4qwiq.fsf@linux-k42r.v.cablecom.net>
References: <8761stx04i.fsf@linux-k42r.v.cablecom.net>
	<xmqqli1lro08.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 26 10:14:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZz17-0008LF-5O
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 10:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153Ab3JZIOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 04:14:36 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:50263 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817Ab3JZIOe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 04:14:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id F24CF4D6514;
	Sat, 26 Oct 2013 10:14:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id S1-T9lnKclId; Sat, 26 Oct 2013 10:14:22 +0200 (CEST)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (unknown [213.55.184.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 4095E4D6414;
	Sat, 26 Oct 2013 10:14:22 +0200 (CEST)
In-Reply-To: <xmqqli1lro08.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 22 Oct 2013 14:31:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236741>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <tr@thomasrast.ch> writes:
>
>> Theories
>> ========
>>
>> * Scope creep: projects tend to get blocked on some bigger
>>   refactoring/restructuring task that was not in the original
>>   proposal.

(Full disclosure: I actually proposed this theory.)

> I think that is a sign that the original proposal did not look
> enough at the existing code, dreaming of a pie-in-the-sky shiny
> features in a green-field setting. What needs to be done within the
> constraint of the existing code (including a total rewrite, if
> necessary, while keeping the project's codebase maintainable is part
> of the healthy develpment.

Hmm, yes, but it's also the only objection that I believe I have never
heard, as opposed to ignored.

I'm okay if we just file this under "things to consider during project
proposal review".

>> * Have students review some patches
>
> I am not sure if this would help.
>
> Reviewing the patches to find style violations and off-by-one errors
> is relatively easy as it can be done with knowledge on a narrow
> isolated part of the system. Reviewing the design to make sure that
> the change fits the way how existing subsystems work, ranging from
> the internal API implementation level to consistency a changed
> behaviour is presented at the UI level, however, needs understanding
> of the far wider entire project than only the parts of the system
> the proposed change updates. It will be even more true if the chosen
> topic is a cool/shiny one.

I'd choose the middle path: review for code readability.  What do the
functions do?  Are the functions and variables named after their roles?
Is there anything that I cannot understand, and therefore warrants a
comment?

That is much more difficult than just reviewing for style, while it can
(usually) be done without too much knowledge of the outside.

-- 
Thomas Rast
tr@thomasrast.ch
