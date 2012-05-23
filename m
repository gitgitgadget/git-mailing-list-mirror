From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] completion: split into git-prompt.sh
Date: Wed, 23 May 2012 09:33:11 -0700
Message-ID: <7vd35u26yg.fsf@alter.siamese.dyndns.org>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ted Pavlic <ted@tedpavlic.com>,
	Thomas Rast <trast@student.ethz.ch>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 18:33:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXEUy-0006LC-Ix
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 18:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571Ab2EWQdP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 12:33:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53957 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751647Ab2EWQdO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 May 2012 12:33:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B17F48550;
	Wed, 23 May 2012 12:33:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=KTKT7jpPzyr0mz0VPN2+S+jjt
	ow=; b=RIBCIco5K3L6s5sQ26P8wqIS0gBz5By79XySHQ1wcZjZrWqNE7J5VJ3Zf
	PtazPhqit8l7jxQ7ZwUf2XV+BBfw4z2MQwEpT7095mCJvZg4e2kjhiu0DfuIPqxH
	/pPDPnWrFIb6dKO1zIPz+T6zJREm2kj9rEKFvv1kj0rauy+Duw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=s/BtxJD4ArSMRpv4AfK
	Zwjb3Q9rcVzDVYg22nABih8gUV6AIWC5exSxAMWJmlrZBYAlYqwBp+GAsctuAucm
	KXKwQiat0MAzGRB0fYxAvkMdU0b8NpsLp4CCkVCbA2ccN0S+qZVUeGkwk+a7bhWU
	KPXeNw2aHKi4cbFO4v4aS8Ok=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7A61854F;
	Wed, 23 May 2012 12:33:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EA228545; Wed, 23 May 2012
 12:33:13 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FDAB83EC-A4F4-11E1-A8B0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198306>

Thanks for tying the loose ends.

The update to t9903 in the second patch is a bit tricky to handle, thou=
gh.
By the time both series graduate, somebody has to tell t9903 where to f=
ind
the git-prompt scriptlet, but by basing it on 'pu', you made this serie=
s a
hostage to the still-incomplete bash-prompt update series by SZEDER G=C3=
=A1bor

I think merging the bottom-most two commits in sg/bash-prompt series an=
d
the tip of fc/git-complete-helper-fix and then applying these two patch=
es
on top would be the easiest for me to handle, but if you or anybody els=
e
think of a better organization, please speak up.

Thanks.
