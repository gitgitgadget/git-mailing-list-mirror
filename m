From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Mon, 29 Apr 2013 14:01:16 -0700
Message-ID: <7vtxmpgig3.fsf@alter.siamese.dyndns.org>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<7va9ohhzsi.fsf@alter.siamese.dyndns.org>
	<CAMP44s3ghzcfTthEEYZgr7ydJFUeA5xKyAxgR1JUYVtWG7f=qg@mail.gmail.com>
	<7v1u9thyq9.fsf@alter.siamese.dyndns.org>
	<CAMP44s044amTqdshNAm=EaT1UgEtKU6yLWAxsk3GwCcX+GQKxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 23:01:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWvCY-0001ry-Dx
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 23:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759216Ab3D2VBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 17:01:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55249 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759212Ab3D2VBT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 17:01:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FC671A962;
	Mon, 29 Apr 2013 21:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NvV7H9B4I/sC3m+uMAE2uzqCx2w=; b=IJ0ymc
	05SaoLBQoTepoKIdL89qkIK17LYnFGznb4ACXfH5cmxvpjem8HL18KJC7FC4Dec8
	u8rpYsrxKVI7jXqL/10mtBVsm4xypMz894PpOtDBQHwiFTZSuhlAijC3EfDnyPRA
	KStOXeqKNxEVJ2ez6gu2b4MW6pL5QkvP6zGuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ezwg3HslKpyWF7BW6G548tej4YvpFGA7
	47M1u+6I0ZwRd0HgEXSd7RVKygEqV3JeCIWju2QibFjlCbzBQZ+TshbIHusIfcM0
	+lqGkp3bUbvcR77NtvT2IJjXRN8DbqFVDsqhL3TFaTI6bj+bG9uiKNgyxPDXouFQ
	AyOFDRn/zWM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95C0B1A960;
	Mon, 29 Apr 2013 21:01:18 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1CED11A95D;
	Mon, 29 Apr 2013 21:01:18 +0000 (UTC)
In-Reply-To: <CAMP44s044amTqdshNAm=EaT1UgEtKU6yLWAxsk3GwCcX+GQKxQ@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 29 Apr 2013 15:38:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EFDBFE72-B10F-11E2-BEAB-8D009ADAE8A5-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222862>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It shouldn't matter if @{u} is buggy or not (which I doubt),

Oh, it wouldn't make any difference to this topic; it is just
something we may want to fix if it were broken.
