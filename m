From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: make --set-upstream saner without an explicit
 starting point
Date: Thu, 16 Aug 2012 14:58:55 -0700
Message-ID: <7vipcizeg0.fsf@alter.siamese.dyndns.org>
References: <1341480589-1890-1-git-send-email-cmn@elego.de>
 <7vd34arvhu.fsf@alter.siamese.dyndns.org>
 <7vtxxmqezp.fsf@alter.siamese.dyndns.org>
 <1341559103.10752.59.camel@flaca.cmartin.tk>
 <7vpq89ny8q.fsf@alter.siamese.dyndns.org>
 <1341561809.10752.61.camel@flaca.cmartin.tk>
 <7vpq7twr13.fsf@alter.siamese.dyndns.org>
 <1342625622.3852.5.camel@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Aug 16 23:59:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T285o-0001TN-43
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 23:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235Ab2HPV67 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Aug 2012 17:58:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49854 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661Ab2HPV66 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Aug 2012 17:58:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A43199B0B;
	Thu, 16 Aug 2012 17:58:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=d1KJO4AjHFeK
	aIg7+1Z62s7wchk=; b=yhi9muZBEG2EcntIGK82J68joGZiA23Z0aNPKdgsfOKH
	WsIBoojGViRTwxRO2qDXtCdGGpTjSPYhJGyFU+1mZHFzx2zgwx4sjA8+GEge8Dyj
	JpMin99I5jdk7B/rJA37Ts9glbpkS9X5GX74J+iUBEcusC+QqqTW4sD8tBhQ/gg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jO6dDE
	4/QeWX7TaJcmLzzzQkZVvvNNXUofigNVsXnlJClyvH6ecHMvh/Z3RUiGDevdaGbt
	ESD8YsuNvEJDvCW/YkcIfqelE+SjAUjyH0yiBaCljIdBsZpWAc+J8kTowq5eKULf
	qX5nnxQziJcW/su7RPOZenSAUJ3LLjfAXel+U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 924969B0A;
	Thu, 16 Aug 2012 17:58:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14BCD9B09; Thu, 16 Aug 2012
 17:58:56 -0400 (EDT)
In-Reply-To: <1342625622.3852.5.camel@centaur.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Wed, 18 Jul 2012 17:33:42
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93CF2D52-E7ED-11E1-AA0B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> On Tue, 2012-07-17 at 22:56 -0700, Junio C Hamano wrote:
>> Ping on a seemingly stalled discussion (no need to rush but just
>> checking).
>
> I've implemented the feedback, but been slacking on writing the tests
> which is what's stopped me from re-sending the series.

Another mild ping.
