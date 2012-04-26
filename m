From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] gitweb: Option to not display information about owner
Date: Wed, 25 Apr 2012 21:39:03 -0700
Message-ID: <xmqqy5pj9kew.fsf@junio.mtv.corp.google.com>
References: <20120403132735.GA12389@camk.edu.pl>
	<20120416213938.GB22574@camk.edu.pl>
	<201204180136.08570.jnareb@gmail.com>
	<201204191807.32410.jnareb@gmail.com>
	<20120424174114.GC15600@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Thu Apr 26 06:39:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNGUE-0005RA-8M
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 06:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522Ab2DZEjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 00:39:06 -0400
Received: from mail-wg0-f74.google.com ([74.125.82.74]:49024 "EHLO
	mail-wg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab2DZEjF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 00:39:05 -0400
Received: by wgbdt11 with SMTP id dt11so36726wgb.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 21:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=k56fOaw6hqm33N3k0iIzaxAyYgw/GSknns4Vmi25pPE=;
        b=B6SFkZYy74iPfCcCrT9/KkguaeNHULNdfqwKV/80nta3QmJegETOqsENi2/jP4gwP7
         W+S5IdTwaWr/6eS2fDH1tSz7NUlTuvG1SS8u7P3SOY+KLmsDvKAx72wgHsqbSqgymC7G
         vqpKl0eVZQMQiOo3gT+vjHCw0SSOoT/DYCaFAVrxdZMJCr7VK/lLwa2dFEHDiwJEbW1d
         mU4JLJHu6ypH0AN8SKW8cOdzWTD182N+SRpVgFWGSIFOxUyp1e1UhNH467Vm40p0e+Fv
         yTp/1mCnkgNbx8fCduNmNzsLskO6ZxxdVXNvrPRyGfJdAAPAZK3AhDuW6nrMDeLJ5KFy
         cEOg==
Received: by 10.213.22.197 with SMTP id o5mr498429ebb.8.1335415144316;
        Wed, 25 Apr 2012 21:39:04 -0700 (PDT)
Received: by 10.213.22.197 with SMTP id o5mr498418ebb.8.1335415144167;
        Wed, 25 Apr 2012 21:39:04 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id s9si1743818eei.3.2012.04.25.21.39.04
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 25 Apr 2012 21:39:04 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id F29D420004E;
	Wed, 25 Apr 2012 21:39:03 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 4E617E125C; Wed, 25 Apr 2012 21:39:03 -0700 (PDT)
In-Reply-To: <20120424174114.GC15600@camk.edu.pl> (Kacper Kornet's message of
	"Tue, 24 Apr 2012 19:41:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkwhAsfkvoT5n+vKOeLs0sB69vJbTHjQy8vZkbxgwvzMNM1AwtFXrYPx6EIyamlDC5yD0tIrODq3s6PMnO//dXoodMenb21oPqRiUZgXZoznV98zfRC3b3EKk4z3wT8TXGoAvo9REfhZ095HvPo1do91r39/sZUvRjvfDE5YT0AkPnkZOU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196351>

Kacper Kornet <draenog@pld-linux.org> writes:

> In some setups the repository owner is not a well defined concept
> and administrator can prefer it to be not shown. This commit add
> and an option that enable to reach this effect.
>
> Signed-off-by: Kacper Kornet <draenog@pld-linux.org>

Among your recent three patches, this one seems to break t9500; has it
been tested?

[Thu Apr 26 04:32:36 2012] gitweb.perl: Use of uninitialized value in string comparison (cmp) at /srv/git/t/../gitweb/gitweb.perl line 5551.
[Thu Apr 26 04:32:36 2012] gitweb.perl: Use of uninitialized value in string comparison (cmp) at /srv/git/t/../gitweb/gitweb.perl line 5551.
[Thu Apr 26 04:32:36 2012] gitweb.perl: Use of uninitialized value in hash element at /srv/git/t/../gitweb/gitweb.perl line 5401.
[Thu Apr 26 04:32:36 2012] gitweb.perl: Use of uninitialized value in hash element at /srv/git/t/../gitweb/gitweb.perl line 5401.

I am guessing both #5401 and #5551 are $it->{'category'} of @projects[]
elements.
