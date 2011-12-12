From: Mathieu Peltier <mathieu.peltier@gmail.com>
Subject: Re: Access to git repository through squid proxy: The remote end hung
 up unexpectedly
Date: Mon, 12 Dec 2011 10:25:55 +0100
Message-ID: <CACjeFCCnm91jz-CZ3QmHwZOoQzvECD=LWP_W+vviO7m8QaxM2Q@mail.gmail.com>
References: <CACjeFCA4h_w2UmYywMBV_P+YZcWAE=zRUz-z5eTfAO+oxWKPjw@mail.gmail.com>
	<20111210225818.GM2525@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 10:26:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra293-0000sK-TZ
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 10:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131Ab1LLJZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 04:25:56 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58172 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab1LLJZz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 04:25:55 -0500
Received: by iaeh11 with SMTP id h11so2934139iae.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 01:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Cmy5tbPJ2FV/uo0Pxk1bFwa1loLyv/0GnIqqNnvQOjU=;
        b=qpPQWIuiHnjt21cVMm8xst0i8p28f9Jjsi+4R5C1erpZk+aozTV9/eDTZzWsk98EKk
         tvhFFPjN2z1galQa3mKmV8yJOuYAKVa6lh+D8/znmYb/G4LA7f9NcqjDhs/8DYqFzj8A
         8nGe5k0Y1SMo9nDQZ1B3p5fHy8ZXDA4hc8/5w=
Received: by 10.42.135.69 with SMTP id o5mr12037255ict.34.1323681955298; Mon,
 12 Dec 2011 01:25:55 -0800 (PST)
Received: by 10.231.33.11 with HTTP; Mon, 12 Dec 2011 01:25:55 -0800 (PST)
In-Reply-To: <20111210225818.GM2525@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186900>

> Looks like either your socat supplies incorrect credentials or proxy
> does not ask socat to actually authenticate and just denies the request.

The problem is solved. Sorry in fact it was just a problem with the
proxy configuration: the squid proxy was configured to use another
proxy server which was denying to use HTTP connect on 9418 port...
Thanks for you help.
Mathieu
