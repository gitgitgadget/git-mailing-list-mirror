From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: 'git clone' doesn't use alternates automatically?
Date: Sat, 31 Jan 2009 13:08:02 -0800 (PST)
Message-ID: <m3tz7fw5ek.fsf@localhost.localdomain>
References: <885649360901301412jd5c6b0dne1eff1ff00dd043e@mail.gmail.com>
	<20090131071238.GC3033@coredump.intra.peff.net>
	<885649360901311208s4bc17ae3me2062b07b302291e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 22:09:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTN5q-0005ib-UV
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 22:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbZAaVIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 16:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752441AbZAaVII
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 16:08:08 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:14728 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbZAaVIF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 16:08:05 -0500
Received: by fg-out-1718.google.com with SMTP id 16so287741fgg.17
        for <git@vger.kernel.org>; Sat, 31 Jan 2009 13:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=hKxW6i4cCB1o3+HG7d2cHu5LYuE5SoFq8su8H8sOHB0=;
        b=VSVsGsxcEkIUtypCyQwQxSH2Ye1NozjqF8SGZu+cDf7tI18KA4Q5JtYozDMHPRC5WC
         v7DELiORRWrIOBYmKPkiO4zlV6PKDtjw5B4+3ec4KLu8UlkcBDirPmPJuwRU4wlKgM5A
         HtnqlYLMv0GBBDPHvAml6lAhSzH4JaAClbZpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=gJjpbPCBp4+nIkABUZyio4V7t42Mxu8XkzFj3LfCkup5TixFHnycWCOruCQUHXRcyL
         RPKszcA92Z/bOf29v9+UtJ6TjFxvIDDIjS2H7X1Bf36kMA3+AKD13A5lxgn76TEI4m1q
         K4jv1zoNGXQ948V1KT55ikkPQa9jlrJq4YQLI=
Received: by 10.86.29.8 with SMTP id c8mr1415387fgc.19.1233436083811;
        Sat, 31 Jan 2009 13:08:03 -0800 (PST)
Received: from localhost.localdomain (abvw163.neoplus.adsl.tpnet.pl [83.8.220.163])
        by mx.google.com with ESMTPS id e11sm2572640fga.30.2009.01.31.13.07.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jan 2009 13:08:02 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0VL7u17001155;
	Sat, 31 Jan 2009 22:07:58 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0VL7loT001152;
	Sat, 31 Jan 2009 22:07:48 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <885649360901311208s4bc17ae3me2062b07b302291e@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107939>

James Pickens <jepicken@gmail.com> writes:

> So, is there any reason 'git clone' shouldn't automatically use
> the alternates that it copied into the new repository?  I might
> look into writing a patch if nobody objects.

Alternates are fragile with respect to garbage collecting in the
repository you borrow objects from.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
