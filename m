From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/5] gitweb: add project_filter to limit project list
 to a subdirectory
Date: Mon, 30 Jan 2012 13:08:56 -0800
Message-ID: <7vpqe0aoev.fsf@alter.siamese.dyndns.org>
References: <20120128165606.GA6770@server.brlink.eu>
 <20120130200355.GA2584@server.brlink.eu>
 <7v39axaq0v.fsf@alter.siamese.dyndns.org>
 <201201302148.03909.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Bernhard R. Link" <brl@mail.brlink.eu>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 22:09:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RryTH-0006oS-Ri
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 22:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641Ab2A3VI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 16:08:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47060 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752772Ab2A3VI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 16:08:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81E797591;
	Mon, 30 Jan 2012 16:08:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qENOsY2JAPVTezXWYc5BwEAOyjI=; b=x10w9z
	0PdjCZC7vUsshi69E9HzZELzt2FCa7EFm5EubHF+Z4RtfpAWz1slWmi57SL4BE84
	MtwnvXrUvDM5gsTa/6j9vUazValWQDHvDRL85YyUfuUOM2rKcLoQoTXAFQbHZdkk
	n1FjOYiHufcqfUGzdxWbpoCf0YXtTVclU1+cQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WqNZuY2AH7bu9L0sLf5y2cBsDMki9Ol5
	xSUk8VwuZqeJNjJUoMtkl0mqoIFniEnPCs91DEoS9KzPyLvz9PZflAPKUYWHURMj
	a3fxcXopHTmtp7OrkPJaOCojqtb0pjEYYR7H+r3h5+pVspqc/Q5GIXGdDw7zmUGP
	MxTuVb3W/y0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 791397590;
	Mon, 30 Jan 2012 16:08:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECD2A758F; Mon, 30 Jan 2012
 16:08:57 -0500 (EST)
In-Reply-To: <201201302148.03909.jnareb@gmail.com> (Jakub Narebski's message
 of "Mon, 30 Jan 2012 21:48:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9FFEFEC6-4B86-11E1-AE0D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189425>

Jakub Narebski <jnareb@gmail.com> writes:

> On Mon, 30 Jan 2012, Junio C Hamano wrote:
>> "Bernhard R. Link" <brl@mail.brlink.eu> writes:
>> 
>> > I'll resend the series as replies to this mail.
>> 
>> Thanks; I'll queue them in 'pu' for now (if Jakub wants to Ack the pieces,
>> I'll amend them).
>
> You can add Ack from me for the whole series.

Ok, amended and queued (but not pushed out yet).
