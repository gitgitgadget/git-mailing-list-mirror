From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: can specify shas of commits to ignore on command 
 line
Date: Tue, 04 May 2010 16:01:31 -0700
Message-ID: <7vtyqnl19w.fsf@alter.siamese.dyndns.org>
References: <1272939687-17686-1-git-send-email-dgreid@gmail.com>
 <4BE0918C.9090204@lsrfire.ath.cx>
 <j2sfd211a421005041446ub9c2247ai484c2473df856b31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Dylan Reid <dgreid@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 01:01:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9R7a-0001S0-Pc
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 01:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757843Ab0EDXBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 19:01:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62410 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757617Ab0EDXBk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 19:01:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C6469B0DCF;
	Tue,  4 May 2010 19:01:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8OU0EwJQQViXRPNI5Ejk0kEjz1s=; b=pibEmk
	c8MsiGQq4l999b6K6/VqyJbhZZmd9P5dR/GETWsLPEOpJGyWG979IZV5lYP09m9v
	35Eap3EwWxG0QqcSVHaZ7bx11WJsQ/fT10LctTYODhrFP0MQIGjF4eQG9N1CeXQe
	gLsHXUof4dRCrQCI6+4Q1NX9ENJQu/JwvhcYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VL2rhduHmsSCpDn1cPj8m8jGf1sDrTvF
	RdIUJ7T40/TonUXAKO6PmttTAq+l94cY55GDZn6BQhUuJ9stDfeQQJlKX8baLAlT
	OwjclgU2xm9I39UHvonrZtiZP7WU2MVMDT//4nzs94D3eQujdM29qHxmVXvVvlyz
	8oz94Pzp6L4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 917A2B0DCD;
	Tue,  4 May 2010 19:01:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCC35B0DC8; Tue,  4 May
 2010 19:01:32 -0400 (EDT)
In-Reply-To: <j2sfd211a421005041446ub9c2247ai484c2473df856b31@mail.gmail.com>
 (Dylan Reid's message of "Tue\, 4 May 2010 17\:46\:59 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FDB44D10-57D0-11DF-9705-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146355>

Dylan Reid <dgreid@gmail.com> writes:

> A null commit could work.  I think the behavior should be to not
> ignore the commit. Meaning if you specify a commit that introduced a
> line of code that line of code will still be blamed on the ignored
> commit.  Does That sound logical or is it too confusing?

I am already confused.  If the command must return C when you say "ignore
C" and C introduced a line you are interested in, then what is the point
of specifying commits to be ignored?
