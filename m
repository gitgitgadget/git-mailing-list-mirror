From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] Documentation style fixes
Date: Sat, 09 Jan 2010 22:34:58 -0800
Message-ID: <7vfx6efox9.fsf@alter.siamese.dyndns.org>
References: <7vaawp4wvz.fsf@alter.siamese.dyndns.org>
 <cover.1263081032.git.trast@student.ethz.ch>
 <201001100107.29920.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 10 07:35:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTrOL-0003GP-PU
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 07:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387Ab0AJGfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 01:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289Ab0AJGfI
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 01:35:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab0AJGfH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 01:35:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F2708F3C2;
	Sun, 10 Jan 2010 01:35:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=SOv8xQIFUgSMvtbSDVn/yUVZFto=; b=lktFrAfYuBYIQchw1o5l2lf
	mWN4bobVg6kp8SI8jfdj0zkRA5oVU6nP/XUSrlGSPHL2QHbTeMEWgY5BUu++KzTc
	NsqUthZUOkd3wPefRQrT1yjJt8TBbkCwp1gSg/KIfYQvSQnkVI8pdhrxiUwVmURQ
	9ule+k33NJi6RDq4DmPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=BZLmrhUNbmbFiNF+sFsm4ku+QCQnGb/4s2x+MiELYgOSuIumy
	+Pc6rHE5xqufVHtInEUUwEqCNqzCjK7RNiTdG1rmuiNP5fOGoA9hE5M0VGAqzDBs
	WLJtqmnKMrL4/NPO3Zv8mUk/YluQdjzrkDcH3wT30M084EdsXHJyYToi9Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D87CA8F3BF;
	Sun, 10 Jan 2010 01:35:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 241108F3BE; Sun, 10 Jan
 2010 01:34:59 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 48FE4358-FDB2-11DE-A709-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136559>

As to the general direction I am in full agreement with what you and
Jonathan discussed in the review of your series, namely:

 - We prefer dashless these days;

 - Reference to a concrete command line is <code>git clone</code> which is
   typeset differently from general descriptions of what <emphasis>git
   clone</emphasis> command does.

I'd like to proceed with this series by (1) pulling from you and queuing
the result in 'next', (2) asking other people (including Jonathan) to
proofread and send necessary updates to the list, (3) asking you to check
and queue these updates from others yourself and tell me to pull again to
my 'next', and (4) merging the result to 'master' when done.

Does it sound workable?  Am I placing too much undue burden on you?
