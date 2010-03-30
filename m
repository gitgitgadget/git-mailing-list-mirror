From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add Tru64/OSF1 support in Makefile
Date: Tue, 30 Mar 2010 16:54:48 -0700
Message-ID: <7vfx3hqsaf.fsf@alter.siamese.dyndns.org>
References: <d2d39d861003301122p646efc1fj9d88af1893b84b3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Wed Mar 31 01:55:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwlHB-0001be-I1
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 01:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535Ab0C3XzC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 19:55:02 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62303 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074Ab0C3Xy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 19:54:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0998013F8;
	Tue, 30 Mar 2010 19:54:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J83AlHzDU5uDXu5oD19AB/vA3IA=; b=Dq0DFH
	1es8I+e3uNG/0JGwwP2eqYbpDSlKK0WfhDw3ENIduHpaio6DPUD0eqBsWr+X7vym
	C/Aav4jr0c35YUThW+zeRsMGBZIZI8ApgwKlX3K4VtlRAfv4EixFMT7J/HbMtS/s
	tKKZbbMtj2Schod041NTAI/nXe0yssCm/8Yzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jqX+BooBUtqBNCWhxAZVASNBQn/P/C8Q
	58aBz9l8ORgI0WGuCAfHoQ/PUdy8uLtdim+7B75Gai84fBKGlaqUGdTEemQQRTAH
	JugAyNr+oJwB31Qa+GWl/1q8Soco3hLkH9lnHviMTeRx5ROxKTw4SE/FTkzi3aUB
	7hXx/bmEz7M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD09E13F6;
	Tue, 30 Mar 2010 19:54:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9593D13F2; Tue, 30 Mar
 2010 19:54:49 -0400 (EDT)
In-Reply-To: <d2d39d861003301122p646efc1fj9d88af1893b84b3c@mail.gmail.com>
 (Tor Arntsen's message of "Tue\, 30 Mar 2010 20\:22\:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A256705E-3C57-11DF-BAA7-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143625>

Tor Arntsen <tor@spacetec.no> writes:

> Patch included below, as well as attached (in case of
> mailler-mangling). Please let me know if you feel there are any issues
> with it.

Thanks.

> From d4a5ba0727d7e3a4455320bad641cb34402d16fd Mon Sep 17 00:00:00 2001
> From: Tor Arntsen <tor@spacetec.no>
> Date: Tue, 30 Mar 2010 19:36:40 +0200
> Subject: [PATCH] Add Tru64/OSF1 support in Makefile
>
> Tested with V5.1

V5.1 "of Tru64/OSF1" I presume...

> +ifeq ($(uname_S),OSF1)
> +	# Tested with V5.1 w/libcurl and zlib-1.1.4-5 in /usr/local/
> +	CC = cc
> +	CFLAGS = -O2 -g3

Is this because the compiler there does not like -Wall?

Not a complaint; just a request for clarification.
