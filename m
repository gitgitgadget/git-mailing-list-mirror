From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git 1.7.3.1 cannot be built on FreeBSD 4 with gcc 2.95
Date: Mon, 11 Oct 2010 20:59:07 -0700
Message-ID: <7vwrponjsk.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=z1vqpimP_5kS_AxcVypM5Dx75p--XG8E3uSx=@mail.gmail.com>
 <AANLkTi=3BG0PScgp5X+y2-U1FqC6aoOrw_pyLU7cEzME@mail.gmail.com>
 <AANLkTindQ8Nty=eUGNgREish0K-=dGgg9qXjWbefKb3M@mail.gmail.com>
 <7vfwwetih8.fsf@alter.siamese.dyndns.org>
 <AANLkTi=nCOeD3u0fst11xujFHuhhj0OU1g_dZ8gTOAMT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Akira Kitada <akitada@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 05:59:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5W1L-0003XW-2m
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 05:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756571Ab0JLD7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 23:59:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35029 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755697Ab0JLD7R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 23:59:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 53513DDEE5;
	Mon, 11 Oct 2010 23:59:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w+cKZlAuw1m1ttQEmYgnvwCARsE=; b=MC8hsW
	OcAO+amHaIk9O8vKn6/dLiXNJofC5lG3yFnG8ED4C/Gud2PrJH/crkBa4MSV6pF7
	1kE1BFkOSeI+f26uyNe1lLxk4184z69zJU2W888OWtjDg7FI5Yo+4sPdDXLyeLyT
	UU07XhJoCJp51MS8JfjAU+xXfHzZiB+D9hisg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sLJVF4vX8hedQPyfI8KS2+esVluG/zX6
	xl2aqb4+4oZeBnZvTTSOcEai/OBr0Z/5+glI8+7+V4SLGiQtd5WcfHPcJuzVsH1w
	HSuMv2gWWUuTzvpCMTqseV9ywdFe48bf3aMEuBU1aG168vuWJUWHlJnjbXfNoRr6
	145tHUwYNZE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 21124DDEE4;
	Mon, 11 Oct 2010 23:59:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3157BDDEE2; Mon, 11 Oct
 2010 23:59:09 -0400 (EDT)
In-Reply-To: <AANLkTi=nCOeD3u0fst11xujFHuhhj0OU1g_dZ8gTOAMT@mail.gmail.com>
 (Akira Kitada's message of "Mon\, 11 Oct 2010 10\:31\:31 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 13B8CE94-D5B5-11DF-AFC0-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158822>

Akira Kitada <akitada@gmail.com> writes:

>> One difference is that I never use ./configure, as that is somewhat
>> foreign afterthought in our build infrastructure, though.
>
> Could you run './configure && gmake' and see if it builds on your environment?

No, thanks.  I do not think I have autoconf set up on that box.  Perhaps
sometime later, but not tonight.
