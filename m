From: Patrick Schleizer <adrelanos@riseup.net>
Subject: Re: [Whonix-devel] git log --pretty="format:%H$t%aN$t%s$t%G?" --show-signature
Date: Thu, 04 Dec 2014 20:29:11 +0000
Message-ID: <5480C417.4050805@riseup.net>
References: <54809802.6030609@whonix.org> <871tofuw7h.fsf@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: whonix-devel@whonix.org,
	Patrick Schleizer <patrick-mailinglists@whonix.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 04 21:29:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwd1h-0000Hr-3L
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 21:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933158AbaLDU3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 15:29:21 -0500
Received: from mx1.riseup.net ([198.252.153.129]:52151 "EHLO mx1.riseup.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753186AbaLDU3U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 15:29:20 -0500
Received: from berryeater.riseup.net (berryeater-pn.riseup.net [10.0.1.120])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
	by mx1.riseup.net (Postfix) with ESMTPS id EEF4041C22;
	Thu,  4 Dec 2014 20:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1417724960; bh=jUPUriHlQpHHXwST74d6h0gMtKs2Sq/Wz0T0sP9cqEk=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=EtmTwnAhq+sq76SZYyjw213FiC2MaknONOTcdr7ZhWnD2wwFDZa988fyRp1xImh/v
	 NpuGVG6O1vIa9vskIE+RO5gIBZAq8Bnz/HYSVWGGFm0JQkONpi0tKcXR6YksoGPqma
	 T8fbtFU/QwckR5sa6qmtOJJjNE/TVgUbhVFmg/p8=
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(Authenticated sender: adrelanos)
	with ESMTPSA id 44AD7432C8
In-Reply-To: <871tofuw7h.fsf@gnu.org>
X-Virus-Scanned: clamav-milter 0.98.4 at mx1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260797>

Thanks Mike!

Mike Gerwitz wrote:
>> Mike, could you please put your various git commit verification helper
>> scripts into a publicly visible?
>
> You can use this:
>
>
https://gitorious.org/easejs/easejs/source/ee85b058df783ffaa9f8d5ae58f9eb6d7586b0ca:tools/signchk
>
> But note that the default value of the `chkafter' var is
> ease.js-specific.

Do you have script somewhere in public git that also checks the web of
trust?

For your blog post it would be nice to have a ease.js unspecific one.

Otherwise I just wait for our updated blog post and/or for my distro to
upgrade to git 2.1.

Cheers,
Patrick
