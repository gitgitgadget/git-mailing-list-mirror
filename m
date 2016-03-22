From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] (exit 1) is silly
Date: Tue, 22 Mar 2016 10:45:54 -0700
Message-ID: <xmqqk2kuiey5.fsf@gitster.mtv.corp.google.com>
References: <1458661671-3793-1-git-send-email-izaberina@gmail.com>
	<xmqq8u1ajxnk.fsf@gitster.mtv.corp.google.com>
	<56F17BFD.80606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: izabera <izaberina@gmail.com>, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:46:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiQNV-0005AD-Rh
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 18:46:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205AbcCVRp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 13:45:58 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60722 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751880AbcCVRp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 13:45:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 522474EAE9;
	Tue, 22 Mar 2016 13:45:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hYkwnq54+qlaIkEeMCrMCbbDjWs=; b=YQQbV0
	9gbz3wbWTVuMx9oqpE0zKk1wIryKmhL3y/zdt6yREmaqDHjmHKrIJXRQg1q+M/KB
	LhhtMy/TW/1OcyRE8J+M3dn4SznPoq9Ju6njXGnRscCe1Gmx8Ty8dGk2ga1AwEv9
	EwfVhkpU2ZkNxleT4ssdjlnAu4sr6E0xlfmbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JnxADHG7w2dLrmYBFre3GY+JLVCD3/xq
	NHiWl00vbf3jtF7ynAVP6lSJv/BW495sDLEVppMvcTvR8ZEHCiX24JEnHo/8FvDt
	jtEgofuhe4znn+a861ybi6jq5HeOC4LJyrLELp+aPbYgBro4UJHKgPOtljhommdO
	vkcHjtPu54I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3E3E54EADE;
	Tue, 22 Mar 2016 13:45:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B0C1C4EADD;
	Tue, 22 Mar 2016 13:45:55 -0400 (EDT)
In-Reply-To: <56F17BFD.80606@gmail.com> (Sebastian Schuberth's message of
	"Tue, 22 Mar 2016 18:08:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EDCFBDA2-F055-11E5-A34E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289529>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On 3/22/2016 17:16, Junio C Hamano wrote:
>
>> IMO, this is such a minor thing that once it _is_ in the tree, it's
>> not really worth the patch noise to go and fix it up.
>
> IMO, instead of writing this you could have just accepted the patch,
> reducing the patch noise ;-)

"patch noise" does not mean the volume of the list traffic.  It is
the number of pointless changes in the history of the project, and
accepting this patch would _encourage_ similar pointless changes,
i.e. "patch noise".
