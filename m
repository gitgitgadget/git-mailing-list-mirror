From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [RFC/PATCH 4/4] gitweb: Create Gitweb::HTML::String module
Date: Tue, 8 Jun 2010 02:28:31 +0530
Message-ID: <AANLkTimFkRYW2favJYzWasxgC06WFd-LmrcdyaABNwOg@mail.gmail.com>
References: <1275943844-24991-1-git-send-email-pavan.sss1991@gmail.com>
	<1275943844-24991-4-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Mon Jun 07 22:58:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLjPF-0004Wm-Tn
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 22:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512Ab0FGU6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 16:58:33 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53435 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416Ab0FGU6c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 16:58:32 -0400
Received: by gye5 with SMTP id 5so2584420gye.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 13:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Ac6NLUvgt7bWI3Fln2+lmGJSJfdut2Cd3yfSzsTHKzM=;
        b=ITiHNetLN2XIFJjMjaaMTrtp88MKyMPusrVH1AOLuCBfDgpCNFkmrB8ZjgH9dIkpdP
         tEjbTQ5ivDnAZ+a1ABsJdyX/GUBvM6qrgF7FyiBygjcSb9+RPir8xmzAkfLA2jN/xmJq
         6WMZF8YJHx9OfWQDscgspphq9KjRVRqiNwlVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=g32NH2o+F4d6B0T3zn5FuqQg/oSuTmFmfvMjwHSEqjIyGwbrpld92OgjYZI+5hOu7N
         9x2NcbpdODPOZT993ukJrbxIsrhUAENy0/ZQno/nRw88nZLjuVt6hlh31bWiii6QX6jl
         OgT8sQyOyPpAsOqx0a1HkbYWDQYeM3G76iAJA=
Received: by 10.101.10.36 with SMTP id n36mr16168815ani.114.1275944311533; 
	Mon, 07 Jun 2010 13:58:31 -0700 (PDT)
Received: by 10.100.126.20 with HTTP; Mon, 7 Jun 2010 13:58:31 -0700 (PDT)
In-Reply-To: <1275943844-24991-4-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148628>

Would it be enough If I use CGI::span instead of using the $cgi
variable from Gitweb::Request ?

Thanks,
Pavan.
