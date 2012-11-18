From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: Auto-repo-repair
Date: Sun, 18 Nov 2012 11:37:57 -0500
Message-ID: <CAM9Z-nn1S9JvfcymotOvSis4CoYco0Htn4uoETZn2kCto0z9zw@mail.gmail.com>
References: <20121116190004.GA2310@sigill.intra.peff.net>
	<075f74ff-cafb-4021-ba4d-2474b6fb1853@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Enrico Weigelt <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Sun Nov 18 17:38:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta7ss-0005NL-GG
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 17:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633Ab2KRQh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 11:37:59 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56594 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab2KRQh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 11:37:58 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1637890bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 08:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yo3YO/pgF4elgZfVp1AeKYeVkt/s9QnnpxIahAEFYtQ=;
        b=IHVhvSwX4MHdNFk9s3GqLNwh8qmTIxpAzam4cYKDzRUDjJvmIod2bj72l5kQR9lnDQ
         bBON+8uMO/gXLYnoddif70Ub5oup7N6Yy+vsatcWiY1hMDoteNk5JCI5XBkamohnOZcl
         ZfoHu5CMKm2miTl+zDff+VKrU9Kh+DTMtLURG7/qONrwU23WwFoOvZmJFGKL/GcuGd7W
         9rONcvhE2sIHvMMbk6VnGj4z0803IcDwGm+KOaOccDUwDvGzYOLfVQC3aP1YDsPLu/uZ
         04pxIsnmYhLGhUaalyGRF9AZIryutQxkftGw6fujkY1UtVfgwqTuDrcHPWYHy2cJqu75
         eqeg==
Received: by 10.204.4.80 with SMTP id 16mr3934320bkq.73.1353256677541; Sun, 18
 Nov 2012 08:37:57 -0800 (PST)
Received: by 10.205.122.144 with HTTP; Sun, 18 Nov 2012 08:37:57 -0800 (PST)
In-Reply-To: <075f74ff-cafb-4021-ba4d-2474b6fb1853@zcs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210030>

On Sat, Nov 17, 2012 at 4:21 AM, Enrico Weigelt <enrico.weigelt@vnc.biz> wrote:
> Hi,
>
>> You can't reliably just grab the broken objects, because most
>> transports
>> don't support grabbing arbitrary objects (you can do it if you have
>> shell access to a known-good repository, but it's not automated).
>
> can we introduce a new or extend existing transports to support that ?

How would the broken repository be sure of what it is missing to
request it from the other side?

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
