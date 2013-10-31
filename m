From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Help creating git alias
Date: Thu, 31 Oct 2013 12:41:26 -0700
Message-ID: <xmqq7gct5iu1.fsf@gitster.dls.corp.google.com>
References: <CAPZPVFbiSx8n0W1kcczCdC6ioVuWpwuUQ_pc9T=7i4X_FuZNhg@mail.gmail.com>
	<CAN0XMOKMF235S-23QcMj5cBup+Lh4vQs7QcOqXQ-MgafsAMKNg@mail.gmail.com>
	<CAPZPVFZ9WujUCQ1O9VfV83XUu_6g7Vp_MmYRCCO+GptOoSyvcg@mail.gmail.com>
	<xmqq61sebhh3.fsf@gitster.dls.corp.google.com>
	<CAPZPVFarK_jKpM2f62mErAmL+mck6EN1QPfHDHqqfJbJ2AfzXg@mail.gmail.com>
	<xmqqk3gu9jst.fsf@gitster.dls.corp.google.com>
	<CAPZPVFYFSBRHThO08LmuN_0fc55gYX-A+Y3=yA_MESko1t6fXQ@mail.gmail.com>
	<20131031174008.GA39079@gmail.com>
	<xmqqd2ml8gbs.fsf@gitster.dls.corp.google.com>
	<20131031181509.GB39079@gmail.com>
	<CAPZPVFYWf3_xtxKkdw4_gzqKagVsbNvj73cb=RvX1Zm0C1h8pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	git <git@vger.kernel.org>,
	Andrew Ardill <andrew.ardill@gmail.com>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 20:41:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vby7a-0001ux-2g
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 20:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620Ab3JaTla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 15:41:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47676 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122Ab3JaTl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 15:41:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1391E4DBA6;
	Thu, 31 Oct 2013 15:41:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0iB5q/P3zrZ9G8+sCrblqnAIt7Y=; b=RO2hZQ
	BobEjm+1jYLeveF2JjUVJhSaSWtUHX3lhYsR4bGNyaMqlxux0dsHsRJT1w1VMMWL
	b97/nB4jI8RW0cdYHfHCkp4Agyranz8zvpHko/eA5Jwyub0uf4zTALMxkuRcTVDC
	wh8fAciKQ9iWuAmlFnqshULU4/RIiFRmvLRJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KKkbGNczyAoV6rdR6UG6u8N5542RpYKt
	ttITGSOe06TNydQfloccs4duK3q1fYsjQrGoYACvYkd4tE6d7Q2vXdht5Osxyc5s
	+SeTC+pSSlNjHb5sZjBUd87rGW3eNW542NhDV0vfT18LiQ1cc/wLstj+wIAhbSoH
	c4zPwrvO4mo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02DFD4DBA5;
	Thu, 31 Oct 2013 15:41:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D4D94DBA0;
	Thu, 31 Oct 2013 15:41:28 -0400 (EDT)
In-Reply-To: <CAPZPVFYWf3_xtxKkdw4_gzqKagVsbNvj73cb=RvX1Zm0C1h8pQ@mail.gmail.com>
	(Eugene Sajine's message of "Thu, 31 Oct 2013 15:31:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6F4BAA46-4264-11E3-8181-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237168>

Eugene Sajine <euguess@gmail.com> writes:

> One note: i tried the ${GIT_PREFIX:-.}  and ${GIT_PREFIX} and it seems
> to give the same results. What is the expected difference here?

GIT_PREFIX may be an empty string when you run from the top-level,
in which case you would end up with "cd && ..." and end up working
in your $HOME.
