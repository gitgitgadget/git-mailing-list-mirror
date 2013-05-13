From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: simplify file filtering
Date: Mon, 13 May 2013 07:53:19 -0700
Message-ID: <7vy5bjnd7k.fsf@alter.siamese.dyndns.org>
References: <1367100099-13798-1-git-send-email-felipe.contreras@gmail.com>
	<20130511094258.GC6196@iris.ozlabs.ibm.com>
	<7vmwrzu7vt.fsf@alter.siamese.dyndns.org>
	<20130513113426.GA13543@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon May 13 16:53:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubu7x-0007TG-S7
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 16:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731Ab3EMOxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 10:53:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59235 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753554Ab3EMOxW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 10:53:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F2AF1DA95;
	Mon, 13 May 2013 14:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A8n+w04leV4LVR1+dJh9QyuFIFo=; b=jB69n7
	nUQaZH6CovNlzbK7ZABItRzsmAHtcf/Te+by9Vly9BRy3qWPcw+XUBrZ3vicxPxP
	/PuAkkrHo0+AvPgpxOMvvDelq3mCpqoPs/GNztqIaOAi0vXmQHXom0qP6cmtj2Bj
	w1pid/vskTyv3d9mry4fMCl5XdHs+nUVwZHck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PnyNNYcb3ZTbudPR/QCKuTxlpntuOX4s
	BQd2vu9v1SNjEv3a2mHkF0uPIQzXnKyEIvBsms5mMe+rM57l/FVv3U8i1+PYgmnu
	UTYZNu3haGBfbb1QVlnSbCuv1cnEsQGbfAe0HyDsGfdmYS2zDdVXTKKptWnTNYME
	kyjoTmeEbBY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 826861DA94;
	Mon, 13 May 2013 14:53:21 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 049EB1DA8D;
	Mon, 13 May 2013 14:53:20 +0000 (UTC)
In-Reply-To: <20130513113426.GA13543@iris.ozlabs.ibm.com> (Paul Mackerras's
	message of "Mon, 13 May 2013 21:34:26 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DAA99EA6-BBDC-11E2-8707-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224159>

Paul Mackerras <paulus@samba.org> writes:

> On Sun, May 12, 2013 at 03:54:14PM -0700, Junio C Hamano wrote:
>> 
>> Thanks; is this the last one for this cycle and is your usual branch
>> ready to be pulled?
>
> It is now; please pull from the usual place,
> git://ozlabs.org/~paulus/gitk.git.
>
> Thanks,

Thanks.  Here is what I ended up with:

 Merge git://ozlabs.org/~paulus/gitk
 
 * git://ozlabs.org/~paulus/gitk:
   gitk: On OSX, bring the gitk window to front
   gitk: Add support for -G'regex' pickaxe variant
   gitk: Add menu item for reverting commits
   gitk: Simplify file filtering
   gitk: Display the date of a tag in a human-friendly way
   gitk: Improve behaviour of drop-down lists
   gitk: Move hard-coded colors to .gitk

 gitk-git/gitk | 254 +++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 199 insertions(+), 55 deletions(-)
