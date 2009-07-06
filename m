From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2009, #01; Mon, 06)
Date: Mon, 06 Jul 2009 16:42:34 -0700 (PDT)
Message-ID: <m3r5wtv0nr.fsf@localhost.localdomain>
References: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 01:48:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNxv5-0008DS-Rs
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 01:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834AbZGFXsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 19:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753711AbZGFXsN
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 19:48:13 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:55547 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593AbZGFXsM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 19:48:12 -0400
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jul 2009 19:48:12 EDT
Received: by ewy26 with SMTP id 26so126012ewy.37
        for <git@vger.kernel.org>; Mon, 06 Jul 2009 16:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=wh78YkKi9wZ3YWTK+88rtq8JhdWozxnxfzx6ZdhxBew=;
        b=AcCHJuJlMMjrM9wXQHN6EtgUOI2rYJAJ6w4nA4+pRwyF0YajoNSZdCX9/pKnyJK4tI
         QS9Z9dmujF6cm7icbOoNNPutSqag3m0rGKvm371aavWiPD1psTZiyAtA80o2n1oWnfwS
         j8MEJYJUhvU8/r1/1mxr+eyPWZvXwtnI/Q7Tk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=xSiXqctc2YWEAky968V6mF1joL4s5Y9NHlSUPaHdCj41TWMolHxMWrjoXJcqs40KR2
         lvqTYJ1DO6WdjsqiR8Zf3XBeFyGuhB71fENta0tqu+bd2CB4F6Bpl8+NcAV9g/1y1D1c
         CSBNgMZkD0ow/grcUUF4Ha/N8/I8Gn23dbJ28=
Received: by 10.210.110.5 with SMTP id i5mr6326755ebc.3.1246923755109;
        Mon, 06 Jul 2009 16:42:35 -0700 (PDT)
Received: from localhost.localdomain (abwt137.neoplus.adsl.tpnet.pl [83.8.243.137])
        by mx.google.com with ESMTPS id 28sm1058561eye.46.2009.07.06.16.42.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Jul 2009 16:42:34 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n66NgYob007074;
	Tue, 7 Jul 2009 01:42:35 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n66NgXQD007071;
	Tue, 7 Jul 2009 01:42:33 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122812>

Junio C Hamano <gitster@pobox.com> writes:

> [Actively cooking]
> 
> * gb/gitweb-avatar (Tue Jun 30 00:00:54 2009 +0200) 7 commits
>  - gitweb: add empty alt text to avatar img
>  - gitweb: picon avatar provider
>  - gitweb: gravatar url cache
>  - gitweb: (gr)avatar support
>  - gitweb: use git_print_authorship_rows in 'tag' view too
>  - gitweb: uniform author info for commit and commitdiff
>  - gitweb: refactor author name insertion
> 
> This should be the latest one posted to the list, and I think it is
> reasonable, and Jakub seemed to concur.  Will be in 'next'

I concur.

It is now, after many iterations, well written and nicely crafted
series, IMVHO.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
