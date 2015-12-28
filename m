From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Add and use convenient macro ce_intent_to_add()
Date: Mon, 28 Dec 2015 09:53:00 -0800
Message-ID: <xmqqio3ilatf.fsf@gitster.mtv.corp.google.com>
References: <1451181092-26054-1-git-send-email-pclouds@gmail.com>
	<1451181092-26054-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 18:53:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDbym-000390-KU
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 18:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbbL1RxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 12:53:04 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751126AbbL1RxD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 12:53:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9F1A734DBA;
	Mon, 28 Dec 2015 12:53:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NhE3KRNWhvNfdIYc6H2vvku0fTw=; b=BHCUBl
	WMtD1arzP+S6fYlLC75otx91HqC66QE+QiHXwTSV3UsCX7u+fGnVM2l8ez1XAnOP
	+hZOfaTfDxGaSTXN3e9gCcO3nCk+EDsjjh27UW7e0XHB84M1MPylPZPQflc3RCOb
	bFysVoeyIzdnjuUIE4pVOb6XRZxGMwOy4XWpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AmoXE27Jdtf59BLYerJ4X7NHsk5U9Sy6
	VZu9fO+O0MjihY62P09bqNAXlqlN+FUmh3h/aM4ZgcOzuEhQj4Osn8CEiUe0xa/U
	OmwIPqeBiF5x3FjigJ86zPro0+5zIkK98VC1n2Hk7Y3bp8+SBIUj3TA3EgP8/rip
	cKgLiznqI+U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9576F34DB9;
	Mon, 28 Dec 2015 12:53:02 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 166D634DB6;
	Mon, 28 Dec 2015 12:53:01 -0500 (EST)
In-Reply-To: <1451181092-26054-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 27
 Dec 2015 08:51:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D6D5E21E-AD8B-11E5-B087-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283040>

Looks good; thanks.
