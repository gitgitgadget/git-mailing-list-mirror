From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (bugfix)] gitweb: Add and use prep_attr helper
Date: Wed, 15 Sep 2010 13:53:36 -0700
Message-ID: <7vsk1a684v.fsf@alter.siamese.dyndns.org>
References: <201009152234.14253.jnareb@gmail.com>
 <AANLkTi=o2PFB=JkO5wYHCLAHCO=Ebe63mAc6WB8GfktH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 15 22:54:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvyzS-0007kh-S2
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 22:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab0IOUxu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Sep 2010 16:53:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231Ab0IOUxu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 16:53:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DA32D66DF;
	Wed, 15 Sep 2010 16:53:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lLGKDsS85Eo7
	czzC6vCLqxfRaT0=; b=l5jwSeunR6oFlV/R3TILaRsQ96mqRuuPqqbnAfHTbp0n
	3GXeySVd8OYb9W0DtH9iCIRkFcElumOgNEVn6RLvSStbe8qCp2tnG5r1a8pmSySl
	8uTSMlGcbsLJO090L6ZLYUDyecfrCAs6NmqhPy83Bnu+jqruegYL9PQzTHTC9PE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rXwwrG
	zSpCabnU3LVH9Je16NSYsZJPCyYKNe6LAB6gExAweqDIgy+6pNeBbwpeqa5UpcGx
	7Fy8zA+A1Kp9nepk5S/8VuolVxS2TEliBls3fiCCjFaMEN2eEvyXJkGoDOnStS0K
	pkpacH3GG33UpWRCgTolbRtO3xgO9ZsDfh6+w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 153B4D66DD;
	Wed, 15 Sep 2010 16:53:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 715D4D66DC; Wed, 15 Sep
 2010 16:53:38 -0400 (EDT)
In-Reply-To: <AANLkTi=o2PFB=JkO5wYHCLAHCO=Ebe63mAc6WB8GfktH@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed\, 15 Sep
 2010 20\:40\:41 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 53E307D2-C10B-11DF-9067-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156256>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> FWIW this looks good to me, but perhaps instead of using "?" for
> everything in ASCII from \0 to " " it would be better to display the
> human-readable escape sequence, like "\r" or "\b".
>
> Gitweb already does this...

Good point ;-).
