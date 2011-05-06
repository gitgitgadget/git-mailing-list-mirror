From: Junio C Hamano <gitster@pobox.com>
Subject: Re: error with $ git push origin HEAD:newbranch
Date: Thu, 05 May 2011 21:56:38 -0700
Message-ID: <7v39ks4ebd.fsf@alter.siamese.dyndns.org>
References: <loom.20110505T103708-225@post.gmane.org>
 <20110505093752.GB29595@sigill.intra.peff.net>
 <loom.20110505T114511-660@post.gmane.org>
 <20110505105914.GA464@sigill.intra.peff.net>
 <loom.20110506T034552-210@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: chris <jugg@hotmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 06:57:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QID67-00074o-19
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 06:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602Ab1EFE4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 00:56:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61034 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400Ab1EFE4q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 00:56:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8D9335F08;
	Fri,  6 May 2011 00:58:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x7BEcTZYq/73ZRwKKsUllMa10II=; b=GPVBXD
	RQLf5vKvATD6Q0Hqi5BBzKOXBVV29X7VXGdgnF8lx9xy/Fws5W2voX3Ev1+Wfbza
	zyI1xicylxdsrsApSkIIp/NKBJW4i55Ezlv2BV11OqbvgFSRMol+M6hlWb7h05Fb
	4slSvt7D0ejIzYySPF/bxJN2P5NY7QRU7EE+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VjOjp7QcrEw1Srw1YjfczGOZSz7FG9l9
	+/YYibLxHMGSKHp0Is8+3HIsOWT7M634BcOpY5WyNTv4k4zb+S8G72Tv6yHTCdzG
	34aa9sXo1dTEqSD1SRZdvQrW3d07FWlPnHG4QmMpcWTEuqcf0fDQcR96hWT8H9vh
	y1lLw4QG1ls=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6BCAD5F07;
	Fri,  6 May 2011 00:58:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 895435F06; Fri,  6 May 2011
 00:58:43 -0400 (EDT)
In-Reply-To: <loom.20110506T034552-210@post.gmane.org> (chris's message of
 "Fri, 6 May 2011 02:16:03 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 860BEA5A-779D-11E0-A512-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172939>

chris <jugg@hotmail.com> writes:

> All of that to say, it isn't exactly clear what one should expect.

The take-home lesson is that if you want to be explicit and exactly clear,
you can and should spell things out in full, and you can sleep well at
night if you did so.

	# Let's call retroactively v1.5 without the last three topic
        # merges the v1.4.9 release...
	$ git push origin v1.5~3:refs/tags/v1.4.9
