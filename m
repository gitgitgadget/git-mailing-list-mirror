From: Mathieu Peltier <mathieu.peltier@gmail.com>
Subject: Re: Access to git repository through squid proxy: The remote end hung
 up unexpectedly
Date: Sat, 10 Dec 2011 18:56:57 +0100
Message-ID: <CACjeFCCRtJn=JL0v5kJt2wNSDpQyYBme6B0_OpHo4LOVyie89Q@mail.gmail.com>
References: <CACjeFCA4h_w2UmYywMBV_P+YZcWAE=zRUz-z5eTfAO+oxWKPjw@mail.gmail.com>
	<20111210193753.994055f2.kostix@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Dec 10 18:57:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZRAX-0007DX-0P
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 18:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290Ab1LJR5A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Dec 2011 12:57:00 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:32853 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab1LJR47 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2011 12:56:59 -0500
Received: by iaeh11 with SMTP id h11so502451iae.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 09:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3i9X8WzRs8bhMzgu47haYeqWtl8yuM2pbrJz4qCVbfE=;
        b=cajYarON+nqIyU/0smGIwIQg5sv/yV6kGe3lV6NoKFx/gTs9I1tDnjhHQ0AiERfC8X
         3IZlBM1gb8zYPQtHDIgPjwy16xWZ/UpBoL5/+VjGlQofUzUR8lsxEEB3/9bfz/XdQdDA
         TBuVpTO2TMtNaINyBx79eLjH2zMGs/Qs9X8KM=
Received: by 10.50.149.162 with SMTP id ub2mr8271785igb.70.1323539817594; Sat,
 10 Dec 2011 09:56:57 -0800 (PST)
Received: by 10.231.33.11 with HTTP; Sat, 10 Dec 2011 09:56:57 -0800 (PST)
In-Reply-To: <20111210193753.994055f2.kostix@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186787>

> What happens if you try to clone a git repo directly, without any
> tunneling? =A0If this is not possible, try to clone on the host runni=
ng
[...]
> As a side note: why are you trying to implement such a strange setup?

It works from another machine without proxy. In fact I am trying to
allow use of git in a corporate environment (for example to access
read-only git repositories of sf.net only accessible through git
protocol). See for example:
http://www.emilsit.net/blog/archives/how-to-use-the-git-protocol-throug=
h-a-http-connect-proxy/
Thanks.Mathieu
