From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib: remote-helpers: add move warnings (v2.0)
Date: Tue, 13 May 2014 15:41:07 -0700
Message-ID: <xmqq38gdmhdo.fsf@gitster.dls.corp.google.com>
References: <1400016596-13178-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq7g5pmj5r.fsf@gitster.dls.corp.google.com>
	<53729b2150a84_34aa9e5304e0@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 00:42:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkLOv-0001mz-53
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 00:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbaEMWmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 18:42:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52866 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754116AbaEMWmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 18:42:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3FDC015FC5;
	Tue, 13 May 2014 18:42:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rY2njR789EUM6jmDB1OgGj9MOZY=; b=fWVyeN
	ufvn1A7mxP2CdOyxI5qZPpYvaEdwNmUTp4YGGkrAW320ZP1hkmVtltxKjS9zV3/2
	4/ovVfHUbGunCXkV5hUB4TlQt5WaP2IaKTkzuuEpox/HIcDQgYPnFqS5PsTkmQ6m
	oyygjAWXvf17VXdhEIghQMCPnoJlMrDa9Kstw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZMneG2Tn/Ejj5/ewHwHG+g6OvB32HaXp
	7kiS0SmU0wEWi/KxEqJKUsfNSF7aahyOwcmgntkd1kfCxNvMBBTyflB7RVRbvIMP
	kf+7/snIv5Py6D8sAxpPMeJOePhefhkR7D8XDpW8zkMwyqj6xnGmdq2srcd3Ta/i
	6BST5VWitcQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3467115FC4;
	Tue, 13 May 2014 18:42:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1475E15E12;
	Tue, 13 May 2014 18:41:09 -0400 (EDT)
In-Reply-To: <53729b2150a84_34aa9e5304e0@nysa.notmuch> (Felipe Contreras's
	message of "Tue, 13 May 2014 17:22:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AD4F2DE4-DAEF-11E3-987C-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248878>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sigh, you just don't seem to understand that you are thinking about a
> different issue. I don't think there's any other way I can explain it to
> you.

Perhaps pointing out which commit(s) to revert might be a good point
to start.
