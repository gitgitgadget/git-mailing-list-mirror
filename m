From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Remove repo-config
Date: Wed, 16 Jan 2008 09:20:10 -0800
Message-ID: <7vlk6psn5h.fsf@gitster.siamese.dyndns.org>
References: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com>
	<7vtzles8j8.fsf@gitster.siamese.dyndns.org>
	<478D8AA8.3070008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 18:21:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFBwn-0007D3-1Y
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 18:21:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbYAPRUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 12:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbYAPRUe
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 12:20:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbYAPRUd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 12:20:33 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 117EF43A8;
	Wed, 16 Jan 2008 12:20:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AED743A6;
	Wed, 16 Jan 2008 12:20:22 -0500 (EST)
In-Reply-To: <478D8AA8.3070008@gmail.com> (Dan McGee's message of "Tue, 15 Jan
	2008 22:40:08 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70702>

Dan McGee <dpmcgee@gmail.com> writes:

> On 01/15/2008 10:23 PM, Junio C Hamano wrote:
>> I do not think it is unreasonable to add repo-config to feature
>> removal schedule in 1.5.4 release notes.  Perhaps something like...
>> 
>> + * "git repo-config", which was an old name for "git config" command,
>> +   has been supported without being advertised for a long time.  The
>> +   next feature release will remove it.
>> +
>
> Seems fine to me. Does it need to be put in command-list.txt for the time being too, or what all is that file used for? Sorry I am not familiar.
>
> Something like:
>
> git-repo-config                       ancillarymanipulators	deprecated

Technically, you are right, but somehow it feels backwards.

We stopped advertising the existence of the command in v1.5.0,
and adding it to the list now would mean we need to add a new
git-repo-config manual page that says "This is deprecated, use
git-config instead".
