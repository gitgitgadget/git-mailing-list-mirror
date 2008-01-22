From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit: exit non-zero if we fail to commit the index
Date: Tue, 22 Jan 2008 15:42:27 -0800
Message-ID: <7vfxwpqvfg.fsf@gitster.siamese.dyndns.org>
References: <7v63xtmc9z.fsf@gitster.siamese.dyndns.org>
	<47964370.8010300@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jan 23 00:43:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHSmA-0006fw-T3
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 00:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbYAVXmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 18:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753385AbYAVXml
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 18:42:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47373 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbYAVXml (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 18:42:41 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A7382024;
	Tue, 22 Jan 2008 18:42:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D4292023;
	Tue, 22 Jan 2008 18:42:33 -0500 (EST)
In-Reply-To: <47964370.8010300@nrlssc.navy.mil> (Brandon Casey's message of
	"Tue, 22 Jan 2008 13:26:40 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71479>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> ---
>
>
> Junio C Hamano wrote:
>> Brandon Casey <casey@nrlssc.navy.mil> writes:
>> 
>>>>  We would need to tell the user that the index is not where
>>>> it is when we detect the error, though.
>>> The new index we are trying to rename will be deleted.
>>> Are you saying we should 
>>>   warn the user that the index is now out of sync?
>> 
>> Yeah, something like that.  But I think that once this happens
>> there is no easy and sane recovery path for the user, as the
>> most likely cause of the failure there would be the user running
>> out of quota, so "git reset HEAD" which may be the way to
>> recover from that failure would not have enough room to create a
>> new index file anyway.
>
> If you're interested, here's a patch.

Looks Ok from a quick glance.  I am mired at day job this week
so it may take a while for me to come up with a commit log
message though.
