From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] add: warn when -u or -A is used without filepattern
Date: Thu, 14 Feb 2013 15:55:19 -0800
Message-ID: <7vmwv6wivs.fsf@alter.siamese.dyndns.org>
References: <vpqobg966cv.fsf@grenoble-inp.fr>
 <1359364593-10933-1-git-send-email-Matthieu.Moy@imag.fr>
 <51067353.2090006@drmicha.warpmail.net>
 <7v4ni1xjuc.fsf@alter.siamese.dyndns.org>
 <7vr4kiwjqp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Feb 15 00:55:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U68ea-00012p-U4
	for gcvg-git-2@plane.gmane.org; Fri, 15 Feb 2013 00:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935122Ab3BNXzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 18:55:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45535 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932175Ab3BNXzY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 18:55:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A1B7B02E;
	Thu, 14 Feb 2013 18:55:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9zzlpsdMYwWlxGAddVkOWjJCv9Q=; b=bIduF0
	hQdH0da09+fwdkJuKx3hYfl2+qgGNA0cL/TsAcUwk58rG8/jZE/G+30vbHS7YxG7
	2wXCusNXmu5QZOGvTcz7hyW/CsSsdqWxzA0xGg5uV16GrfNLEViFJkCe4wajB1/z
	ih900Fn8Oc5eaT/SKlxo9g7M6f4rDmaYbdkCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Az7La3ykx4yi9PKBBmi6uxq6GngSMNtN
	zOOsByMJH04madx/uAl4qcS0P8D29k3VI/d1cl9pXLaltcj+oU2dL7shaQRHNwYp
	lGfe8TmAQUH+2DKgE9MJmzHgS0xv3INDVz+WlD9oGTL0R0YkRakyhC7YL65TQpVM
	opc6qNbdfCQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E375B02B;
	Thu, 14 Feb 2013 18:55:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1766B02A; Thu, 14 Feb 2013
 18:55:20 -0500 (EST)
In-Reply-To: <7vr4kiwjqp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 14 Feb 2013 15:36:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FDB1E202-7701-11E2-BC97-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216339>

Junio C Hamano <gitster@pobox.com> writes:

>     warning: The behavior of 'git add --update (or -u)' with no path argument from a
>     subdirectory of the tree will change in Git 2.0 and should not be used anymore.
>
> There is a logic gap between "will change" and "should not be used"
> that is not filled like the text in the manual page does.

I guess it is not so bad after all, if you read the entire message,
not just the first two lines.
