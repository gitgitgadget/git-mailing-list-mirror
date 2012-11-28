From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/7] New remote-bzr remote helper
Date: Tue, 27 Nov 2012 17:56:49 -0800
Message-ID: <7vsj7ujxr2.fsf@alter.siamese.dyndns.org>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s2F9C4cr6v===M3AWHieaiUk1adigcU8txpZPL0wN81Ow@mail.gmail.com>
 <7v4nkdxawx.fsf@alter.siamese.dyndns.org>
 <CAMP44s1G3b3XQX+=5Ag2exdy83hULbz1m0Z6UFDrhZU2TGwBMg@mail.gmail.com>
 <7vehjelizc.fsf@alter.siamese.dyndns.org>
 <CAMP44s0swzsg1MkQHkPUtwZi71xaad3y4uY542jYvXAf8Ha5nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 02:57:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdWth-0000uO-8O
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 02:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706Ab2K1B4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 20:56:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34236 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763Ab2K1B4w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 20:56:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B02ACA5A2;
	Tue, 27 Nov 2012 20:56:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bcubr306iMROzsli6vy08Bnw8Nk=; b=QMCCtd
	VlSyE/wu+pYiA+FG8swUhNihM47b4rdZckCLqevEKXbpLnw+DCP6mJVr6XzX9ZvG
	2Xgqd6vXwK2nzt6PiL81kjcnBfi0TOf/MFZgdn6EJsmZSitQRpZqukNcW/S1Adiu
	4QQKITe2IYh12Xg5w3oUcBHkmP7TsfyT/1WUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XlT+3/hNUP2S6fiQBd6i2TpB41VA2teY
	2WcpXlLUeKiYaffIzfQzZvb+Gu+mznRDl06+licz1zHFrIlu8g89Rb31pVCbtnXv
	5OvJ+FiE01uIBRtlHdvvVSMjHTRnP0XRHmDAan7mWXgTKG/OUjX53R3vQa8zA3Kq
	9PzyZjOnkp0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E14DA5A0;
	Tue, 27 Nov 2012 20:56:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01BECA59F; Tue, 27 Nov 2012
 20:56:50 -0500 (EST)
In-Reply-To: <CAMP44s0swzsg1MkQHkPUtwZi71xaad3y4uY542jYvXAf8Ha5nQ@mail.gmail.com> (Felipe
 Contreras's message of "Wed, 28 Nov 2012 01:23:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0475BD4-38FE-11E2-A574-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210662>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> OK.  Both fc/remote-hg and fc/remote-bzr are slated for 'master'
>> soonish, but I take the above to mean that fc/remote-hg is ready
>> while it is better to wait for updates to fc/remote-bzr before
>> merging it.
>
> I was waiting on both to be merged, let me see what I have pending and
> would be nice to have before the merge.

OK.

At this point, both have been cooking for a week or more in 'next',
there is no existing users, they are on the fringe so breakages in
them won't negatively affect anybody anyway.  So it doesn't matter
much if they are merged to 'master' and then fixed up with follow up
patches after that, or fixed up with follow up patches while they
are in 'next', as they won't be rewound and restarted from scratch.
