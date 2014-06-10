From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] t9001: avoid not portable '\n' with sed
Date: Tue, 10 Jun 2014 08:38:17 -0700
Message-ID: <xmqqmwdkai6u.fsf@gitster.dls.corp.google.com>
References: <5396849F.7060206@web.de>
	<xmqqk38pb95s.fsf@gitster.dls.corp.google.com>
	<5396A618.5040306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 10 17:38:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuO85-00086b-Mn
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 17:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbaFJPiY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 11:38:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50810 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbaFJPiY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2014 11:38:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 47D701D2DD;
	Tue, 10 Jun 2014 11:38:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wRkrmu7N8pKJ
	jQbXAsLQ1htV6Yc=; b=CvV0MTSEvxOJ6rnuNfqEvzy1jRuNq31o4Prd1uFdiblM
	/kHsDJ99UtUC3rdoQNLvsVXMhu29dSCE0ficPhPdlJO44dI1lFQD7Fc1xYFbkKit
	+0bDiXSMa8q46NmSSEyP5XG1HqsPEtunrtaDzULvxjmAxZwzVFbTpQzVODEsjok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lNzDIT
	5rgSVujUrPAs3NTetEajZx8I/IWlmLrVoeiDCMYPf1CK4q7Rf/mk/rjkr4U75Q8E
	QvJQLxJCdVceKdpusfoQqgi/D3Vm/fCOGbrpPWjLmNf+8CU+NiIiBSQ2ni4kb881
	LczFbaoLvm10ie7qhueZshdI06KJztiYPMBcM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3D2E11D2DC;
	Tue, 10 Jun 2014 11:38:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4E8B21D2D7;
	Tue, 10 Jun 2014 11:38:19 -0400 (EDT)
In-Reply-To: <5396A618.5040306@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 10 Jun 2014 08:30:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3F51E1AC-F0B5-11E3-8394-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251201>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> I think that V3 explains the difference between POSIX sed and
> gnu sed much better, and does reflect all the comments from
> the list, which otherwise may be lost.

Too late for that as the patch is already in 'next' X-<.
