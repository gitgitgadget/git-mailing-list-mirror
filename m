From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 11:30:52 -0800
Message-ID: <7vhbqg376b.fsf@alter.siamese.dyndns.org>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <201001201148.11701.johan@herland.net>
 <20100120182438.GB31507@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 20:31:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXgGl-0003Um-L5
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 20:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052Ab0ATTbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 14:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753768Ab0ATTbE
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 14:31:04 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41504 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab0ATTbA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 14:31:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C31692DDA;
	Wed, 20 Jan 2010 14:30:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YTe1LNBkDieSWBv3jNwAzgKnsig=; b=UF2Uvs
	HzAg6QxrvU/hwPSmWd1TD0sft1MKSB1vMEzeR/MOA4RWmTvHOaFlbiucH+NZd3D/
	7GqZ/9EIYHFgAp/jbnZHcmHb5aTJ+gNQzokVRG2huhGssRjHY1tcdr6eblTjW69C
	3ObO40ilyYCKSITUILZ6A5Pzj+qElT3eCKzm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g5ErOx0st6BSvToeJlNci06VIpM/RONi
	IacxOtdTTb94lcy8DBJSf5hXTPF/taBJ6/p56rpizitqKiwk5+YU8umhMMDTKarh
	meTF1k/D1N2t6IkA/N0W67aK6yXiFge7WGCPobfZsx2mmlLI5Rb18rO/KvfXQsAN
	bIEeX/UmBl4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6487192DD7;
	Wed, 20 Jan 2010 14:30:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE2FF92DD0; Wed, 20 Jan
 2010 14:30:53 -0500 (EST)
In-Reply-To: <20100120182438.GB31507@gnu.kitenet.net> (Joey Hess's message of
 "Wed\, 20 Jan 2010 13\:24\:38 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5499B576-05FA-11DF-A5AD-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137563>

Joey Hess <joey@kitenet.net> writes:

> Johan Herland wrote:
>> As Thomas already stated, git log is porcelain, and its output format is not 
>> set in stone. If you need a stable, script-friendly format, you should 
>> probably use the --format option, or use plumbing instead (such as e.g. git 
>> rev-list, which also has a --format option).
>
> But git log --format=raw --raw output was changed by notes.

Let me ask a stupid question.  Did the output change before and after the
notes code even when your history does not have notes?

>> > Might be worth documenting in release notes, maybe too late now though.

This depends on the answer to the above question.  If the answers is "No",
then I don't see the need to say much more than "New 'git notes' feature
allows comments applied to existing commits after the fact to be shown by
log and friends".  If it is "Yes", we should fix the code not to change
the output.

In any case, "log" is still a Porcelain, so it is understandable that by
triggering a new feature you would get output from the new feature.  It is
called progress ;-)
