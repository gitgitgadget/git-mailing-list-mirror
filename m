From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Makefile: Include subdirectories in "make cover"
 reports
Date: Sun, 25 Jul 2010 22:44:39 -0700
Message-ID: <7vk4oiajaw.fsf@alter.siamese.dyndns.org>
References: <1280004663-4887-1-git-send-email-avarab@gmail.com>
 <1280004663-4887-3-git-send-email-avarab@gmail.com>
 <201007250037.57086.trast@student.ethz.ch>
 <AANLkTim8UIiplPxUdcEWnDpevOUUZARgObhIFCkfO3zl@mail.gmail.com>
 <20100724234105.GA14277@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 07:44:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdGUh-0003YC-Gy
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 07:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873Ab0GZFov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 01:44:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62761 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab0GZFou (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 01:44:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D4B4C709E;
	Mon, 26 Jul 2010 01:44:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=vO2OjXmOGfT1Cnt1G1PIQRZWRZI=; b=TuH6uolM4lN69jI/Gdrn+S3
	Zc1CjiG9zLPyKzDkxlkJ+85BrENA6aKEnCHyHESe4/cQ0ezW3udFR2r0NDTHBSgr
	FZLwlRfS912tGD+kY4W9Qwfy4xchwfvvJau6bB79kBeXIlSWWvmmTqdxkAueyUW9
	2qBpv+g0mqY1QpsQrO2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=LX9HuIgspC7lP1Y33jaEPVd7wg8DoET5/DnG5LHvBIYFpXiGW
	srXyfNw8EJZorNjQhgeLg3PKeBmb+UaeIMUQaQDYS0afm9XR1jaz0t+0fyRUj74K
	huKaUPjTgf2i1ZpjSz3CpcsZWokd8ZM4tw55ivTyfnbubNgNGuKRxrjW7g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 263D1C7098;
	Mon, 26 Jul 2010 01:44:46 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44FFEC7097; Mon, 26 Jul
 2010 01:44:41 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E5AA42D6-9878-11DF-BF93-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151808>

Jonathan Nieder <jrnieder@gmail.com> writes:

> You can find a list of directories where the Makefile was thinking about
> building things with "dirs := $(sort $(dir $(OBJECTS)))".  See
> dep_dirs for an example.

Neat-o ;-).
