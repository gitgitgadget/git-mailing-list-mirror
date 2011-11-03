From: Junio C Hamano <gitster@pobox.com>
Subject: Re: error from 'git push' on v1.7.8-rc0
Date: Thu, 03 Nov 2011 11:59:00 -0700
Message-ID: <7vmxcdf2x7.fsf@alter.siamese.dyndns.org>
References: <CAJzBP5Q1_zX+H0jeBZNB81KLYAbtJWhUuHA3rf8CuW-_OSFXbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitlist <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 19:59:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM2VJ-0008Jo-S7
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 19:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934349Ab1KCS7F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Nov 2011 14:59:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49803 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933865Ab1KCS7D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2011 14:59:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF85D6221;
	Thu,  3 Nov 2011 14:59:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KMJrPmN7Y1At
	vZdqX5ACF07H2rA=; b=EHEQlqb2Yf8TNX/RCDi32AWFoRsc7GYEvWP2c12woGUg
	gbfzCRYbXUX3lxxdGOQZ4hU9kxNBd9K7LKeNChTBJxtM+Y1CWuZTL7Z59LQBWLwu
	GJ2R+NWLDCU7+vnwMtWcYfPT1EE+WXZtOkVFpXvcH8ZYyDhdE1QfXDhydJShThY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Gllf5c
	3LDf2bWVEtA/rJ8s1F+Rz5U6PzDb7s3qmdqpY5a02DXjURtcv6EEwcwByScgJd62
	x8M4Nfx1na8Cs9TlKUdzw6/DRewo9F9eA5FIkN+YPTMc7RVlpRpDnfT1YNAVzbQY
	Ep0g3EtltCiRoRtYlNxEbKY/c94Dc42EuK+NA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E725D6220;
	Thu,  3 Nov 2011 14:59:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 176FA621F; Thu,  3 Nov 2011
 14:59:01 -0400 (EDT)
In-Reply-To: <CAJzBP5Q1_zX+H0jeBZNB81KLYAbtJWhUuHA3rf8CuW-_OSFXbg@mail.gmail.com> ("Stefan
 =?utf-8?Q?N=C3=A4we=22's?= message of "Thu, 3 Nov 2011 12:43:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4F0ED92-064D-11E1-ADDB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184737>

Stefan N=C3=A4we <stefan.naewe@gmail.com> writes:

> I get errors from git push when trying to delete a (remote) branch:
>
> $ ./bin-wrappers/git versiongit version 1.7.8.rc0
> $ ./bin-wrappers/git push -q . :refs/heads/nogofatal: bad object
> 0000000000000000000000000000000000000000fatal: bad object
> 0000000000000000000000000000000000000000remote: warning: Allowing
> deletion of corrupt ref.

Thanks. I think the operation does _not_ error out and fail to delete, =
but
I agree that the "fatal:" message should be squelched.
