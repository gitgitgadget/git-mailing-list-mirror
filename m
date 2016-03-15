From: Ivan Tham <pickfire@riseup.net>
Subject: Re: [GSOC] Microproject "Move ~/.git-credential-cache to
 ~/.config/git"
Date: Tue, 15 Mar 2016 13:56:44 +0800
Message-ID: <bd599933c7609c72bf405371b43bf080@riseup.net>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
 <xmqqshztawwd.fsf@gitster.mtv.corp.google.com>
 <CAKqreuwgxzVTAUdZPf9+ivXCdW8F2Ksafw7V0pbLAaRPwGX9Uw@mail.gmail.com>
 <xmqqwpp494vd.fsf@gitster.mtv.corp.google.com>
 <CAKqreuw0hafi-GwWD-UaGKwmG8xVK6ZJDcw2jpQXAAuK+XBZvQ@mail.gmail.com>
 <c74296a0db1cac9daf5da00756ab0313@riseup.net>
 <CAKqreux-m3yHVsEQXdf+8vMNZwC0UCMBWnzbaqYJbdEEM14qiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 06:56:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afhyN-0006Hs-2H
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 06:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933766AbcCOF4r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Mar 2016 01:56:47 -0400
Received: from mx1.riseup.net ([198.252.153.129]:38660 "EHLO mx1.riseup.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753544AbcCOF4p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 01:56:45 -0400
Received: from piha.riseup.net (unknown [10.0.1.163])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
	by mx1.riseup.net (Postfix) with ESMTPS id B03AF1A270D
	for <git@vger.kernel.org>; Tue, 15 Mar 2016 05:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1458021404; bh=sMkvk4X8hnq7J/AEjlcMGH6ttBZKRbE+X6v9GtO5kkc=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=S7ZvqTAau7I9/l3ORDeluxHAp0+ZEf+tnSkzeYF1PfcWE1fFYaUyMYzw4jFBEDV6f
	 y9p3vAi6r5+0TnN+kNRJ9H6sLUKEa/VL8DSRcLqnXNJTN7G7RAypHFZpPohfAuN5Gy
	 48rBpQxcuNiOHDCbmlDReTe6V7ZM84KnQeIRs5+E=
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(Authenticated sender: pickfire)
	with ESMTPSA id 9899B1C02C2
In-Reply-To: <CAKqreux-m3yHVsEQXdf+8vMNZwC0UCMBWnzbaqYJbdEEM14qiQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.99 at mx1.riseup.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288834>

On 15/03/2016 10:59, =E6=83=A0=E8=BD=B6=E7=BE=A4 wrote:
> Well, In my opinion:
>=20
> 1. $XDG_CACHE_HOME is more meaningful than $XDG_CONFIG_HOME,
> while $XDG_RUNTIME_DIR is more meaningful than $XDG_CACHE_HOME.
> However, I feel that I should value suggestions of who have more=20
> experience
> about this project than me.
>=20
> 2. $XDG_CACHE_HOME is absolute, so it's $XDG_CACHE_HOME/git/credentia=
l
> instead of ~/$XDG_CACHE_HOME/git/credential.

Oh, I guess now $XDG_RUNTIME_DIR is really most suitable for this after
reading more about the XDG Standard.
