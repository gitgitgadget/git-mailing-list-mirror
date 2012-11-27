From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Operations on unborn branch
Date: Tue, 27 Nov 2012 12:25:30 -0800
Message-ID: <7vd2yyn685.fsf@alter.siamese.dyndns.org>
References: <CANiSa6isDKAgxHWqh5XiQ-adT3-ASFtvAshp028DTcotjQxzmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 21:25:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdRj7-0001MS-63
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 21:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756474Ab2K0UZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 15:25:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41941 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756365Ab2K0UZf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 15:25:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDFD8A357;
	Tue, 27 Nov 2012 15:25:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qkd2pPceYaOO4odLNpjBVxk7Il0=; b=rvfY7U
	efqd/hIgQ77em+puryYsv0CX+v8EIC7MfoNhg/T4eJwtkFx1arDLA/QHjh77ipqS
	glWCzuwiKsHqklxy9YS2/3Svs0EV82MiAFnwEszxnThe5KBw/9nKgWrCtzM1a9Yb
	H2NlWu4LJV2AcE6fN5xYpnvTCU/AFXJfHsb+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ggePDVVvxhrim+RhVi+UymQ3IXQmv20O
	CthAeb3YSkUlEpnu8Pdaoo0PZixDlOIsT4dlQoTR1LJxhWAwVYAWZZldVj+jANXE
	0kr1CCoV17mGQZJRbBay87lIZ7Qb2fsqLRefSQ9A4vwRmIUGB0l9nr8fV1a1A0n7
	Wmoh9DBPWrQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB5E9A356;
	Tue, 27 Nov 2012 15:25:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D52BA354; Tue, 27 Nov 2012
 15:25:32 -0500 (EST)
In-Reply-To: <CANiSa6isDKAgxHWqh5XiQ-adT3-ASFtvAshp028DTcotjQxzmQ@mail.gmail.com> (Martin
 von Zweigbergk's message of "Tue, 27 Nov 2012 09:25:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97A7C054-38D0-11E2-ABC7-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210590>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> simplify a lot of things (maybe I'm biased because of the things I
> have happened to work on?)

Yes.  Do not waste time on it.
