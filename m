From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] unblock and unignore SIGPIPE
Date: Thu, 18 Sep 2014 10:35:18 -0700
Message-ID: <xmqqvbokomqx.fsf@gitster.dls.corp.google.com>
References: <1411059429-23868-1-git-send-email-patrick.reynolds@github.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Patrick Reynolds <patrick.reynolds@github.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 19:35:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUfc7-0003Sx-5q
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 19:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757137AbaIRRfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2014 13:35:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54502 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756296AbaIRRfW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2014 13:35:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 456193A39E;
	Thu, 18 Sep 2014 13:35:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+eWgJyyk3PEXsDGMvgMtgcUUCAk=; b=ZBR+Jb
	/nJqlKEGwMglntKMt3eA3Lpy6Y/iYxZ+Uqde1k8Eye0F02jzBKBoq0dXyDijlPuo
	8q2ud3NbzLeLH5mIY8VGeYvVGs/GXHdy8bjMIX21xIRpfqjmkBWiG6BqKo/QhSsA
	TPVlgIinkisetpAO/OylhaHa2ynCYbuC4NpH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p5egXj/KJhmdqUpd8Dze+aq4zhTPiCjo
	Sy+zoJFUuW7NjNcIPCQOsBe+Vzobj9i4LW4fA0QN/kW6io17nSysUEJZFfuhomzL
	3FCIFpXToP8Mdc/EFLHqAl8ZfJzRYtuofX7CBCD+dXfP1CKyggsKZSwBiyE4lr1R
	mxTOK3hocE0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1D5F73A39D;
	Thu, 18 Sep 2014 13:35:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 644F33A399;
	Thu, 18 Sep 2014 13:35:20 -0400 (EDT)
In-Reply-To: <1411059429-23868-1-git-send-email-patrick.reynolds@github.com>
	(Patrick Reynolds's message of "Thu, 18 Sep 2014 11:57:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 298625EC-3F5A-11E4-A9E9-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257270>

Thanks!
