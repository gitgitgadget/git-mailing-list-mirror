From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/20] git-cvsserver: add support for cvs "-r" refs
Date: Tue, 16 Oct 2012 12:25:24 -0700
Message-ID: <7vd30irzh7.fsf@alter.siamese.dyndns.org>
References: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 21:25:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOClo-0007fP-6T
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 21:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755691Ab2JPTZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 15:25:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37413 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754398Ab2JPTZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 15:25:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C71EE93FF;
	Tue, 16 Oct 2012 15:25:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9JYaAK4zbvs6SIsXj/j8CxjsrSE=; b=fNusBM
	BsOEtqLFLl5FOVq6aHd5IqFfKk2n3w8Ta6F01iuek+1a7tNKygnF65rp2JAOyZFV
	ZdrJ7J8RUWxar8hVHo/nPccOC6P94mm436ce7MNFEryOBKvncxJrfptT/SUTWtJ8
	+ld6ux+aVoDxRtQHoOeXf2VgYT+byFajmSErI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u243ErI/BaKPorXiHf4lreuxJAcSj1jF
	eaFyd8XKOZw62V+dLHrw40e0IFwW9a5do2PHMelEZiy63fJkckJz1mykYZ2QDMNu
	QlMaiU465sn+rfHzztvmGwSvQ6I0u+/xuGY/380LdTEoM3fugLMOSedRiLBeAcGK
	Ymato696rd0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3A0D93FD;
	Tue, 16 Oct 2012 15:25:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B9B093F8; Tue, 16 Oct 2012
 15:25:26 -0400 (EDT)
In-Reply-To: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
 (Matthew Ogilvie's message of "Sat, 13 Oct 2012 23:42:13 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3CEB4C64-17C7-11E2-BFF9-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207873>

Matthew Ogilvie <mmogilvi_git@miniinfo.net> writes:

> I don't actually intend to use any of this myself.
>
> I started it a few years ago under the theory that a more accurate
> emulation of CVS would make it easier to convince the team at $DAYJOB
> to switch to git, but we eventually switched without using
> git-cvsserver at all.

Nice ;-)

> ... That said, perhaps some of the trivial cleanup
> patches could go in now?

Not "now" now during the pre-release freeze, but the earlier patches
(up to #11, arguably together with #12 and #13) do look like nice
clean-ups to have.

Thanks.
