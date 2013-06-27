From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 5/5] git-remote-mediawiki: Add preview subcommand into git mw.
Date: Thu, 27 Jun 2013 08:22:42 -0700
Message-ID: <7v4ncjvarh.fsf@alter.siamese.dyndns.org>
References: <1372273970-9084-1-git-send-email-benoit.person@ensimag.fr>
	<1372273970-9084-6-git-send-email-benoit.person@ensimag.fr>
	<vpq8v1w39sg.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: benoit.person@ensimag.fr, git@vger.kernel.org,
	Celestin Matte <celestin.matte@ensimag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 27 17:22:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsE2E-0001a2-V5
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 17:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382Ab3F0PWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 11:22:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32793 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753195Ab3F0PWy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 11:22:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31174296F7;
	Thu, 27 Jun 2013 15:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yAaveJsPqSmLIEwpCErOLTNg1Ss=; b=Vwdvka
	leBzZUxuX3YYndhAdq528stdhR6WnooLrTTNWgtAs0DQ0das0qAGh4zb5NUPAEQq
	Y/Af2M91Mg8zw0gLo/5ls4IdtNxsNWIpv8Bw/RsIPcLPzNzl29rsEs1LHlsyPROS
	k1UFopxGhLbUqu1jWXVAvBXSWvTdBd/22L+FM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W00qoqk1QN4M0Ld1KI9JoZKh8qmGW4hz
	VW/aXd/cT+eaN+r21v8BMeNciyi7hXIr/YCfEm0h3s1fRgNTHjH1z79um6odPjMO
	Z6qzRYMfdeDNRabb6S2eY7SXTETTkCdVmz8RmCGRpKgB2hriS4sjt9aDSY6PsYuM
	hb/vVgx/sVQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 245DF296F6;
	Thu, 27 Jun 2013 15:22:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01038296F0;
	Thu, 27 Jun 2013 15:22:52 +0000 (UTC)
In-Reply-To: <vpq8v1w39sg.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	26 Jun 2013 22:18:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6FA54310-DF3D-11E2-B01B-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229111>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> benoit.person@ensimag.fr writes:
>
>> +do you want ? Use the -r option to specify the remote.
>
> Not that it really matters, but there should be no space before ? in
> English (although there is in French).
>
> (Shouldn't prevent merging)
>
> Other than that, the series looks good to me. Good work splitting
> patches 1 to 4, the history looks much nicer now.

Thanks; queued.
