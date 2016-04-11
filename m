From: pedro rijo <pedrorijo91@gmail.com>
Subject: meaning of SP on ls-tree docs
Date: Mon, 11 Apr 2016 18:04:42 +0100
Message-ID: <CAPMsMoDKCwCL17SZt8AZyX_6WyiAMHGWJ2S77QBc983uHtYL6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 11 19:05:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apfHE-0008T3-NY
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 19:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826AbcDKRFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 13:05:24 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34642 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbcDKRFX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 13:05:23 -0400
Received: by mail-lf0-f51.google.com with SMTP id j11so165724741lfb.1
        for <git@vger.kernel.org>; Mon, 11 Apr 2016 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=aCDH+XC2RVwD1uUAvxxJg7pwih7hTTiBZcQ+I4hSFoY=;
        b=q8hh/eRX5zrLz3nyxepI+cGkp5rNTTNF7B7947FI8fBy2zlPhF8tXxRAryCYtmLusm
         xL0+WP5/OygGIqgFQnidCLWj3a7/X1S1/HaWg0i760fhROrc9gSHCVEtGF6doY+z6w/f
         c+11Upc0nhZB39Y8Z9fin4F4efSVESjsIXAmA+5YgXDNUosRniR+WPBQOheqLi2tZrR8
         AellaUzjnbDdZ6BFlIf+0rucESoo/NuY80uG40EMDmWhFuub/eeXkxi0OI1S4/4bkfwQ
         E0WgZJocFV/UnnS9ofW/3UL6LTYFpoYeFfvpUkQMIwTelF4HA39F+ubZZE9/cUdL/9w1
         NCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aCDH+XC2RVwD1uUAvxxJg7pwih7hTTiBZcQ+I4hSFoY=;
        b=fdoTFVBtosIzzsVdekBjk9LmlvdoF0ZI84Kw9WY1wUHb28zKftuHj7bdCz+XJfD6rH
         3fH7l0GNg47wGweYELcSLRjBQx2U01JyoJXTNRoOQRHZ5CmQn04QGPaM6mNe315tuq6y
         jO8LvAYQ2ZUIPb+57+sN9+zuN3Pr3GlsO7x4wei8CRY3FTIaMe/iFxpUOkFTvrNTPOnI
         4H/DA4YInoBLD+v97cx3MafDn37E4aTw+ZOYKgRK5wfc79yRA35PmK+ALl6eesBIcB98
         z4xPENHHsOrnwEhfv/DRQ0k2Dn0m2xmMeVOeplJ3GWx6kHXCC+/87tqKK4KZuZKkHEr4
         DsoQ==
X-Gm-Message-State: AD7BkJJ60yryURYXUn8rrB4RmWcvL/rtui+mwHlTRnSq9VrrB3K1ey/8cYW9T9+Ohz+DlcJ7aevyapNv3u3bIQ==
X-Received: by 10.25.208.144 with SMTP id h138mr6812617lfg.48.1460394321972;
 Mon, 11 Apr 2016 10:05:21 -0700 (PDT)
Received: by 10.112.239.6 with HTTP; Mon, 11 Apr 2016 10:04:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291222>

Hey,

On https://git-scm.com/docs/git-ls-tree#_output_format, the format is
presented as <mode> SP <type> SP <object> TAB <file>

But what is SP? Couldn't find the meaning. Space? System separator?

-- 
Thanks,

Pedro Rijo
