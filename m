From: "Chris Riddoch" <riddochc@gmail.com>
Subject: Re: [PATCH] gitweb: Do not use absolute font sizes
Date: Wed, 9 May 2007 00:48:02 -0600
Message-ID: <6efbd9b70705082348t720c2396l58dad56fd18bd84e@mail.gmail.com>
References: <6efbd9b70705071613p23017509qaf9af12c1d14f9cb@mail.gmail.com>
	 <20070509014150.7477.48489.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Petr Baudis" <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Wed May 09 08:48:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlfy4-0000ZX-GT
	for gcvg-git@gmane.org; Wed, 09 May 2007 08:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966586AbXEIGsF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 02:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967745AbXEIGsF
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 02:48:05 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:26815 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966586AbXEIGsE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 02:48:04 -0400
Received: by nz-out-0506.google.com with SMTP id o1so91436nzf
        for <git@vger.kernel.org>; Tue, 08 May 2007 23:48:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hyOl9Jd0LWMiRcHWIgdNwPuCw9c2h4ptm8p8WOtHmMMwxWUXVyUYgcDuWSrSDKc4GNAp/2Q+qoW/eNzWgTBAeAbvV2gRgpd9egECAcN/JpDdBaFcgtrW7eFPLni5PKZpaMceQhHAc9lCwEcSf7N47Y1DzVOU3Cvox0tIfYy561M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=griVtuPIhGa7bx0AN88MKmj9KsE/BvUXAd02YVlnOqQXjnYvuiFhObArRsnkv6Xxx2BudRWZvwypG0R7A+wfQtyfgrYNdxi4E+BQ9Lm+TOodGK87Bb2lGCy9dqJu+sAvRvZSczlYHlV+0XS8gH0uCoGov1uwkCffmaBfOFe7y6Y=
Received: by 10.114.210.2 with SMTP id i2mr87768wag.1178693282983;
        Tue, 08 May 2007 23:48:02 -0700 (PDT)
Received: by 10.115.22.19 with HTTP; Tue, 8 May 2007 23:48:02 -0700 (PDT)
In-Reply-To: <20070509014150.7477.48489.stgit@rover>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46670>

On 5/8/07, Petr Baudis <pasky@ucw.cz> wrote:
> Avoid specifying font sizes in pixels, since that is just pure evil.
> Pointed out by Chris Riddoch.

Thanks!  It's definitely a step in the right direction.

In my browser, the decent-sized fonts make it apparent that we're
trying to fit a lot in a limited horizontal space.  In particular, the
links (commit | committdiff | tree | snapshot) wrap in the space
provided, for me.  I dropped my default font size a little, and it's
just fine... but it does make me think, perhaps that's something where
either icons or abbreviations (with an appropriate key) might improve
the appearance of the page.  Perhaps something like: C | D | T | S.
It might even let us put more functionality in and improve our use of
whitespace even more.

I like it.

-- 
epistemological humility
  Chris Riddoch
