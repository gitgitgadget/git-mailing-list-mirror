From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] GIT, Git, git
Date: Mon, 21 Jan 2013 12:01:03 -0800
Message-ID: <7vk3r6fgqo.fsf@alter.siamese.dyndns.org>
References: <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vobgifgz2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davvid@gmail.com, git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Mon Jan 21 21:01:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxNYq-0001Kq-Ta
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 21:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756581Ab3AUUBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 15:01:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58663 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755583Ab3AUUBF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 15:01:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BE90A2DE;
	Mon, 21 Jan 2013 15:01:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RtiZ7fo5jF7xTPa7ELo0ucIVA5M=; b=htaIuZ
	fw2C3I8KO6SG4vJTQwJopwpXdYNT8lIRlzrDVvZBG0L0Zy3ucnix2PuP+m353nil
	wqN4xXZinv26gIEKE4bRkjeMDR8F6jOaXNib/gwrJA2UeWLmgvfqDrIq2uJ3hYad
	rppmRZswWashFH6yE8T6jCMMHS6hWMw5Z9dwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=usbMYWqgvWt8141Un3kdz+aNWHYZeyRQ
	4Iwo0Rh59/K4dlZwfjqwnetYZ0PWQvOd4UbmBralx/psrmr32p7vzHSV0v601Q3h
	J7qalrIjgZYdjhEsS3li3CApjXdPax9k2oCechiCTf3aytfZP+EEdQaoA8HfTdSk
	C/cTpztaQO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50609A2DD;
	Mon, 21 Jan 2013 15:01:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD5C8A2DB; Mon, 21 Jan 2013
 15:01:04 -0500 (EST)
In-Reply-To: <7vobgifgz2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 21 Jan 2013 11:56:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49A724AC-6405-11E2-8517-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214157>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Ackermann <th.acker@arcor.de> writes:
>
>> Git changed its 'official' system name from 'GIT' to 'Git' in v1.6.5.3
>> (as can be seen in the corresponding release note where 'GIT' was 
>> changed to 'Git' in the header line).
>
> Didn't I already say that we never changed the name?  The same
> description seems to appear in [1/6] as well.

What we stopped doing was to use "poor man's small caps".  I do
agree the change in 1/6 to run s/GIT/Git/ is the right thing to do.
