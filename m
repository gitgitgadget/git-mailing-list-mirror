From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 15/16] config: add core.noshallow to prevent turning a repo into a shallow one
Date: Mon, 22 Jul 2013 21:06:32 -0700
Message-ID: <7v38r5apiv.fsf@alter.siamese.dyndns.org>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
	<1374314290-5976-1-git-send-email-pclouds@gmail.com>
	<1374314290-5976-16-git-send-email-pclouds@gmail.com>
	<BF5D998BFA5241938531635E1D8B79DF@PhilipOakley>
	<CACsJy8Ddac5r7opAgtk-CAkc=jwmBmmOs7FU6DziysCZ=992dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 06:07:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1TsP-0008Os-5j
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 06:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497Ab3GWEGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 00:06:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415Ab3GWEGf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 00:06:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDD7A2B62C;
	Tue, 23 Jul 2013 04:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NI3Xtlg0BoAUbtepihGTTp/KPDg=; b=NnrJam
	ivHx89KlHg4SsGHwufjyb4ZIet69rh6k3YFnbIpxlS8hfhf3ElS2nD5mWKuD0Iid
	9A4AzUeEzM1ITvM2oq8hywwLRmNliJLU9831JIIg71L+x8BSYkk0LkPXy+ebdFKm
	OIeuCMle0Bp6o5AAZD3OMtvyhp+qn1nXlEhhg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bqRGe/6wMmumoYu0Q49FXEwubn+ys3uX
	oTaOVLY7aXwA6thOFY25hiP6J31qSEG8U3548/B+YwvSNuZHQ3SXmtPutygyU1hi
	xODFFGMEJxg1+nfqXqlntDiqkYaB/+GzPi7pQ97wXRvabEdIDNwuvZUjpgfuifpL
	PbPj6RDPdig=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD2F62B62B;
	Tue, 23 Jul 2013 04:06:34 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E83B2B62A;
	Tue, 23 Jul 2013 04:06:34 +0000 (UTC)
In-Reply-To: <CACsJy8Ddac5r7opAgtk-CAkc=jwmBmmOs7FU6DziysCZ=992dQ@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 23 Jul 2013 08:28:00 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4351D93A-F34D-11E2-BC3B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231017>

Duy Nguyen <pclouds@gmail.com> writes:

> But yeah, maybe defaulting to no shallow is better. Will do so in the
> reroll unless someone objects.

No objections from me ;-).
Thanks.
