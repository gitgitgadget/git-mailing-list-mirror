From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Filenames and prefixes in extended diffs
Date: Fri, 15 Jan 2010 10:09:07 -0800
Message-ID: <7vska71br0.fsf@alter.siamese.dyndns.org>
References: <201001131713.05505.agruen@suse.de>
 <7vfx69k0bu.fsf@alter.siamese.dyndns.org>
 <20100115223259.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 19:09:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVqby-000184-Vt
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 19:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757959Ab0AOSJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 13:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757958Ab0AOSJS
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 13:09:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757950Ab0AOSJP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 13:09:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BCB691882;
	Fri, 15 Jan 2010 13:09:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uDxafOWrQUnlE4BpBpGpcds0mK8=; b=AB4YKB
	U0yo7VrN+aivgdJLyQue89nHF3cnHwykoXomPd1TdDZydPi51HtAaXbzpuhB5tks
	KJxK6ywRsDRMy/6Vs+LYCFS5ui3RR0uukCPsGN8j6j+EOclrep6p3laRcoFkgcBz
	7E9XgCM9UyYhS3KgS5Uh0sVQvpOeN4hoNOhwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NCOW40Pvn9KxJna8zwZft1yGRodadkuQ
	hKLCxb6WPdUnsPCjj6qTzeqtKLrcA+ZNpVJvQkfdM3VURMHDpaDCk1IYJd1zr+A8
	Zf4rbzDSKFg8MOqsBZ4KuebTC72ot6A6o3VmAX4dNutSBUHBYqNj12lX7jWlICim
	/GHu9i7/68Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 271B79187B;
	Fri, 15 Jan 2010 13:09:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8329C9187A; Fri, 15 Jan
 2010 13:09:09 -0500 (EST)
In-Reply-To: <20100115223259.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Fri\, 15 Jan 2010 22\:32\:59 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1560B6FE-0201-11DF-BCF5-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137090>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>
>
>> The output from "git diff --no-index" is an exception to the above rule.
>> It is primarily for people who have unmanaged contents and want to use
>> features of the git diff engine that are not found in other people's diff
>> implementations (e.g. wordwise colored diff),...
>
> Is it possible to give --no-index option to "git grep", please?

Surely.  And "grep" is much easier to do than "diff".  Will send a patch
perhaps during my lunch break.
