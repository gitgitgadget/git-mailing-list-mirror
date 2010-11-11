From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Time::HiRes is in core for Perl 5.8
Date: Thu, 11 Nov 2010 09:12:04 -0800
Message-ID: <7vwrojhjiz.fsf@alter.siamese.dyndns.org>
References: <20101109182754.15256.996.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 18:12:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGahI-0004vR-5p
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 18:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800Ab0KKRMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 12:12:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665Ab0KKRMM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 12:12:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BD02130FE;
	Thu, 11 Nov 2010 12:12:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VZeLdgmttHwUwGMJ3pEqDohSZuw=; b=cHo64f
	c+wsSYkaYiqI2Le0jq0Jjgy8OTZMSCIBVQR8nzCloKldWeo4WaHPcv/EAL8Ba+za
	JLY40SruSs38ICh7ZjqGYZZrOM6ELyG6zdDb9qzv+JGGZQmW/Jees1WRYx/M0Ff+
	V+8ftIMDM9N1bxjizCJw4chfZi3ihle4iGZdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q+igHp9a/GFApSwo7/9oEeuSbS9Fkrms
	lIVXkbBGYbYYV+E5GsYIMj0jPj0U6Wm1LexL8GRx/gt3TnJP+zVrwX5Wv/8Szkrv
	krwc5AW/nM11SS9DeWvtw2xCLWe9Lkytu7EgBjjnCkGKsYj/w8wBlo/NyP8KZnGv
	4VVHBcCyJy0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 93B3330FD;
	Thu, 11 Nov 2010 12:12:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B02AE30FA; Thu, 11 Nov 2010
 12:12:09 -0500 (EST)
In-Reply-To: <20101109182754.15256.996.stgit@localhost.localdomain> (Jakub
 Narebski's message of "Tue\, 09 Nov 2010 19\:27\:54 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D31582DC-EDB6-11DF-B423-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161271>

Jakub Narebski <jnareb@gmail.com> writes:

> Therefore there is no need to check if it is installed.  We can also
> import gettimeofday and tv_interval.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

I think "... and 'use 5.008' is at the begining of the script already, "
is missing before that "Therefore".  But otherwise it is a reasonable
thing to do.

Thanks.
