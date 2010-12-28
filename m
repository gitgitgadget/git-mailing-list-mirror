From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/31] rebase: clearer names for directory variables
Date: Tue, 28 Dec 2010 15:08:37 -0800
Message-ID: <7vtyhxts0a.fsf@alter.siamese.dyndns.org>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1293528648-21873-2-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 29 00:08:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXif3-0007qw-FJ
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 00:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816Ab0L1XIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 18:08:52 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64710 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab0L1XIv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 18:08:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 58CC63E00;
	Tue, 28 Dec 2010 18:09:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=sZapAvy94yuR5FzbZUxhOtcppcY=; b=RO4y0K0aAqbXGmg4ngOyMlN
	3a6CZl4PeebEJnD6W0fAixLvlRzyn6lyoOm1lwML8eNlCG0gFDN3jvIHVUz/iHib
	LRHmP4dWnwuPCKKuz0QWIb1WqBiWUJ5L1vlaFFIYsiK8HrgUlFmjw9LOHt50BdWm
	7zjmRChPa7G+ejRT/JeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=XCIRXJX+5kd6Ltl2/Lw14SJ74gCJOkHOXcGMzlCId8pFKyuSw
	k6ouPKYyKyCF9pDIcFB3Qwkmq5l4Iim5qIKcL6x1kzQhrgOJa+YKoWD9mRcT4Vy/
	5ysApyWj81SINDAuBqlf4dll5gbqRf9r/6bYy9qGKAUVaG6Xn8/4aiqcSk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 073F63DFF;
	Tue, 28 Dec 2010 18:09:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 68EA33DF3; Tue, 28 Dec 2010
 18:09:11 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7FA2B7A0-12D7-11E0-802B-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164295>

If this were just "s/dotest/merge_dir/g" and the same for rebase-apply, I
would have to say it is long overdue ;-)

I read the patch and didn't spot any glaring mistake, but I wasn't being
as careful as I usually am.

Thanks.
