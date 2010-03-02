From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Better cooperation between checkouts and stashing
Date: Tue, 02 Mar 2010 10:05:46 -0800
Message-ID: <7v1vg261l1.fsf@alter.siamese.dyndns.org>
References: <4B67227A.7030908@web.de>
 <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> <4B898F97.90706@web.de>
 <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> <4B8B9BF1.10408@web.de>
 <7v1vg4ufas.fsf@alter.siamese.dyndns.org>
 <4b8c0420.5544f10a.2eb2.ffffb4c4@mx.google.com> <4B8CDE20.8030600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 02 19:06:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmWTq-00088p-4g
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 19:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194Ab0CBSF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 13:05:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023Ab0CBSF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 13:05:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A9559E0C4;
	Tue,  2 Mar 2010 13:05:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BhodWkerQAv5UEYy9LMyCNqzEAY=; b=jaCSLq
	sL41sQ/u0BBJAy4LQNfrHuH2/NyBGa3FVYTpFQRkf769ID1EbgxXN2KEF4mGb8IS
	KNRsBr1WQSi6saBv7BeOD3iQdVxnJMyAtddZDc6nVb9mDUqzcr6q+3zw5BIYMWnx
	3B7V0x9zEZboBEhhX+8YTxx9zbzvxCKDpZBmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b3EZTW5ByLI3HT3DJSNcFwWVmPOy3FTz
	YIq/Zi2duKa4EiIzSvL/qqNpHrnKFR9huCMzTJcFjjKJ8OgW4nfkfhGg/OJrii+W
	BO3zAjbDNiML8RCz0ivjYpggnFxttGH4FCp6I3eRxo5ZNA1tSQscZy9XOngZpkHv
	p/nwtWFX7H4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 062179E0C0;
	Tue,  2 Mar 2010 13:05:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40F589E0B4; Tue,  2 Mar
 2010 13:05:48 -0500 (EST)
In-Reply-To: <4B8CDE20.8030600@web.de> (Markus Elfring's message of "Tue\, 02
 Mar 2010 10\:45\:04 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3D1548A6-2626-11DF-A4BD-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141408>

Markus Elfring <Markus.Elfring@web.de> writes:

>> You've still got the wrong problem in your head (though you're
>> solving a more useful issue).
>
> Which idea would be better?

They are different problems, and I don't think there is no "better"
between them.  Is a squirrel 48% juicier than an orange?
