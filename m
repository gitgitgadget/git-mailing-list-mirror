From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (BUGFIX)] gitweb: Handle invalid regexp in regexp search
Date: Tue, 28 Feb 2012 11:45:11 -0800
Message-ID: <7vwr76yc6w.fsf@alter.siamese.dyndns.org>
References: <20120228183919.26435.86795.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 20:45:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2SzK-000203-J2
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 20:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757314Ab2B1TpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 14:45:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36982 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755041Ab2B1TpN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 14:45:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 057016842;
	Tue, 28 Feb 2012 14:45:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qtd3AOvl4RTf2SfJYkrEkpqYliE=; b=vUjMYk
	lT3BcbJEi6aGK7LdX6U1ntr90/TAdxcGnRp8x3NxPKLMHpXzqVs7adN6VbO5UiY7
	q+h7x5e9QIiYTt+R6X05qABVkDBLyoHrSEOjM7Ho1DKJ1rJKh1/qraD9e/hdufLw
	f7HXtBi4KLV6xt98aZZFP16J//avtUMizpXB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M6zBWZTNuppcwG/KQQQmbvHqAaSP0ZiQ
	g4h5svzQwl8dG8qFoPU1y3UAwZ/LhZEu2y4Ia0vYHNF+WGeK8vp0HG6MyKctdzxs
	/hQgRx4nJsM0fzcy9A1DfmIP/i/S7TaSrGj4UqmpOIEhSo6/9ielKQy0FTZiQeXA
	ExjIviXBOj0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F12BB6838;
	Tue, 28 Feb 2012 14:45:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A7856837; Tue, 28 Feb 2012
 14:45:12 -0500 (EST)
In-Reply-To: <20120228183919.26435.86795.stgit@localhost.localdomain> (Jakub
 Narebski's message of "Tue, 28 Feb 2012 19:41:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA9A2056-6244-11E1-BDB8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191776>

Jakub Narebski <jnareb@gmail.com> writes:

> When using regexp search ('sr' parameter / $search_use_regexp variable
> is true), check first that regexp is valid.

Thanks.

How old is this bug?  Should it go to older maitenance tracks like 1.7.6?
