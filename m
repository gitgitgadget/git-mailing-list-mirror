From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push -s: skeleton
Date: Thu, 08 Sep 2011 09:24:15 -0700
Message-ID: <7v39g7ypcg.fsf@alter.siamese.dyndns.org>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org>
 <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
 <CAJo=hJtz6fa4XfC-4ghryP_nfg3sbcrE2bKauj+F7w2Z_8Ckvw@mail.gmail.com>
 <7vpqjc0zaf.fsf@alter.siamese.dyndns.org>
 <CAJo=hJsLx1Q9ZDoxGn=dww5J-rO9GitH47rEme_1L8Lg0RmAqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 09 01:01:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nbX-00077n-Pg
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 01:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756730Ab1IHXBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 19:01:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41434 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756684Ab1IHXBk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 19:01:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A176B5930;
	Thu,  8 Sep 2011 12:24:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZsEuszcLtbr93aM6IG7EZefscIw=; b=BGCrTa
	oixU/zmcJUmoNBcap5CZYUghTGxGKI43Grk/dWbL4t8Tbfyswdqp1GRBtxJCZU2N
	pCDb1McJjjKmmZ1i5rX+WtGV5IfjVsOZxgLlsHkEUiSwmNzilS5ioLryS56wf/XV
	esJCgYTWBqZvVdQtu8JuC+NpS/3Ex15S1MEok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XmXxmk0Gro32GsoLsCdhjjoNPZr5+mEi
	/vHk4qARdh90WJDmNxvPA8VZJaGnl6nb/h+W09mDDHODuvISjUe83kZRbHWUMif5
	KhOQB1Akm8nuPaD/VOXuFQX38TDrcBwxvB4zm+k3H5EV6UP+bxUTgM6K5fL+9fyu
	t5ydltHqxTA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98D9D592F;
	Thu,  8 Sep 2011 12:24:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EEF4592E; Thu,  8 Sep 2011
 12:24:16 -0400 (EDT)
In-Reply-To: <CAJo=hJsLx1Q9ZDoxGn=dww5J-rO9GitH47rEme_1L8Lg0RmAqw@mail.gmail.com> (Shawn
 Pearce's message of "Wed, 7 Sep 2011 16:23:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF7F0006-DA36-11E0-9E0B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180990>

Shawn Pearce <spearce@spearce.org> writes:

> This sounds too late to me.  I think you just caused 2 HTTP POSTs, one
> a partial one with the commands and no pack data, and another with the
> push certificate and the pack. Neither is useful.

Well, then I'd stop looking at this area and let others make it useful
while I hack in other areas.
