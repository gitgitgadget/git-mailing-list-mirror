From: AI <ai0867@gmail.com>
Subject: Re: git-am strips final ')' character from author name
Date: Sun, 21 Sep 2008 12:51:07 +0200
Message-ID: <2f54d7a20809210351l4f97f953ge0eade46f160c7f0@mail.gmail.com>
References: <2f54d7a20809191057t76c405e7q643912388efe2f01@mail.gmail.com>
	 <2f54d7a20809191058w558f3a28nc1537dc82f4a6ec2@mail.gmail.com>
	 <20080921101808.GD3376@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 21 12:52:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhMYD-0007ON-A8
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 12:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbYIUKvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 06:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbYIUKvK
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 06:51:10 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:7686 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbYIUKvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 06:51:09 -0400
Received: by qw-out-2122.google.com with SMTP id 3so109609qwe.37
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 03:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=F6wIvgokZoMYC9v9L2Jdu5qVeWM1n16IuolbKjjZ/fI=;
        b=GxQWmaJm//RHwwd3/aNjz/+elI7yQ2PLRuh81LsZb7iwbUEXpyR2UwW+9CAo3BmlDe
         J7HPORwCBdqV0XZ/Zv9OZcVfkCxvE4sjjQ+owLltJT82u75z0aGMSboHQn23rEtTouD/
         uvv7vBbnVza9W2cFX5icZCQJ3/jBg0+SrufZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KJHSRfkvhfkYVffn5mnfaM/jDjKYgFPsDEsdKuPvTJ8nQhzhWtXGTqzeUoxfi6KUBo
         UjrHkX3865WqxFFfHR41YfNSS5qL7b3V2WRtZrtq825R+nfTIsyyrmXdIYmNL/SH21/z
         e2ZikSCJle2HrXRV77bNLzE9ARBm/ydigSIbU=
Received: by 10.215.66.19 with SMTP id t19mr1692594qak.64.1221994267495;
        Sun, 21 Sep 2008 03:51:07 -0700 (PDT)
Received: by 10.214.45.2 with HTTP; Sun, 21 Sep 2008 03:51:07 -0700 (PDT)
In-Reply-To: <20080921101808.GD3376@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96390>

On Sun, Sep 21, 2008 at 12:18, Jeff King <peff@peff.net> wrote:

> Are you using 1.5.x? This seems to be fixed in v1.6.0 by 0d4ede9f
> (mailinfo: better parse email adresses containg parentheses).

I'm using 1.5.4.3, even ubuntu intrepid still uses 1.5.6.3.
Ah well, more reasons to switch to debian.
