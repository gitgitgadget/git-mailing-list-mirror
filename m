From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.10
Date: Tue, 10 Apr 2012 11:43:46 -0700 (PDT)
Message-ID: <m3398bbf7y.fsf@localhost.localdomain>
References: <7v1uo01ta1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Apr 10 20:44:15 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1SHg33-00025r-Vu
	for glk-linux-kernel-3@plane.gmane.org; Tue, 10 Apr 2012 20:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758668Ab2DJSoB (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 10 Apr 2012 14:44:01 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:60480 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758562Ab2DJSns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Apr 2012 14:43:48 -0400
Received: by wibhj6 with SMTP id hj6so3645832wib.1
        for <multiple recipients>; Tue, 10 Apr 2012 11:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=2Z+EpLTSo+iprYESXQ2YkX2md/w4DAkrc7980iW3D7M=;
        b=rHuluPhlLbykECqlf7TtYTQBx+7BaloUIvHdO6+LtAEARIrYb7jpRNcbP58y6VTYeZ
         ZqHFpdcvqP4Yir0FMasPPPf1UMUgqVEg2P9vos5MFQ0Zy+MF3SvZZlb48d+vQ6kX4fgy
         U9HaUfkCdKeDBzaiJqG8Cnzq8uV7KWOlHqFot+Evy6RyalzmZTvyutig/B975mYyblgx
         6TApWCrcdkfBiJNQkwLpn6c8FheH+hO9m7xHjKhdIysaYctNU1eb71eKVWr9W1aO8JDn
         0VfU5gq6992xdRgZhx7XmGpnqeDzTK7ROJdpzANyrkruci3ANnkHL625mo2o/zu5WpYg
         pD8g==
Received: by 10.216.131.78 with SMTP id l56mr6787637wei.94.1334083426944;
        Tue, 10 Apr 2012 11:43:46 -0700 (PDT)
Received: from localhost.localdomain (acxe73.neoplus.adsl.tpnet.pl. [83.11.162.73])
        by mx.google.com with ESMTPS id ff2sm475475wib.9.2012.04.10.11.43.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 11:43:46 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q3AIhF6h009884;
	Tue, 10 Apr 2012 20:43:25 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q3AIgvJN009874;
	Tue, 10 Apr 2012 20:42:57 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v1uo01ta1.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195118>

Junio C Hamano <gitster@pobox.com> writes:

> Git v1.7.10 Release Notes
> =========================
> 
> Compatibility Notes
> -------------------
[...]
>  * The "--binary/-b" options to "git am" have been a no-op for quite a
>    while and were deprecated in mid 2008 (v1.6.0).  When you give these
>    options to "git am", it will now warn and ask you not to use them.
[...]
> Updates since v1.7.9
> --------------------
[...]
>  * "git am" learned to pass "-b" option to underlying "git mailinfo", so
>    that a bracketed string other than "PATCH" at the beginning can be kept.

So how it is in 1.7.10?  Is "git am -b ..." a no-op, now showing
deprecation notice, or does it pass "-b" to "git mailinfo" to limit
stripping of bracketed strings to those containing the word "PATCH"?

-- 
Jakub Narebski
