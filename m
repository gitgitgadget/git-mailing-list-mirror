From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] Improve remote-helpers documentation
Date: Sun, 28 Mar 2010 10:51:21 -0700
Message-ID: <7v4ok01giu.fsf@alter.siamese.dyndns.org>
References: <f3271551003230045v523d2088v18b21a4a5c424ff0@mail.gmail.com>
 <f3271551003230238y6143d770h4e23686d41fce667@mail.gmail.com>
 <f3271551003280932l6fde201fpf2096dd368c13c84@mail.gmail.com>
 <7v8w9c2vfk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 19:51:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvweI-0002ZT-4Y
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 19:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858Ab0C1Rvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 13:51:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50889 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853Ab0C1Rvg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 13:51:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C9FE3A501F;
	Sun, 28 Mar 2010 13:51:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vrH6g9j2PLKOd+mJ7zq4hs97AXs=; b=K7ASQS
	LFO2RsOI+UuJ6NO/YoqOFQfqaQj1NbqYS5S+PS+KOV7jNMv2nSIIIIn125egFPZr
	9fLRL+pu1xH5rLZRdcaDnGWKaN0N0dsD+vLNJrSWJ8ApaUJpu/9WNZM3r0CxunNd
	HjY2xfKZHRwKuiEQFsK6QmKRac3SYKk9yMKgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vH6zEdMTACSeuC756CLI894rcNAZrv4U
	8JSAl2B1bMBPvP6hHNKtL7YWIo5DpUIZdXXM98pG59W912k0lbPvb5pT68D29k2+
	j/KMKSNiLZd5pNidusGIMzh9RvgyvR+Zol+u929POmHR91C+zUMNJ7H8UGMkbr9b
	QrxPySQZfBs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B6CEA501D;
	Sun, 28 Mar 2010 13:51:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74ECEA501A; Sun, 28 Mar
 2010 13:51:22 -0400 (EDT)
In-Reply-To: <7v8w9c2vfk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 28 Mar 2010 10\:43\:59 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 89B0C55C-3A92-11DF-BE49-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143410>

Junio C Hamano <gitster@pobox.com> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> On Tue, Mar 23, 2010 at 3:08 PM, Ramkumar Ramachandra
>> <artagnon@gmail.com> wrote:
>>> Rewrote the description section to describe what exactly remote
>>> helpers are and the need for them. Mentioned the curl family of remote
>>> helpers as an example. Fixed minor typos in the rest of the document.
>>>
>>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>>
>> Junio: So is this patch alright?
>
> It looked good to me.

... except that the message is corrupt and does not apply.  Here is an
excerpt from it, before decoding MIME and quoted-printable.

    Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
    ---
    =A0 =A0Complete rewrite since last revision, inspired by Junio's detail=
    ed review.

    =A0Documentation/git-remote-helpers.txt | =A0 89 ++++++++++++++++++++--=
    ------------
    =A01 files changed, 52 insertions(+), 37 deletions(-)

    diff --git a/Documentation/git-remote-helpers.txt
    b/Documentation/git-remote-helpers.txt
    index 1b5f61a..2382fb4 100644
    --- a/Documentation/git-remote-helpers.txt
    +++ b/Documentation/git-remote-helpers.txt
    @@ -3,7 +3,7 @@ git-remote-helpers(1)

    =A0NAME
    =A0----

Who is replacing the SPs with A0???
