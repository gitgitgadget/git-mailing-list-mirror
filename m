From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Introduction and Wikipedia and Git Blame
Date: Fri, 16 Oct 2009 16:25:38 -0700
Message-ID: <7v3a5irkel.fsf@alter.siamese.dyndns.org>
References: <ee9cc730910160207x49feb40ej692188abb0a57473@mail.gmail.com>
 <alpine.DEB.1.00.0910161321550.4985@pacific.mpi-cbg.de>
 <ee9cc730910160443k7e5f718bs964923a796cf38d1@mail.gmail.com>
 <alpine.DEB.1.00.0910161548550.4985@pacific.mpi-cbg.de>
 <7vbpk7w9qx.fsf@alter.siamese.dyndns.org>
 <ee9cc730910161100r71818303v343f555151db4dcc@mail.gmail.com>
 <7v7huvuptn.fsf@alter.siamese.dyndns.org>
 <7vpr8nt894.fsf@alter.siamese.dyndns.org>
 <ee9cc730910161419x608f5972x705ce8088d72c94a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "jamesmikedupont\@googlemail.com" <jamesmikedupont@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 01:25:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MywBJ-0007CM-2N
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 01:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbZJPXZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 19:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbZJPXZr
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 19:25:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65440 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbZJPXZq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 19:25:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ACD845B4C4;
	Fri, 16 Oct 2009 19:25:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cmORMIDyKn58dWqviqA/6NIg9ic=; b=DMJA+M
	AQv15+Akzfbw7yPJHqFaTCglUARiUbS9H5pGBHc1cQWnNZwzTJaYNZxSKiQVf6c7
	Lf4rmBFdA83pF+B9mJgB6+H6wPd0xUa3+ja1sOcU3SZEhB82nGxrprkvqvGZ/4La
	072b7AAn4aP5DuCcKlwBns0iIDvyNzGmKvbK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I5G3jHG+uDAR8kmOaltsKUyb1OwNON01
	lJZdunwHHT1d7Uk0/ip2k0NqOZptYhxShS7KjKA8tG6Mp9PVJyYc3CZCLHQNqnbQ
	5oAC93je+H7qWEO0PQ6hTlvbl1jLpawCccU/G07SSmU+zd7YuLlwEpG8pVdXd3Mp
	MygVEYUZVF8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C0DB5B4C2;
	Fri, 16 Oct 2009 19:25:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E0AA5B4C1; Fri, 16 Oct
 2009 19:25:40 -0400 (EDT)
In-Reply-To: <ee9cc730910161419x608f5972x705ce8088d72c94a@mail.gmail.com>
 (jamesmikedupont@googlemail.com's message of "Fri\, 16 Oct 2009 23\:19\:03
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3AB518F2-BAAB-11DE-A84F-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130537>

"jamesmikedupont@googlemail.com" <jamesmikedupont@googlemail.com> writes:

> What do you think of my idea to create blames along a specific user
> defined byte positions ?

Overly complicated and not enough time for _review_.  If you are blaming
one-byte (or one-char) per line, wouldn't it be enough to consider the
line number in the output as byte (or char) position when reconstituting
the original text?
