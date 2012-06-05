From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git bisect old/new
Date: Tue, 05 Jun 2012 10:23:22 -0700
Message-ID: <7vd35dpt9x.fsf@alter.siamese.dyndns.org>
References: <20120605184554.Horde.8ph4OHwdC4BPzjfCBNci47A@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lucien.Kong@ensimag.imag.fr,
	Valentin.Duperray@ensimag.imag.fr, Franck.Jonas@ensimag.imag.fr,
	Thomas.Nguy@ensimag.imag.fr,
	Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr,
	Matthieu.Moy@grenoble-inp.fr
To: duperrav@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Tue Jun 05 19:23:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbxTf-0005BQ-9N
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 19:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266Ab2FERX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 13:23:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755207Ab2FERX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 13:23:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 306509EEE;
	Tue,  5 Jun 2012 13:23:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0x/uxpIa8Fh4idCoUk7GQSPpibs=; b=YiBiqZ
	A31MSjrSD9zOOR4C0YX/c5q4EppVKiwEHLnPz/mQwKgcmFUKx3lo0K/pjQNW2eJS
	7J/q/fgv7Ze1IU3qkVqTUTMgsZyMWWARBrvnzlz8vZlq/HvxyCAePtr/F2tc4hn+
	cL+9VckyG5UZpN5OKBUa+U4qrycesdOK7lczk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mHOY+8eNJNMq7kggAYBP8QfdrJI/6yV4
	yd4EL9xI7vet9MdK5Xn+MbkbF6h5vJe1g/D9b2xIT7DdBvl0v+RyH1Bqwg8HXC8d
	tNoAhLXqqctLpw4Z4ztAaPsUXw0+XWwVVQ5YOXZ/joNhWTrb/nOR7yV1fTOGNlIn
	8WPRuM3//XQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C7299EED;
	Tue,  5 Jun 2012 13:23:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 873729EEC; Tue,  5 Jun 2012
 13:23:24 -0400 (EDT)
In-Reply-To: <20120605184554.Horde.8ph4OHwdC4BPzjfCBNci47A@webmail.minatec.grenoble-inp.fr> (duperrav@minatec.inpg.fr's message of "Tue, 05 Jun 2012 18:45:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 27EDB31C-AF33-11E1-B623-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199268>

duperrav@minatec.inpg.fr writes:

> We will work on that last solution but we wanted to ask for comments
> before coding too much for nothing.

After re-reading the thread that ends at Peff's

    http://thread.gmane.org/gmane.comp.version-control.git/182398/focus=183410

I have nothing to add to the conclusion of the thread.
