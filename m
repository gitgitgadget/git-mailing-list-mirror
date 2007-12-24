From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document git rev-list --first-parent
Date: Mon, 24 Dec 2007 01:13:25 -0800
Message-ID: <7vprwwsbey.fsf@gitster.siamese.dyndns.org>
References: <1198484450-16454-1-git-send-email-avi@qumranet.com>
	<7v3atstry4.fsf@gitster.siamese.dyndns.org>
	<476F6F95.1030506@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Avi Kivity <avi@qumranet.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 10:14:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6jNp-0005AZ-Mm
	for gcvg-git-2@gmane.org; Mon, 24 Dec 2007 10:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbXLXJNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2007 04:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbXLXJNe
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Dec 2007 04:13:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48172 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbXLXJNd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2007 04:13:33 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D08F7AA6;
	Mon, 24 Dec 2007 04:13:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CED4D7AA5;
	Mon, 24 Dec 2007 04:13:27 -0500 (EST)
In-Reply-To: <476F6F95.1030506@qumranet.com> (Avi Kivity's message of "Mon, 24
	Dec 2007 10:36:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69208>

Avi Kivity <avi@qumranet.com> writes:

> Junio C Hamano wrote:
>> Avi Kivity <avi@qumranet.com> writes:
>>
>>> Document git rev-list's --first-parent option.  Documentation taken from
>>> git log.
>>> ...
>>> +--first-parent::
>>> +	Follow only the first parent commit upon seeing a merge
>>> +	commit.  This  option gives a better overview of the
>>> +	evolution of a particular branch.
>>> +
>>>
>>
>> I am afraid that this description is not sufficient.  The
>> history given by --first-parent is useful only in a very limited
>> use case, and the user needs to be aware of it.
>
> I don't know which use case you are referring to...

Please read the commit log message you snarfed the description
again.

First-parent is useful only if you are the primary integrator
and do not fast-forward from other people.  Only in that case,
you will see the overview of "the primary integration branch".
Otherwise you will observe the history viewed by whoever
happened to make a merge, which would switch every time you
cross the fast-forward boundary.

Making it sound as if it always will give a better overview is
misleading.
