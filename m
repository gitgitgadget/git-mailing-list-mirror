From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Release notes grammatical fixes.
Date: Tue, 05 Aug 2014 11:43:24 -0700
Message-ID: <xmqq8un2pyk3.fsf@gitster.dls.corp.google.com>
References: <xmqqy4v3q43r.fsf@gitster.dls.corp.google.com>
	<1407257445-18363-1-git-send-email-marcnarc@xiplink.com>
	<xmqqha1qpz7e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 20:43:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEjhy-0003ZD-Ph
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 20:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756264AbaHESnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 14:43:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50557 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754787AbaHESnd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 14:43:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B30F52D398;
	Tue,  5 Aug 2014 14:43:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yMn8bkqClEVIeqpzFeP1t1AZgq8=; b=InnPbc
	+rNqTO4wrlyQItEqhF+7OxnOyKa8US0BmrH5MMLB8d0FBOtDqBDzXvictx3FUJiF
	QUHNNlag3/t5BG0Iw61lKFeYXVp/8jXMK6iltAvmWpjcAF6SB5Rzbj+eZ8UIP0Jw
	Gvt6VQAVjGSNYmkTaCXqOWcDfcbxJ0mfj4PlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BYrjI8irt96yKcV3AQMem+BYlZYk4zf7
	IZI/Cl0GvV+cYa7wMDTzjBrvv07XWrx56TuPHyeDFjHpDPHBKQJmkjb4VIHMS0RK
	42dUI2jFufpHgF1xSA3KfBFWWHr/8XTeFKfYnoMS3lqUkMpVJkNkker8Z5XRK4pk
	gX1licKGBEk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A8CE72D397;
	Tue,  5 Aug 2014 14:43:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 09F802D38C;
	Tue,  5 Aug 2014 14:43:25 -0400 (EDT)
In-Reply-To: <xmqqha1qpz7e.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 05 Aug 2014 11:29:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6292ADD0-1CD0-11E4-A128-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254820>

Junio C Hamano <gitster@pobox.com> writes:

> Marc Branchaud <marcnarc@xiplink.com> writes:
> ...
>> @@ -87,22 +87,20 @@ UI, Workflows & Features
>>   * "git mergetool" learned to drive the vimdiff3 backend.
>>  
>>   * mergetool.prompt used to default to 'true', always asking "do you
>> -   really want to run the tool on this path?".  Among the two
>> -   purposes this prompt serves, ignore the use case to confirm that
>> -   the user wants to view particular path with the named tool, and
>> -   redefine the meaning of the prompt only to confirm the choice of
>> -   the tool made by the autodetection (for those who configured the
>> -   tool explicitly, the prompt shown for the latter purpose is
>> -   simply annoying).
>> -
>> -   Strictly speaking, this is a backward incompatible change and the
>> +   really want to run the tool on this path?".  The default has been
>> +   changed to 'false'.  However, the prompt will still appear if
>> +   mergetool used its autodetection system to guess which tool to use.
>> +   Users who explicitly specify or configure a tool will no longer see
>> +   the prompt by default.
>> +
>> +   Strictly speaking, this is a backward incompatible change and
>>     users need to explicitly set the variable to 'true' if they want
>> -   to resurrect the now-ignored use case.
>> +   to resurrect the old behaviour.
>
> I however think you are losing information here.  It is unclear in
> the rewritten one why you would ever want the "old" behaviour, i.e.
> what you may be missing by following along with this change.

Perhaps this on top of yoru patch?

 Documentation/RelNotes/2.1.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.1.0.txt b/Documentation/RelNotes/2.1.0.txt
index 4fd153e..1b16b12 100644
--- a/Documentation/RelNotes/2.1.0.txt
+++ b/Documentation/RelNotes/2.1.0.txt
@@ -95,7 +95,7 @@ UI, Workflows & Features
 
    Strictly speaking, this is a backward incompatible change and
    users need to explicitly set the variable to 'true' if they want
-   to resurrect the old behaviour.
+   to be prompted to confirm running the tool on each path.
 
  * "git replace" learned the "--edit" subcommand to create a
    replacement by editing an existing object.
