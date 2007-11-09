From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: git on ancient compilers.
Date: Fri, 9 Nov 2007 18:22:41 -0500
Message-ID: <9e4733910711091522x50e9a1ddo8a6b2a79037822cc@mail.gmail.com>
References: <9e4733910711091514k55473201jf29434961f01e46c@mail.gmail.com>
	 <9e4733910711091519r75692418hec2fbd7ccea5771b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 00:23:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqdBy-0000RD-4F
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 00:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbXKIXWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 18:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbXKIXWt
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 18:22:49 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:16518 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760597AbXKIXWr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 18:22:47 -0500
Received: by rv-out-0910.google.com with SMTP id k20so590061rvb
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 15:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=lu5imTH0RCoLQZi/8qNRnY9hxtNWIzuxbNQ75ZPbTIc=;
        b=pJqZncppWDWHhMwHVmzIQxbYUlw1FaPGp4O5Mc719q6dMEauw57JiH6Y7RgxSUs/LcBo5tnd9FrmNNLD+prlSnMQ5EUy1tAhS8rSOnz9VIQ/wo4yLtpZD5qsgTgit5EGH1VbO3dbfZtoXUJ9y77fRlQ7u82oNQ1uKnhMzdbVhdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HAyAh9i5vg3KFXnBVofbfR7bYnELgExtO15KYKeq777YzAv4O2YPA+lsew/fDPgYmTkvfu6JMnCAds+5ol4fpVQXkmw1Yphc5zPS+tm0YGzk6DI+8q40gH+eWjO8kv7f/Nowe9X7pholkn08q5c5hEq9tqrU4ke6d2RRFJagTKo=
Received: by 10.114.199.1 with SMTP id w1mr980124waf.1194650566834;
        Fri, 09 Nov 2007 15:22:46 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Fri, 9 Nov 2007 15:22:41 -0800 (PST)
In-Reply-To: <9e4733910711091519r75692418hec2fbd7ccea5771b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64276>

I found this option...

# Define NO_R_TO_GCC_LINKER if your gcc does not like "-R/path/lib"
# that tells runtime paths to dynamic libraries;
# "-Wl,-rpath=/path/lib" is used instead.

-- 
Jon Smirl
jonsmirl@gmail.com
