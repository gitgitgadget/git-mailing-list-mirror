From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Thu, 16 May 2013 09:19:43 -0700
Message-ID: <7vwqqy7v8g.fsf@alter.siamese.dyndns.org>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
	<7v7gj77nt9.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HDp+ojGK0UhKHF=1iDu5_E9Z0VrK-JtMked1mtH_2gQ@mail.gmail.com>
	<CAMP44s3J8YpULYenDoYhyRJXSXL3b8-vpMbW2c4LcjK43Xidng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 18:20:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud0uM-0000rj-Q2
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 18:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750Ab3EPQTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 12:19:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753472Ab3EPQTp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 12:19:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 796AD1F3B6;
	Thu, 16 May 2013 16:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vmOvrJ1C2LLRhzuzXbarW9CYTy0=; b=MfFFK+
	qmXn1HTjww0mea68CLTZ3NtF1uyA+SXAXJ79lLok10WOkg7fS0NZ2h+l60GNZU2F
	N/R18dUpGRcDhA5JCey8jmnnblf5AbYHWv4PoRdc9hSAkzDaOFZOkHgWeq7ZLKQa
	WM/UG1TKADSMPwmPSWHFeJOyK9WCWIWnc9xa8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q4oFVpeb70GKcucvaGEvqAK3PNCT/3ur
	0lXvSaPhEbpCfSrNOwaUr42iD/k/khm7GxiSDE/gV4yHZ4fa0+tXDOk1yVZ2xyP1
	eM4iOo5hEwVNKyOD6ajFiQ2Fa7NOaNK0mtNjfjsAaAWU/tX06SOZRdYSIIwhR3dP
	DBjMcd2v/Ps=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 702C11F3B5;
	Thu, 16 May 2013 16:19:45 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E65C41F3B1;
	Thu, 16 May 2013 16:19:44 +0000 (UTC)
In-Reply-To: <CAMP44s3J8YpULYenDoYhyRJXSXL3b8-vpMbW2c4LcjK43Xidng@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 16 May 2013 04:23:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6BC32236-BE44-11E2-8485-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224591>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I find it extremely annoying that an obviously correct patch is not
> merged...

A patch that receives "this breaks style" comments and its author
stubbornly refusing to fix what others pointed out, especially when
the patch itself _is_ about style, cannot be "an obviously correct"
patch, can it?
