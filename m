From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 00/38] Lockfile correctness and refactoring
Date: Wed, 01 Oct 2014 14:05:59 -0700
Message-ID: <xmqqd2abpkjs.fsf@gitster.dls.corp.google.com>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 01 23:07:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZR70-00022c-9b
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 23:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbaJAVG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 17:06:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62529 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751165AbaJAVG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 17:06:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 92D833D750;
	Wed,  1 Oct 2014 17:06:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iYi15bTLtrHogTJ1UUmYJg78pjQ=; b=fMSq7w
	NAeq1kVHqmVRYz3GODjx5mzyUqNtzKwpt7jUDS3avLidK/H7huADowQ47UnUjvu6
	OpQ0l91Ad9ZiLFn1zy6kbIJhVP9qHCWv0CKrpA+EC2K+LQAjg2QaOrJAdYGSZ3mH
	0bc01bSDnT/0YQR1Pd2Kr7PDaS+fkeGWx+zaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xPgaGNlwuhwV1k64nFd/rbN67tIPk/0y
	GbT+Urjna4HTNRUOjRGtxm18M+icBteCik+4zNdTSHp7OEIlkrD3VRcSoh/w6nZ5
	ik6f5gSKgepAjSm3MSkX0PmO7K6CXCBQd/Z/vmg3LGUAJEMZvVnU/NtZv4ybRxsm
	WYzojf2eLEY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 805913D74F;
	Wed,  1 Oct 2014 17:06:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1FC5F3D730;
	Wed,  1 Oct 2014 17:06:02 -0400 (EDT)
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Wed, 1 Oct 2014 12:28:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BFFC7A9A-49AE-11E4-8DDB-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257765>

Overall I am very happy with this round ;-)

Especially the last one, although I briefly debated myself if
cache.h should include the new lockfile.h to reduce the churn, but I
think that it is better without, so I like what you did there, too.

Thanks.
