From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/14] misc test-suite patches
Date: Tue, 14 Dec 2010 11:44:37 -0800
Message-ID: <7v4oagt9zu.fsf@alter.siamese.dyndns.org>
References: <4D07B4C1.2050007@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 14 20:48:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSarU-0003Mi-BH
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 20:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759030Ab0LNToq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 14:44:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42601 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758723Ab0LNToo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 14:44:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 42F0530D2;
	Tue, 14 Dec 2010 14:45:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=h2DaAkVRCWTUBt58gFGFUl+Eldw=; b=F68GM7LQGd3PyXpp9ng01K4
	xJa1/9la4JukQzJsQQGy18UkTLhFpEjorXc5gTG+8MyL6QcwllRxTCEGU5ACpeX4
	Gvn+6L+uRfmUj3JvwUBceY/xlOu3mSzBzpvotJ5qfTxahCBUrY8R2/E+B1R4611S
	0Y03nwF1o3e/9lubqGDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=GN3jDlPMcIl1qfJRCJIYtaeVux9zf+tHuI0cbXczIujD3zDZx
	wYcfSfDEDowPbGDSSEeN48b2tuBPsWcL7/ciMoWbPXYwe/ddvKk1SIJAkAwB+LUq
	vLrpR9zX9mND1eI/GiwNi9v7tbMZQsTDj5LnB+V+9lf/8IiiouJMPhWO7o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 21B7730D1;
	Tue, 14 Dec 2010 14:45:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4AEB930CC; Tue, 14 Dec 2010
 14:45:04 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A72A59B8-07BA-11E0-8054-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163683>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> I've had many of these test-suite related patches lying around for
> a while, so I'm passing these along now in the hope I can remove
> some old branches...

Thanks.

> [PATCH 08/14] help.c: Fix detection of custom merge strategy on cygwin
> [PATCH 09/14] t1301-*.sh: Fix the 'forced modes' test on cygwin

I sense that there is something fundamentally wrong with the tricky l/stat
emulation set-up code there, but I lack an expertise to judge if these two
patches is going in the right direction.  Help from people savvier on
Windows issues than I is very much appreciated.
