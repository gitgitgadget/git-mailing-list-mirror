From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4 v2] Allow detached form (e.g. "-S foo" instead of
 "-Sfoo") for diff options
Date: Thu, 29 Jul 2010 09:54:25 -0700
Message-ID: <7vvd7yteim.fsf@alter.siamese.dyndns.org>
References: <vpqr5ioukca.fsf@bauges.imag.fr>
 <1280310062-16793-1-git-send-email-Matthieu.Moy@imag.fr>
 <20100729020031.GI29156@dert.cs.uchicago.edu>
 <vpqeiemoivf.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 29 18:54:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeWNT-0005HT-Qe
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 18:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758043Ab0G2Qyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 12:54:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44123 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761Ab0G2Qye (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 12:54:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 89206C9DF6;
	Thu, 29 Jul 2010 12:54:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gx8gsIz6ZEASZ69zfA0QZp2ZsXE=; b=HVxXK1
	BHAnTmnc2hRQjpiLMyy6hlhkUXdJBJzcVM9bWpSqzVYsIoSyQqYC/MRll6xCj9L3
	3wgFeJaNTenlG4xl642RyPcWJgXwxSbo3p4Y5Q2VsZ3DltaYOeben0qvqXTMEtSU
	UPIDYHx8Ig1hgq9uJ0MsZX6Hmy4ee8J2JE6sI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g07pBhJPeUZQ+HrllN1likGvrRKA8grK
	i9wP7QcXe8a5FoiEor+Ef0G8W3/btfc7dOuyCbyBC348V2qvnsjuCf7140/JyAqs
	MjiNV6g21VFP7aj/nCzBHryJBpLqKHGVEvyR25+T72pU6oJTCkHE4wN8yX8JJAxW
	Jrax7/k3FC0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 52AC2C9DF3;
	Thu, 29 Jul 2010 12:54:30 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9780EC9DF2; Thu, 29 Jul
 2010 12:54:26 -0400 (EDT)
In-Reply-To: <vpqeiemoivf.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Thu\, 29 Jul 2010 09\:19\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F48EFC54-9B31-11DF-BF07-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152188>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>> You left out the crucial "false"! :)
>
> Oups, right.
>
>> Below is an add-on patch to use a more readable style.
>
> I was mimicking the style right above, but that makes sense to
> clean-up while we're there, yes. I'll squash your change in the next
> serie.

Thanks both; I've also seen Jonathan's --stat-* rewrite and agree with
him.  Looking forward to see a re-roll.
