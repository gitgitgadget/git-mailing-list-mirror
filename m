From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix git-apply with -p greater than 1
Date: Fri, 22 Oct 2010 11:41:53 -0700
Message-ID: <7v8w1qm5n2.fsf@alter.siamese.dyndns.org>
References: <1287699122-26702-1-git-send-email-fedux@lugmen.org.ar>
 <7viq0urfbz.fsf@alter.siamese.dyndns.org> <20101022053140.GB786@burratino>
 <4CC194DF.9040803@lugmen.org.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Fede <fedux@lugmen.org.ar>
X-From: git-owner@vger.kernel.org Fri Oct 22 20:42:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9MZB-0001pY-KC
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 20:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188Ab0JVSmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 14:42:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57617 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759057Ab0JVSmE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 14:42:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E3F89E1360;
	Fri, 22 Oct 2010 14:42:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SUhcqXiAo5NMDkz5EC8qP6gnNGA=; b=lfXF0S
	cpRU57F6aKRgaOwtVgtyfAYnhX6t4MsWSw4Hfq6mJyDapwq/qBO5sutZb+lBHRW3
	NlujnhUP6Iu5fz6pNgz3CytJkMs4WhcBDAKyve8eG0TmBxMR/C5cnk9PamYvj6W6
	KcWwPJkElytTDZUFYZNxWbC8gcjMpVjDSL5wc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pDHfK5QvZg7BcXiXYc6KyqQZ7Lu/RbN4
	shvwdRR2DzIP9WBZhvyews2dg0jjr7SlZkO4MPv+9IB7DHeWAeweNbgmmIPqvPsr
	fl7Zi8qH8AadHO2nqiWXnRycRrFmDpxw2ZP9WPqXeF9JoAdnx+PrsRxD19NSx2Ir
	4j9cRQfHmSo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A23EDE135D;
	Fri, 22 Oct 2010 14:42:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EE84E135A; Fri, 22 Oct
 2010 14:41:55 -0400 (EDT)
In-Reply-To: <4CC194DF.9040803@lugmen.org.ar> (Fede's message of "Fri\, 22
 Oct 2010 10\:42\:55 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0E576DCA-DE0C-11DF-8AAD-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159727>

Fede <fedux@lugmen.org.ar> writes:

> There is a similar issue with renames and I'm working on that.

I think I queued a fix-up in 'pu' on top of your patch last night.  Does
it work for you?
