From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] sequencer: revert d3f4628e
Date: Sun, 06 Nov 2011 11:10:42 -0800
Message-ID: <7vlirt5aod.fsf@alter.siamese.dyndns.org>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-6-git-send-email-artagnon@gmail.com>
 <20111106004257.GG27272@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 20:10:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN87K-0000pw-PU
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 20:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367Ab1KFTKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 14:10:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55802 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754269Ab1KFTKp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 14:10:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B01860F2;
	Sun,  6 Nov 2011 14:10:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OQT7Vpro4edT19txMuYNBV7O5mI=; b=n7KFAt
	kUwJiMdQp++PDE/KhfEoNKSO5jVM3OGOclIraDpnMveDt0dyrakHkxYeOO7S4u2l
	Vp2vgI9SBQuxwPovBqP4bobd7eJfhpcjIgAuHcCIi+y3V7XauWQvnhdxGKMdu4Ab
	MCEGOxe+xeBck+kNLNJxaPF+KJSi5i6Sw9dm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LVQfcanQL01SQsj1h9CZEutaWSOxir+S
	lO9VL+l8pBSdxEflmQJQra+iGN597Y3F5NWVP4GKu6JPEyiI50MbRTFeLT9iMpCR
	rNLQK73S1b+jmyhnrBwQ1fFUN0/q4ePuz3y0FjO56vN7wm8LNCUwxrhVazKEbZu8
	IkHan8zmoP8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F238760F0;
	Sun,  6 Nov 2011 14:10:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA94B60EE; Sun,  6 Nov 2011
 14:10:43 -0500 (EST)
In-Reply-To: <20111106004257.GG27272@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Sat, 5 Nov 2011 19:42:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06865032-08AB-11E1-966D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184924>

Thanks for detailed reviews, Jonathan; looking forward for a re-roll, as I
think the general direction the series seems to be aiming to go is good.
