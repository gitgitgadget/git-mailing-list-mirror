From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fixup! pathspec: support :(glob) syntax
Date: Sun, 31 Mar 2013 19:51:16 -0700
Message-ID: <7vobdzm09n.fsf@alter.siamese.dyndns.org>
References: <eeccb0bb969ed30420685c210865da22d9c85407.1364665628.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Apr 01 04:51:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMUqZ-00008m-I1
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 04:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789Ab3DACvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 22:51:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64674 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754785Ab3DACvT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 22:51:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BFB1E874;
	Mon,  1 Apr 2013 02:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rQsrcbMSwRiKycefviir+dcUxo0=; b=YeYs48
	mksPinvPi02MlnxYz5WpHtJjjjqhWC3fbuhgHAU9AP+5BRJmMbxvoolchw+RZN7D
	6YJuX5UxyB9Ja+i75iA9je6fHpelPOkjEtT6TdBbi/RXAXyq+J8UyplsKtcrHL3e
	TsD11E0XjjGNmCLdqaUzZyLPkSnA74lX+fOXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NNyZMsT9Bj61a38i7IcnLexDtdqxW3zk
	GxG24d3+wJKEXqVHGn7TK8/kcJtv7TUNApmxhnZrO75Je4C0RXAYZuQHgpOnObG2
	Ed1b0DFQVeyqrz1+y0k1AL14zPwLoQBeoq0cz53IVrRn/0bXfC73qwzJEh830Gt2
	DRIu2IIgzCQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62141E870;
	Mon,  1 Apr 2013 02:51:18 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E88C1E86E; Mon,  1 Apr 2013
 02:51:17 +0000 (UTC)
In-Reply-To: <eeccb0bb969ed30420685c210865da22d9c85407.1364665628.git.john@keeping.me.uk>
 (John Keeping's message of "Sat, 30 Mar 2013 17:51:22 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06C0C3F2-9A77-11E2-B26A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219660>

John Keeping <john@keeping.me.uk> writes:

> A formatting fix for a patch currently cooking on nd/magic-pathspecs
> (cc3d8045ec1e2323c5654e2af834e887f26deb7e).
>
> ---
> The latest version of this wasn't posted to the list in full, so I'm not
> sure about the recommended way to provide feedback.  Hopefully this is
> easy to squash in.

This is one of the reasons why I do not like to directly pull from
contributors.

Checking by others from the sidelines what was requested to be
pulled like you did is greatly appreciated.

Thanks.
