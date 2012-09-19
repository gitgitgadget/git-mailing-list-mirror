From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Add .editorconfig file to source repository to maintain a
 consistent coding style
Date: Wed, 19 Sep 2012 10:43:37 -0700
Message-ID: <7vmx0lhprq.fsf@alter.siamese.dyndns.org>
References: <64033A69-B5AA-461A-80B4-F143E4FC1614@hong.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hong Xu <dev@hong.me>
X-From: git-owner@vger.kernel.org Wed Sep 19 19:43:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEOJS-0008Pg-PZ
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 19:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756786Ab2ISRnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 13:43:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35138 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756672Ab2ISRnk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 13:43:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0002C9CFE;
	Wed, 19 Sep 2012 13:43:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B0yYFFsO6+OfKaMiOb/pz9/tz9g=; b=BAF14w
	MJzPyT5Wdf3JJBxk1rjFtWMvsx9/r2XZd1z1NQB91qZQzXdnTN54F1qkH6s8RUQz
	nFoG4ZpbNm9diq8qBygH8I9YYcd9N47dpjWs3yWbbLzcPL5axm17e8cgw6EA2tlD
	v8DFJmyI8/CMv+xR9IRwcBkH4dvBDUXTLQLNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UBhwkliA0AnYFZ2QLuvKrPe3ffIsAkUv
	ii2JacNzXbMuiJ59T3AXHLF6LwB9QXvebrFIQBs33e5Z7zrnZzE8cM/b/cKgFZoZ
	A6yUAWPLbLjnd83f1WHbZNdmDP4emn/vhif+QwuKYCxfaVS1ntn2pFHfczKQLJDV
	4XtZfFOM0SI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1C849CFC;
	Wed, 19 Sep 2012 13:43:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C2EC9CFB; Wed, 19 Sep 2012
 13:43:39 -0400 (EDT)
In-Reply-To: <64033A69-B5AA-461A-80B4-F143E4FC1614@hong.me> (Hong Xu's
 message of "Wed, 19 Sep 2012 00:31:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BCA2CCA-0281-11E2-9F86-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205958>

Hong Xu <dev@hong.me> writes:

> EditorConfig has been used in many large and famous projects, such
> as Ruby, jQuery, etc.

I see jQuery swallowed it and has been using it for 6 months, but
citing Ruby as an example makes you look somewhat dishonest.  As far
as I can see, they just added one a few days ago, which means they
haven't had a chance to evaluate how it affects their developer's
workflow and possibly realize that it is bad for their project and
revert it, or find it very useful and give a raving blog about it.

Throwing [Ruby EditorConfig] at my search engine gives mostly what
you wrote and not much else, so it does not help me to judge the
merit of using it objectively, either.

I dunno.
