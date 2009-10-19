From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unapplied patches reminder
Date: Mon, 19 Oct 2009 01:05:57 -0700
Message-ID: <7vskdf4xlm.fsf@alter.siamese.dyndns.org>
References: <20091019052030.6117@nanako3.lavabit.com>
 <7v63aci8id.fsf@alter.siamese.dyndns.org>
 <20091019064955.GB1457@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 19 10:06:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MznFx-0006VJ-Nm
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 10:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755788AbZJSIGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 04:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755783AbZJSIGE
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 04:06:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770AbZJSIGC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 04:06:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D52D5E989;
	Mon, 19 Oct 2009 04:06:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=8U71fcmCrkeEXbp/JedCd57tqRM=; b=AxLV1eD8aj/te686BeClXC1
	ww31h09M1vCP4ICPPFsMEbjrS4DJwYnf1PArXov96EA76F3MJu9OX1h4MQEB4wPF
	PwUSeqRBDpOclyiDf8nUo9WI5GZjklJUAL1qdfvpYxzpnxRjH73xH3ENrD1SsIIS
	LP5S8V/62hpRG9duxKqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=qYJYqr9xZIxqOZVElsCRMkgkTpJDUTZs3NS667I3nZAIh1pkD
	P9hz84QI0PMputwcx0JOSzLa/ZC/LbNviPBEXrLg0ZBQbp/yi9/TOTr8oekm2w8w
	VPa6+hz+37RiDd0ZYRSPxIzguYghIStwlEKSBexzTEPE1Eq2c5rVBGYwAI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D555A5E987;
	Mon, 19 Oct 2009 04:06:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19C7B5E986; Mon, 19 Oct
 2009 04:05:58 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3F212C1E-BC86-11DE-9952-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130674>

Jeff King <peff@peff.net> writes:

> Yep. I got comments from JSixt, but I never got around to re-rolling.
> Here it is, though still only lightly tested by me (happily, I have not
> had to touch CVS for a few years).
>
> -- >8 --
> Subject: [PATCH] cvsimport: fix relative argument filenames

Thanks, applied.
