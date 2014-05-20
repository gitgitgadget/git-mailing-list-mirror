From: Junio C Hamano <gitster@pobox.com>
Subject: Re: untracked file deleted from the master branch, when checked out to it from a local branch
Date: Tue, 20 May 2014 11:24:11 -0700
Message-ID: <xmqqk39gz4tw.fsf@gitster.dls.corp.google.com>
References: <2525467.KRXv8a3gWS@linux-wzza.site>
	<1949847.AaDQEtxZHd@linux-wzza.site>
	<537B8BA9.7060207@storm-olsen.com>
	<2726779.MFtIaLB4b4@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arup Rakshit <aruprakshit@rocketmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 20:24:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmoi4-0006mw-JF
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 20:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbaETSYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 14:24:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50446 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745AbaETSYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 14:24:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CEACB18CDD;
	Tue, 20 May 2014 14:24:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DKskjxhbRsq/xgHauV41Y3MYr08=; b=FnvXg8
	KXxWBYNWMBNnSlfXRCJxvJK4hzrfkMuGmD1Bq2WkvGsgTWxoqOrkO0Tu5u73rEy3
	bNzKQifI5WaZsczxxPQvd6eHExdQ/abP+aV7ksm92zu8KKArFC133nlKi/SXfykI
	pYust/jDzSkFFLsoo1ksC7BifDU+e/n3aZQic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ThSPf8aE5aHTSGZXux0jPe7ZNWLRgyfZ
	/7scatBv3pEFSfWnWjRSSOOQj/1NpiFFd/ofXH3wqq5JMCSEgT+vX7xPWSZ+t2PI
	NVsKECLNolB8YiEAZF+3M8KnFYJ08HN4AEtcTXDh1TZ9PsOPHaEP5ZhmNk/ZzagV
	QyYYQFmt4dU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C517418CDA;
	Tue, 20 May 2014 14:24:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C431518CD2;
	Tue, 20 May 2014 14:24:12 -0400 (EDT)
In-Reply-To: <2726779.MFtIaLB4b4@linux-wzza.site> (Arup Rakshit's message of
	"Tue, 20 May 2014 23:50:17 +0630")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F1619934-E04B-11E3-BF7E-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249718>

Arup Rakshit <aruprakshit@rocketmail.com> writes:

> On Tuesday, May 20, 2014 12:06:49 PM you wrote:
>
>> 
>> It never "came to the new branch", as it was never version controlled,
>> it was an untracked file left behind when you switched branches.
>> 
>> Once you added it to the new branch, change_class, it became a version
>> controlled file, 
>
> This is still  didn't get it. If an untracked file didn't come in the new 
> branch, how would I able to add it to stage ? I am not getting this part. You 
> are right, but I am not able to understand this one, my bad! :(

Untracked files and modifications to files in your working directory
do not belong to your current branch.  This is to allow you, after
starting to work on one branch then realizing that the changes and
additions you are making do not belong there, to switch to a more
appropriate branch at that point without losing your work so far,
taking these changes and additions with you to the branch you want
to commit your changes to.
