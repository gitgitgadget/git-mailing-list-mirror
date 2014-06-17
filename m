From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] hashmap: add enum for hashmap free_entries option
Date: Tue, 17 Jun 2014 15:19:04 -0700
Message-ID: <xmqqmwdbji1z.fsf@gitster.dls.corp.google.com>
References: <20140605060425.GA23874@sandbox-ub>
	<20140605060640.GB23874@sandbox-ub> <5391FFC3.5010001@gmail.com>
	<20140610101744.GA23370@t2784.greatnet.de>
	<53981D6A.3090604@gmail.com>
	<xmqqegyu54cl.fsf@gitster.dls.corp.google.com>
	<539FFCAB.4060908@gmail.com> <20140617190425.GB2982@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karsten Blees <karsten.blees@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Jun 18 00:19:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wx1j3-0005z8-Ad
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 00:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967140AbaFQWTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 18:19:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53545 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965502AbaFQWTL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 18:19:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1DA8A214AF;
	Tue, 17 Jun 2014 18:19:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TbDQdmoAElTl6kusXgLQc5R2YXg=; b=Vb/PHa
	DLvAMG+hs1NKHMPfgSwV3ILSv7LmntWJi9CbQ6WiusD1rZZRJwu0xGgjHMK67PFY
	RnznIK5aghM23e3B9ZZxQxAqRvq20E43XlMJdBXSDJo7T5MPYWqeyp1PG7IWmkL1
	zMyn4uc4nveOeF2ElgxTF1kMpEmp/MFJjY+pM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bwuS6pFWqXAcNFfc6VwtDX/DHgwJ6kaW
	66cwY8UcRtgsApZlLzKK/vVMETUgrkMeVHLHKC/YQet8zIK0/YsenizWXSU3YZzS
	3d1lwOx7rhPj3yo9ayFEZ3HZU4D23fcmEc9jTxNo8fodd76LVn8YMRocUbihd5n9
	AEDq+2AOuxo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 119D2214AE;
	Tue, 17 Jun 2014 18:19:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 929A1214A6;
	Tue, 17 Jun 2014 18:19:03 -0400 (EDT)
In-Reply-To: <20140617190425.GB2982@sandbox-ub> (Heiko Voigt's message of
	"Tue, 17 Jun 2014 21:04:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 63B83268-F66D-11E3-921B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251962>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> If this is such a controversial change for you I will drop this patch in
> the next round. I think it would make the callsite more readable without
> adding much clutter but I am fine with it either way.

OK, let's do that.
