From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.6.2
Date: Wed, 07 Sep 2011 04:22:32 -0700
Message-ID: <7vsjo84mx3.fsf@alter.siamese.dyndns.org>
References: <7vvct55j4h.fsf@alter.siamese.dyndns.org>
 <CAGdFq_gF8Uz_JTEUfb46kVii=Y0CwzCpOp5H81+HT8y=1PPUTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 18:16:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Knv-00008z-Oj
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 18:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756249Ab1IGQQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 12:16:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43623 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756127Ab1IGQQk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 12:16:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F08459B0;
	Wed,  7 Sep 2011 07:22:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=toYEEmPb7eWmSizavDvcwLJkPWM=; b=jL9pEp
	rANT5kcBzLJ9yhNbKWfgtQb0WfPdw5fB3yyweXSU9Hg7yuuSZH97GTeOkcS/kum8
	kBwWo4y/rOd7++ptzQNJXocNK0SlUs56lARzqI7XmtjZyGXnK2YQf3wlc7wW4Tyo
	Hy837A9oO9/RODsqfb5TZSyeL+0sfB6f+MGPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DiJYY7eio/brpWPMbGAfOKXmVVKHnK0R
	Y4JK9G1Nj+0OD69c9FgjYvsKIq+3mrm0lOmDn0aISFu9k5btIDbqfva2gpxd0meu
	LHrhTvdgJjZXTyiof34WaVjbo817wtlP11l/Ih/Qn4+kS1dTDhO5eVLvfpzJx6FD
	m1VLzxoWu+0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8716D59AF;
	Wed,  7 Sep 2011 07:22:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21EF959AE; Wed,  7 Sep 2011
 07:22:35 -0400 (EDT)
In-Reply-To: <CAGdFq_gF8Uz_JTEUfb46kVii=Y0CwzCpOp5H81+HT8y=1PPUTQ@mail.gmail.com> (Sverre
 Rabbelier's message of "Wed, 7 Sep 2011 09:47:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AF7F22D2-D943-11E0-ADFA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180862>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> That's interesting, how did revert a merge commit?

Does "git revert --help" lack the description?
