From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 13/14] Allow flexible organization of notes trees,
 using both commit date and SHA1
Date: Sat, 12 Sep 2009 16:37:49 -0700
Message-ID: <7vzl8zbupe.fsf@alter.siamese.dyndns.org>
References: <200909121752.07523.johan@herland.net>
 <1252771728-27206-14-git-send-email-johan@herland.net>
 <7viqfof1kc.fsf@alter.siamese.dyndns.org>
 <200909130033.28666.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org, spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Sep 13 01:38:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmcAj-0007XB-Q2
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 01:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbZILXiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 19:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbZILXiM
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 19:38:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37690 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbZILXiM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 19:38:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7EA5F4EC13;
	Sat, 12 Sep 2009 19:38:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pjcELSIarWZFK/vjDp9czp2Q8SU=; b=I0YgMh
	BDGonDuryVD+DxiahLcA1fgM4vl6zolIF7UHr5rmQgZmVyppLjWPl1t4at9g7sqD
	IPmVhTvKbpOZOSphA4U6riG87zffxU6Royx2vEGWS7hPfnqX67XRO5BZw6UCZ4Ry
	5AoR8jPFlHh1NuU/uk4Z7uWnCAIQSEl9qztmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xGqt82fRkl+93kulZwbzTt4+dWi2R1mO
	RxQ7q2MTbMm4N/MdkWlfpqGfMg02F43ixcEM1RxiGbVUrAbQKu7o5dgiBCVfxQoN
	VLqOWz57QDYUEc2eJvTwMvB8zK/3JjDgCWuSMVxslU47GVZmRMCmBJcGEpCOHgUj
	BJTLkwjMibU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 160E14EC0A;
	Sat, 12 Sep 2009 19:38:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BDA6E4EC08; Sat, 12 Sep 2009
 19:37:50 -0400 (EDT)
In-Reply-To: <200909130033.28666.johan@herland.net> (Johan Herland's message
 of "Sun\, 13 Sep 2009 00\:33\:28 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 521233A2-9FF5-11DE-97DC-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128314>

Johan Herland <johan@herland.net> writes:

> But as I said above, you may want to drop 13/14 and 14/14 completely, 
> instead.

Thanks.  Will do.
