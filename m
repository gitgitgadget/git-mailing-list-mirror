From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] branch: introduce --set-upstream-to
Date: Tue, 10 Jul 2012 13:49:54 -0700
Message-ID: <7vsjczgx3h.fsf@alter.siamese.dyndns.org>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
 <1341939181-8962-2-git-send-email-cmn@elego.de>
 <20120710191354.GE8439@burratino> <7v1ukjiehe.fsf@alter.siamese.dyndns.org>
 <20120710201105.GH8439@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 22:50:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SohNz-0006id-N2
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 22:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328Ab2GJUt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 16:49:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45605 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752316Ab2GJUt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 16:49:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06DE898D3;
	Tue, 10 Jul 2012 16:49:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xuNo9PvJULm0w5YNPRjRlrEZXUM=; b=gLS0vB
	2R08TTXwySIK4qRF0m+kFOEv3MKhQI/Ms4okPRu90aTdwQycNykEfZOhTb0Ps5SK
	5onlzJ1bzoera9jIxRqO60D5EebM7oOy42tXbdz4bXV0W+d9yalHaCsCkxaeOIHw
	GCBjf3N/WxJ6p5IgoZAVl76GCTDGmDz3WQyRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oWlOKYNYix/+VN5GcL1PE6VCT4amFKqN
	6+adjeWH+ReqP2+/QN8YKsQx4UaX+BYyOqJRiLwh5YumJhEUrqhXDAgPaTS5KNyj
	IKxs7SaYoJ97A0YHynQRqsX7Fs3kqZ6wlQOn3abmMqrh29YkzA4WAakhLL8gYatA
	QsCY+OCuaWc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F152398D1;
	Tue, 10 Jul 2012 16:49:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 86FD798CF; Tue, 10 Jul 2012
 16:49:55 -0400 (EDT)
In-Reply-To: <20120710201105.GH8439@burratino> (Jonathan Nieder's message of
 "Tue, 10 Jul 2012 15:11:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CDFB9040-CAD0-11E1-B3BF-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201278>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The immediate problem that seems to trip people up is that it is very
> tempting to run
>
> 	git branch --set-upstream junio/master

I think we have discussed this already a few days ago.  See my
comment in the earlier thread before this round.
