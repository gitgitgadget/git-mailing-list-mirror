From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] t9903: add extra tests for bash.showDirtyState
Date: Wed, 13 Feb 2013 12:42:41 -0800
Message-ID: <7vmwv854ji.fsf@alter.siamese.dyndns.org>
References: <1360753138.25490.10.camel@mas>
 <1360753321-5002-1-git-send-email-martinerikwerner@gmail.com>
 <1360753321-5002-3-git-send-email-martinerikwerner@gmail.com>
 <7vy5es9o0g.fsf@alter.siamese.dyndns.org> <1360777065.13768.17.camel@mas>
 <7vmwv86le8.fsf@alter.siamese.dyndns.org> <1360788036.22870.4.camel@mas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trsten@science-computing.de
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 21:43:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5jAa-0003YA-J9
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 21:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934267Ab3BMUmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 15:42:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58482 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934006Ab3BMUmo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 15:42:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEC53D018;
	Wed, 13 Feb 2013 15:42:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dk8noBn8Wl7Z1Mp1EDxUDEpeREk=; b=iBBqZx
	HnqbITTtnIxFlwzAVH9VErBMCX4iWyIU7gJCVkvNDQ/EQCPQS0yS1Ex5sY1WLXyL
	LkU8Euo3/Wmq4goBaOKudBJVkfrvOl9O/RrG0CYlF7AN1FTctZ+hlcu65vgmOPIC
	E3OiMTAsg4RXwD2/4YJNfHjrMaVWsIF/rtlUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kGw93oee74tGaMp0kHHxkbEIWaDtIg0a
	Qdu2JTLj3Cbpo6rMHw8IrhmEZnKQKT38499ewUJq+YNOWFKIcR2saO8EaFg2SYz+
	NzbzzHp7+uJjG5R3eXW4XAltd/YiBRs6rgzZg3KP9qJYiZ71WzSWNCSnceZ95Nkp
	bsfdrxkkROE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B459DD017;
	Wed, 13 Feb 2013 15:42:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2CE91D012; Wed, 13 Feb 2013
 15:42:43 -0500 (EST)
In-Reply-To: <1360788036.22870.4.camel@mas> (Martin Erik Werner's message of
 "Wed, 13 Feb 2013 21:40:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA520FD2-761D-11E2-979C-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216286>

Martin Erik Werner <martinerikwerner@gmail.com> writes:

>> OK, I'll locally amend the patch.  Thanks.
>
> Ok, so I shouldn't reroll them with s/unset -v/sane_unset/ and reworded
> commits + sign-off then, I can if you prefer that?

You can if you wanted to.  That would be less work for me ;-).
