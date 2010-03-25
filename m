From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Automating builds and testing of git.git
Date: Wed, 24 Mar 2010 19:04:43 -0700
Message-ID: <7vzl1xf96s.fsf@alter.siamese.dyndns.org>
References: <20100325013352.GE4062@kiwi.sharlinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@monkeypox.org>
X-From: git-owner@vger.kernel.org Thu Mar 25 03:05:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NucRS-0006M7-8M
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 03:05:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277Ab0CYCEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 22:04:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52436 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab0CYCEw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 22:04:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E2612A514F;
	Wed, 24 Mar 2010 22:04:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=noaBtq3RMHche6F7YTk49uaa4fI=; b=mbBYr8
	QnGowthRfW25XPRJAxBHaZnXlVUyXBW/ZqOUEkRKZvIUWXJqtpOQF2gnQfvUFY8O
	ejxuU1yz0AzbmJG4SWLDeyLcFzzpdFVde6wUrwBhLjsJF2xmWEcoruz/ACEe5Rsa
	uFhgM2VHkxza4xSe49MHEG6oPWivv5lSQY+Dw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J1oyNnC/DPWxZkbTwzzcUy0gLd8sfCc6
	ZtHJX+CkcMorPao6nvZhua4Mj1oWH0io9E1AJ1nUrhentVi/M/0yK10gnk4zxbMf
	dYOfPOSRnY9tjB+9AhYY46ASihT9nC4ONsv4vGZ6Pk5A+dUQOuFsjCS7FTuaWgz8
	58iL2GUGMf0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9112FA514E;
	Wed, 24 Mar 2010 22:04:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E801A514D; Wed, 24 Mar
 2010 22:04:44 -0400 (EDT)
In-Reply-To: <20100325013352.GE4062@kiwi.sharlinx.com> (R. Tyler Ballance's
 message of "Wed\, 24 Mar 2010 18\:33\:53 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CA7E684C-37B2-11DF-A422-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143141>

"R. Tyler Ballance" <tyler@monkeypox.org> writes:

> The build is currently being run for master and next:
>     http://hudson.brokenco.de/job/Git/
>     http://hudson.brokenco.de/job/Git__next
>
> They're both pulling from: git://git.kernel.org/pub/scm/git/git.git
> which I don't think is seeing updates that often except for occasional pushes.

The master and next branches would be good branches to check, and maint
would also be.  It is likely that you saw "occasional pushes" because I've
been slower than my usual self for the last past couple of weeks.

FWIW, I run tests except for t9xxx series on all branches on FreeBSD 8.0
(and Fedora 11) running in a vm before pushing them out, but an extra set
of eyes is always appreciated.  The ports/packages I have installed there
might be missing stuff causing some tests to be skipped.
