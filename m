From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv12 00/23] git notes
Date: Wed, 27 Jan 2010 12:00:32 -0800
Message-ID: <7vzl3zpbbz.fsf@alter.siamese.dyndns.org>
References: <1264593120-4428-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jan 27 21:00:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaE4F-0000Mw-Bn
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 21:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412Ab0A0UAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 15:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752324Ab0A0UAm
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 15:00:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab0A0UAl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 15:00:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 03AA594A28;
	Wed, 27 Jan 2010 15:00:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yOGp+KUwssUGmKcswzaR0GRFtdA=; b=j4eNZD
	hZ8s24SSHWRj+XKu7k2d4O9ybox+nOsN8Hv/J3wKB06U1EltkzkLxzwynn4dUCuu
	ib52vanQS1C0IGjQIQ8qEExSV6cp64kDY8lilwb8A+gX4WBegY4BNmUU23USSnIU
	9cftUGd0zGqds7TR9kf6Q8zGPww+GFGONvB9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=geVoEAG5E4ZvJDkM2nJkmQSMdVrpsjEI
	LIbVPjNREJ3ieUx+sbF86xzJNA+npvgt9kbElkQJGtHqgm2fEfDxgzZKRJXzeRDE
	5qyydYOAbOJWkKi0cN7BeKsLBOdwVjQvIo2vMU2GAHWNDspRQejove1w2eO5EPPR
	BNACQ9DmLvU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D36A894A27;
	Wed, 27 Jan 2010 15:00:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C5CE94A26; Wed, 27 Jan
 2010 15:00:34 -0500 (EST)
In-Reply-To: <1264593120-4428-1-git-send-email-johan@herland.net> (Johan
 Herland's message of "Wed\, 27 Jan 2010 12\:51\:37 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A2BB311A-0B7E-11DF-90F3-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johan Herland <johan@herland.net> writes:

> - Patch #23 is a new patch adding the "git notes add" command for appending
>   contents to notes (instead of editing/replacing).

I find this even more confusing.  Originally I was puzzled by the lack of
"git notes add"; it took me for quite until I managed to figure out that
"git notes edit" was the command to use, even if I wanted to add notes to
a commit that I know that does not have any.

I would expect "git notes edit" to be "edit starting from the existing one
(if exists)", and "git notes add" to be "add notes to a commit that lacks
one, complain if it already has notes, and allow --force to replace".
