From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Remove repo-config
Date: Wed, 16 Jan 2008 12:32:12 -0800
Message-ID: <7vsl0xo6k3.fsf@gitster.siamese.dyndns.org>
References: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com>
	<7vtzles8j8.fsf@gitster.siamese.dyndns.org>
	<478D8AA8.3070008@gmail.com>
	<7vlk6psn5h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 21:32:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFEwJ-0001CZ-QJ
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 21:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbYAPUcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 15:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbYAPUcT
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 15:32:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65402 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbYAPUcT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 15:32:19 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EA744A95;
	Wed, 16 Jan 2008 15:32:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1559B4A94;
	Wed, 16 Jan 2008 15:32:13 -0500 (EST)
In-Reply-To: <7vlk6psn5h.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 16 Jan 2008 09:20:10 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70741>

Junio C Hamano <gitster@pobox.com> writes:

> Dan McGee <dpmcgee@gmail.com> writes:
>
>> On 01/15/2008 10:23 PM, Junio C Hamano wrote:
>>> I do not think it is unreasonable to add repo-config to feature
>>> removal schedule in 1.5.4 release notes.  Perhaps something like...
>>> 
>>> + * "git repo-config", which was an old name for "git config" command,
>>> +   has been supported without being advertised for a long time.  The
>>> +   next feature release will remove it.
>>> +
>>
>> Seems fine to me. Does it need to be put in command-list.txt for the time being too, or what all is that file used for? Sorry I am not familiar.
>>
>> Something like:
>>
>> git-repo-config                       ancillarymanipulators	deprecated
>
> Technically, you are right, but somehow it feels backwards.
>
> We stopped advertising the existence of the command in v1.5.0,
> and adding it to the list now would mean we need to add a new
> git-repo-config manual page that says "This is deprecated, use
> git-config instead".

This comment was wrong.  We can keep the existing repo-config
documentation that has deprecation notice, and add the above
line to the list.

Sorry about the confusion.
