From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Again with git-svn: File was not found in commit
Date: Tue, 28 Apr 2009 02:40:49 -0700 (PDT)
Message-ID: <m3ws95nml5.fsf@localhost.localdomain>
References: <747CFDA3-AC27-44EB-A69C-BF9C29B05A31@kineticode.com>
	<20090421180231.GB16642@dcvr.yhbt.net>
	<8EDD65AC-9C25-4281-86F6-E52A41331B00@kineticode.com>
	<20090426015300.GA17212@dcvr.yhbt.net>
	<81EFD289-5E46-4B27-8DA4-C2039915CE2D@kineticode.com>
	<m31vrfq11w.fsf@localhost.localdomain>
	<30DE35DA-2D44-43C9-B6B9-E4DEDC3D8F6C@kineticode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: "David E. Wheeler" <david@kineticode.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 11:41:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyjop-0007d2-6B
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 11:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757569AbZD1Jkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 05:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754625AbZD1Jkw
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 05:40:52 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:61111 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756780AbZD1Jkv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 05:40:51 -0400
Received: by wa-out-1112.google.com with SMTP id j5so231316wah.21
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 02:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=W+gYdC8Csr6iSz5W+f5BcP+Sqw3jarlD7rAP2J+Ad+c=;
        b=YwnOVNzgGEniec4o3Z/osHWbzor4JVkAGp4FfxtVL+hoouJXewdbHPvQfPOgbRdDsL
         frxc0vhco86ja3s4tJiof4NYSUuUXiC0I6ELONGd5UmxTQE6lPZBa4JDKRfPXPhU6GLz
         hHKK01Y4LXvwEuvakZqqrpkqQPoEkvcGA3ZP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ia0e0UVKo3qVKQzledTBlPrxOtEVy6pMDwmdOa/0Iqx07IT4kqB3BfaLo4qutpAgCm
         FftlGyw+anhMbhxTYDyHBvVUL23II9FbI/kKcCF/fUgzVaZ58REbOtvxCquktoD8dydj
         1AVXKl//FBPmqASXqqc2DLhPlQwWBk2JcGcIw=
Received: by 10.114.185.8 with SMTP id i8mr3022051waf.85.1240911650839;
        Tue, 28 Apr 2009 02:40:50 -0700 (PDT)
Received: from localhost.localdomain (abvq17.neoplus.adsl.tpnet.pl [83.8.214.17])
        by mx.google.com with ESMTPS id j26sm3554534waf.46.2009.04.28.02.40.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Apr 2009 02:40:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n3S9eCW3019380;
	Tue, 28 Apr 2009 11:40:18 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n3S9doDE019367;
	Tue, 28 Apr 2009 11:39:50 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <30DE35DA-2D44-43C9-B6B9-E4DEDC3D8F6C@kineticode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117759>

"David E. Wheeler" <david@kineticode.com> writes:

> On Apr 26, 2009, at 1:17 AM, Jakub Narebski wrote:
> 
>>> [Finally]: http://justatheory.com/computers/vcs/git/bricolage-to-git.html
>>
>> Thank you for posting this detailed analysis.
> 
> My pleasure; hopefully someone will get something out of it to help
> with *their* migration. I'll likely publish some final notes and the
> scripts I wrote sometime this week.

BTW the above story was mentioned in "Perlbuzz news roundup 2009-04-27"
http://perlbuzz.com/2009/04/perlbuzz-news-roundup-2009-04-27.html

P.S. Any relation to David A. Wheeler (http://www.dwheeler.com/blog)?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
