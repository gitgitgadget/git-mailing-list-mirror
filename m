From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/6] Improve tag checking in fsck and with transfer.fsckobjects
Date: Fri, 12 Sep 2014 11:02:44 -0700
Message-ID: <xmqqwq98af97.fsf@gitster.dls.corp.google.com>
References: <cover.1410445430.git.johannes.schindelin@gmx.de>
	<cover.1410509168.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 12 20:03:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSVBa-0003Sf-K4
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 20:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbaILSCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 14:02:54 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56401 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411AbaILSCx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 14:02:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 39D5937FD9;
	Fri, 12 Sep 2014 14:02:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GAe4iOBkPf9vmPZ6pnw44WmxVVk=; b=MBqqkf
	4g8NzHfkyoSXxqwMg1OpfotDWr14RD+nLXBjukI7sd0oLHJ4p0ICDQ+ITdlIMX2W
	IysGg+9PitDe0HuyKW8KOzVtrOzYnJkdWLnvNMbXhH95WQUTN4hjO52X/flHYMel
	GOoBMXzABcb80rCOvOigXQGHh3/cCHPyT/ml0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CnXvRUJZoPygeRX83KAtap7BeafYwg7E
	MWT97nTppV6gCIt4oTP0eUc8onzLJ+SNgfM5FhMmr6FcOCsIPwJp5w6LPjcLiFeR
	xE6WqqZKforCN/fGfK76+AGpevcSjh/GhCWDWpR07Ymo+iJNYPRlwybbEFRIkVq0
	580h5ENOax0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F17437FD8;
	Fri, 12 Sep 2014 14:02:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A780037FD2;
	Fri, 12 Sep 2014 14:02:45 -0400 (EDT)
In-Reply-To: <cover.1410509168.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Fri, 12 Sep 2014 10:07:43 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FFB4788E-3AA6-11E4-BA0F-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256934>

Thanks. I think this is ready for 'next' and then down to 'master'
for the next release.
