From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] checkout: accord documentation to what git does
Date: Fri, 09 Jul 2010 17:36:43 -0700
Message-ID: <7v4og8i350.fsf@alter.siamese.dyndns.org>
References: <7vd3uystsh.fsf@alter.siamese.dyndns.org>
 <33e9dcc468b1e1ed18a180046f5d4c135921c7ab.1278707023.git.nicolas.s.dev@gmx.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Wincent Colaiuta <win@wincent.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sat Jul 10 02:37:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXO46-00067A-HN
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 02:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756289Ab0GJAhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 20:37:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545Ab0GJAhB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 20:37:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F9A6C3BD7;
	Fri,  9 Jul 2010 20:36:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=pRBNNU21XT4t6+FISIyJgrV3ChU=; b=GOPz/SzGNCdpabeR5gdl7Mb
	kM0nN0Zh4K5mQQJfX8LttQtITimQNYKqZsge1YHhxAMMRfW5WJwvhw5zoTEFs8R8
	8h95pRb6RjUxKB3u+A+XSVrR/Xi1HXqqDPp4qDCj5U6YFeEPZRXeVDLxfuakdYkO
	uy53Pb4P828s9SpRApJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=USo104YaozCvK36ouoDKFLFS3xIHmxwQQRP6yi43bTTa+A/hq
	CAkpGhEJWeB7qt7gBB8AUapQKXglNjuXw4bSZrnTqhpCpOJ7h97cuopxWAeSOLBQ
	Z/9kI74gJf7nxUWV52f8S0NKuneTdV3EAStZRWDInJPciBSN8dAV9zME/4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C260C3BD6;
	Fri,  9 Jul 2010 20:36:55 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D08EC3BD4; Fri,  9 Jul
 2010 20:36:50 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3D9C07A6-8BBB-11DF-B7E1-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150700>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> Doh! You said in this commit that
>
> 	"If you do not see something wrong with this output, your brain has already
> 	been rotten with use of git for too long a time."
>
> but I claim the right to be rotten in much more ways. :-)

Heh; thanks.
