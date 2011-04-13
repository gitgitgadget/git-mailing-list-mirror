From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] whatchanged: always show the header
Date: Wed, 13 Apr 2011 08:58:58 -0700
Message-ID: <7vlizem9bx.fsf@alter.siamese.dyndns.org>
References: <20110413092620.GA3649@bee.lab.cmartin.tk>
 <1302696644-21809-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Apr 13 17:59:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA2Tl-0006Lf-6O
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 17:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496Ab1DMP7N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2011 11:59:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932476Ab1DMP7J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2011 11:59:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2BC5B3EAB;
	Wed, 13 Apr 2011 12:01:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ehAnA78cgiJJ
	GEq/GlIEeYPz7ag=; b=gOFnwarBW8+WyvXj8Yh7qzOxPDvXoFxB6rE4vFdecVLT
	jtNKUFwXB18Tnd3jJ0+GOXH1WG0I6MOH+a8mzplBEE6NU4u2QSDvUOpBzqqi38EH
	yqrE45T1UyVbu+U22zcv3a9LYGVx3lRTgU1j656MXWva3wrtdIlem4CkaMtCrEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Tq9kfn
	qvEtzsZptLJMZJa+4PpYg2XXMzeIpTI9gr/pVyOKhhaB6tWUWkcNrKAtyMT+YhvG
	3rIjzIVCuE5X1cVuUUFgsSaQl479xf8+AwnvaUHKzBMsnSuuCuVYHDieZ2CjM6R/
	/kV8TpLqfOFS8fgMfJcOlXy+99NpD65sOyH4U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0942E3EAA;
	Wed, 13 Apr 2011 12:01:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 185863EA6; Wed, 13 Apr 2011
 12:00:57 -0400 (EDT)
In-Reply-To: <1302696644-21809-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Wed, 13 Apr 2011 14:10:44
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A31714E-65E7-11E0-BD42-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171463>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Set the always_show_header option to fix this.

I don't think that is correct.  The command should skip empty commits, =
no?

I'll take a look at this later when I have time.  I plan to tag -rc2
today.
