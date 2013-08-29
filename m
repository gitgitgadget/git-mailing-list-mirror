From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v3 0/4] Disable "git status" comment prefix
Date: Thu, 29 Aug 2013 09:19:20 -0700
Message-ID: <xmqqbo4g79mf.fsf@gitster.dls.corp.google.com>
References: <1377781536-31955-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 29 18:19:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF4wS-00042a-AP
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 18:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741Ab3H2QTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 12:19:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39118 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240Ab3H2QTX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 12:19:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E7A63D78D;
	Thu, 29 Aug 2013 16:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7fcEE85uSFqhGLVkXDDCGiEqit0=; b=evRWqL
	iOc3wWCKVtWkb46I/DXFrvdRa+2oTdpwFXG4YKPIwxUFvIAk2QjOiV5Jkumst9bz
	LSbu2NcVM53bikcmIAPWnlcyUFBtAr+fp8xKz+yxRDsLN9pfJ30HAp1Je2U78Lzy
	BHSDdVCcxCX3JojpeZ3xhD3pDO42DwsPkALfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DN/kRdchtJTDsbkQ7qSaDKQe0hK2owO2
	03E0OguCCKKNCaSO7k7bUrMpNQdBqixs42WhCS4oGS7dGGJxmK/iVlqDOQaRVdHW
	BFzT2L59cfMIq0/1eZHUd8SP+olDuxMGzeEMAu21vu/y0Ua9IqCYak9awhYphG+i
	4bu4DDpfBt4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6102A3D78C;
	Thu, 29 Aug 2013 16:19:23 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F9A43D789;
	Thu, 29 Aug 2013 16:19:22 +0000 (UTC)
In-Reply-To: <1377781536-31955-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Thu, 29 Aug 2013 15:05:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C3B1A06A-10C6-11E3-9E83-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233283>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> ... Right now, my preference would be to call it
> status.oldStyle and default it to false (i.e. change the behavior, but
> allow old-timers to get back the old one).

Sounds sensible, at least to me.
