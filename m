From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2013, #01; Fri, 1)
Date: Mon, 04 Nov 2013 13:50:19 -0800
Message-ID: <xmqqy553alb8.fsf@gitster.dls.corp.google.com>
References: <xmqqob6320rt.fsf@gitster.dls.corp.google.com>
	<878ux7g1ml.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Nov 04 22:50:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdS2Y-0003sY-76
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 22:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355Ab3KDVu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 16:50:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47706 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957Ab3KDVuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 16:50:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 947BB5004A;
	Mon,  4 Nov 2013 16:50:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QOlOb1o+x6kvxZUj3g/vpgASGCU=; b=U+VLJC
	kn+zpxRKm7iHn//jE7B7eHFrd8KVBEF5CenberEbgyDN948A1rkvJiU7LFb7s8nJ
	lBzKeqAIkyrP7XM0zPdc0O/ORNwMCG50d+DvdB5rx1uhN1x8s/fIBTKhYPZTo0H7
	Me08uNUzSqi3FdQsLTKR24Yi8Dy+COD1V/Nu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q65gkEygf5+pgXc24O3ZPbtoHXCXIC/b
	2GCkVxr3sxNHn58t7B8C32sjO+YJ25GW9+zeqNpDo7KD9ZVnVjff/fmzm+e1P4wz
	NHLJP+grbkwT5se5BLpPYVtULa2w+t5abpl2bF6rp//nrcCAn46TEmIu1LoQqi4l
	eduhGx4tbMs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 813A750048;
	Mon,  4 Nov 2013 16:50:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA0E050044;
	Mon,  4 Nov 2013 16:50:23 -0500 (EST)
In-Reply-To: <878ux7g1ml.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Sat, 02 Nov 2013 00:09:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1BBF5604-459B-11E3-95A9-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237307>

Thomas Rast <tr@thomasrast.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * tr/merge-recursive-index-only (2013-10-28) 3 commits
>>  - merge-recursive: -Xindex-only to leave worktree unchanged
>>  - merge-recursive: internal flag to avoid touching the worktree
>>  - merge-recursive: remove dead conditional in update_stages()
>
> FWIW -- since you dropped the earlier note to the same effect -- I still
> consider this "hold until Michael finds a use for it".

Noted; thanks.
