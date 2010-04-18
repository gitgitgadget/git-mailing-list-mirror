From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] receive-pack: ignore duplicated commands which can 
 occur with symrefs
Date: Sun, 18 Apr 2010 16:11:04 -0700
Message-ID: <7v7ho4uzjr.fsf@alter.siamese.dyndns.org>
References: <1271364848-32805-1-git-send-email-jaysoffian@gmail.com>
 <1271364848-32805-2-git-send-email-jaysoffian@gmail.com>
 <7v39ywiat9.fsf@alter.siamese.dyndns.org>
 <y2g76718491004151607u58021df8naab23b6daf06513d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O . Pearce" <spearce@spearce.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 01:11:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3deH-0000px-Ij
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 01:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867Ab0DRXLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 19:11:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34096 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793Ab0DRXLO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 19:11:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F2057AC9EA;
	Sun, 18 Apr 2010 19:11:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=pw/Dy23veepY419iFV5PNqSJaSw=; b=sHc/zpS8cSu6BKz3tG76K7I
	FZYZCoEU3XGE8REeZ60zoiLwjrJImWfO3MhAwBOUcQe6kge2PJ3Zx2/vu40nv7lP
	w7/QjoqDC5x0tWZHY0MjbS0NMMA14xCgm1sdixjbKMbdLSG2cFivUrtoorrxc3My
	WLBwzuekS6Q/OLkk5niI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=wIjzZhLUAXXi5QEvgYJDJlJIHzbO+OqZLhCiCuRX9EM+uyLe8
	JHS4Tqym2wcGvOsYwB/hkrkVXmvY/Bxp4a6nujb9f8COyKrZhgoEgLM9jSyIX1mk
	ugi0Ey0F5DTry55fWu/DhMFtMEzNQEKvOi6hYE2S4CxenVQGD0JWWzQyZc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C21CBAC9E7;
	Sun, 18 Apr 2010 19:11:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25D2AAC9E6; Sun, 18 Apr
 2010 19:11:06 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ACBF0122-4B3F-11DF-BCD5-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145254>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Thu, Apr 15, 2010 at 6:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Very nice.
>
> I appreciate the compliment, but it is unexpected after reading your
> reply to "failed to lock". I think your suggestion there (fix
> verify_lock()) probably addresses the real problem in which case this
> is just a band-aid.

Not necessarily.  I thought I said we may need _both_, and this is a good
change regardless.

Thanks.
