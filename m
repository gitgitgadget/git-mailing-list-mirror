From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Introduce branch.<name>.pushremote
Date: Fri, 08 Feb 2013 00:21:55 -0800
Message-ID: <7v1ucr43mk.fsf@alter.siamese.dyndns.org>
References: <1360307982-20027-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 09:22:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3jDz-0007AO-QT
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 09:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760041Ab3BHIV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 03:21:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36331 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759790Ab3BHIV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 03:21:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9FFF9DCB;
	Fri,  8 Feb 2013 03:21:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5TEGhdTRZ9NaajLiQUs1EnB+tbU=; b=qWo1q1
	S0wcdCvOjul9bHrrfWR/37ayllVVhRlFo6YwK+7VJvo3xi7Tit2n2JKNP6rvDhY/
	6AaZcEcQQOrSjuINU9WAKcHFTF9/pBYyn1ZLf2xjDRw8/xJfW5utMYX3UHZ6dDIa
	QfBNc6776ytnElFqIBXlf8d8qd5imG+ymh4yI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V/agkMQnbUBhMzY+lqgEbmOy8EDmjaNt
	MLiMOmIrOYIB9bR156H9/XNQY8PN4WC0EmbuMpH04mTnJ7BmGgcF66ROlB6YqLfB
	LiGnPXjBokr69RC9iYbf2Y7PA8SzoegwGVbg4Eh+/lx4jstHUwQvBTFkQz/2k0f/
	Fl/yJ4wMh5w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CECDA9DCA;
	Fri,  8 Feb 2013 03:21:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 518E89DC8; Fri,  8 Feb 2013
 03:21:57 -0500 (EST)
In-Reply-To: <1360307982-20027-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Fri, 8 Feb 2013 12:49:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9A771A42-71C8-11E2-B20D-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215767>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>  Comments are welcome.

As the first cut, I would have expected the series to start from
more general (not "only this branch"), with later follow-up to let
more specific configuration.

Also I'd prefer to see the "push" semantics (e.g. "what does
upstream mean in this new world order?") designed better first.
