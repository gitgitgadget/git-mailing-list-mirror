From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [git-am] Handle "git show" output correctly
Date: Wed, 12 Sep 2012 10:32:18 -0700
Message-ID: <7v392ndu59.fsf@alter.siamese.dyndns.org>
References: <vpqligfz1sa.fsf@bauges.imag.fr>
 <1347464989-17421-1-git-send-email-pjones@redhat.com>
 <vpqbohbz11h.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Jones <pjones@redhat.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 12 19:32:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBqne-0000Ao-7I
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 19:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760642Ab2ILRcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 13:32:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57815 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754954Ab2ILRcV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 13:32:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14EDC8708;
	Wed, 12 Sep 2012 13:32:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZLaC0kakoY1/d+R+JPlgISERlfg=; b=qeC6ke
	JMPxy9WMDxw66cBSep7s4bVNtHpbUJ/wUGe770FSPKBoG7l517hTL0CaXQfvy1x1
	ry0g4f4vSAJ1Idovm5QaZi5hJjY8nq+6V0+RAHbfqJ7XHb3tjnLKhXeRHX5QXAe0
	7DJv15Qcq5f6BqrB/v1KI9PWVrkJH3WB7h5zY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LMSourYdbb3K8IdtYTY6K0lIXFgtI369
	ujRVJ27vfgraz8ZerR9PtXtzboW0AVNY7vRMqMDHDnUCdQ7novS0nfB7dAsEkdYa
	3ljAV2A7GBYszBZaX/Ma+rttPgaVtiqU06ewhX1VMEcDsdO4GVZwphto3y6T4nQ+
	rPt7p3CuKOs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0228E8705;
	Wed, 12 Sep 2012 13:32:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60BF88703; Wed, 12 Sep 2012
 13:32:19 -0400 (EDT)
In-Reply-To: <vpqbohbz11h.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed, 12 Sep 2012 17:57:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD98E740-FCFF-11E1-BDE1-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205312>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Peter Jones <pjones@redhat.com> writes:
>
>> Subject: [PATCH] [git-am] Handle "git show" output correctly
>
> The convention in Git is "<subsystem>: <summary of change>" (i.e. no
> brackets around git-am, just am: and no capital for Handle).
>
> My other concerns (name of stgit, multi-lines subject lines and lack of
> documentation) still hold.

We do not want to apply "git show" output that munges the log
message, period.

If you want to give patches to somebody (or to yourself) via e-mail
or via sneaker-net, "git format-patch" is there for you.  Do not
butcher "am" to accept a format that is not meant for patch
transport in the first place.

If you want to screw something in to your shelf, you would use a
screw and a screwdriver.  You do not try to hammer a nail using your
screwdriver, find that the screwdriver is not very useful as a
hammer and modify the screwdriver to hit your nail.
