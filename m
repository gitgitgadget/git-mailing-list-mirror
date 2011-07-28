From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] check for unpushed remotes in submodules
Date: Thu, 28 Jul 2011 12:58:27 -0700
Message-ID: <7v39hqmb30.fsf@alter.siamese.dyndns.org>
References: <1311790250-32454-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 21:58:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmWj7-0000iB-2k
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 21:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755634Ab1G1T6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 15:58:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58807 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755455Ab1G1T6a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 15:58:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1AB85397;
	Thu, 28 Jul 2011 15:58:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5pWJN1wDId3/9Oi04q+1avNikRs=; b=pL5AHI
	saILTGmctcmat2oq6XHh6F+railfSJt7BO1rd2v3UZYMIwIwNgFkCvP16zpvKpm8
	U4h+FvPqvMxcJbsHUdwGY6ljwwWXhPJ5KYrGrRG6hq2EufWsG+Q4kq6xKdISq9jY
	TT57zMlCeDAPvn3e2wwLWOLB3JWFCQo5WDa6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OdzdMMI+6wxyCiNzHDCMHED6bkJIoIOy
	kLrbsRSaebH3gMazs8DANYRLi8+KRX8tTzOm9f2XqTW3TXi1Bn0yaMZXex865CiO
	M1/zh7lmjUthk+SMpuQpbhydzCmj1X1iTI/CgcTPel7kzsjCBJMweC4kv/FA6Y/K
	oD2UPXgQpEg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C905F5396;
	Thu, 28 Jul 2011 15:58:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BF8E5395; Thu, 28 Jul 2011
 15:58:29 -0400 (EDT)
In-Reply-To: <1311790250-32454-1-git-send-email-iveqy@iveqy.com> (Fredrik
 Gustafsson's message of "Wed, 27 Jul 2011 20:10:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F6B94C28-B953-11E0-A91C-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178110>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> Regarding the discussion of superprojects with submodules that have no
> remote tracking branches: A push will still be denied.

I have marked one part of the data synchronized across machines as
"private" submodule (which contains my gpg keychains, encrypted password
files, personaly memos, etc.) and push only the outer "shell" superproject
(which has tools that I use everywhere to go to $HOME/bin among other
things) to certain machines without the private parts, and the
superproject is designed to work without a checkout (nor clone) of a
submodule.

With this patch series, it sounds like I cannot use this repository
structure anymore, which is sad.
