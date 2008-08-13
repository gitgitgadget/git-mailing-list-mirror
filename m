From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: pack operation is thrashing my server
Date: Wed, 13 Aug 2008 05:43:15 -0700 (PDT)
Message-ID: <m3abfht7a9.fsf@localhost.localdomain>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ken Pratt" <ken@kenpratt.net>
X-From: git-owner@vger.kernel.org Wed Aug 13 14:44:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTFiB-0007tr-Na
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 14:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbYHMMnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 08:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbYHMMnT
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 08:43:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:9407 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbYHMMnT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 08:43:19 -0400
Received: by fg-out-1718.google.com with SMTP id 19so11326fgg.17
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 05:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=oxdD3Pw8daWkzXBYKccNu3M9Ya6PueYolKiEd9BSRV4=;
        b=a7/bX3oAbhCvId2TNVeER9Jho+6/DLG1DAw3x+G+J3Dj3/kKBPODwa5tG4c5Ib51uY
         4tKvWj5bGtMHdLpjlb64RZ71tg1j0U5y3pD3/6wr4TgOj74N1IXGNz6V5lf5oGNzbssd
         9gLhzcr7+bvSFGx9s4QXzf0UlCP4NQIW8nMIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=K4+IYgtz3VWZZjNBNz/lW5OLPnKjdzJ0kyHX/wOT2HD54PSC1dLfiIikE8fwBXhL+O
         9t8HGGL9kRG9doGC61UAJnGHUhn+ZrwIRhYE3+IgHTzkaVD2E3GX6FfBzTusG/lqRjr8
         9THy3p6B3kR3GP8ipVDdnJvDCCr/X1v2x0VQU=
Received: by 10.86.95.20 with SMTP id s20mr12360229fgb.49.1218631396958;
        Wed, 13 Aug 2008 05:43:16 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.245.20])
        by mx.google.com with ESMTPS id 3sm628596fge.3.2008.08.13.05.43.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Aug 2008 05:43:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m7DChCfL020141;
	Wed, 13 Aug 2008 14:43:12 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m7DChAsm020137;
	Wed, 13 Aug 2008 14:43:10 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92213>

[...]

If I remember correctly there were on git mailing list some patches by
Dana How which put an upper bound on the size of individual objects
going to pack; objects with size above threshold would be left as
loose object (and shared via network drive).

Unfortunately if I remember correctly they were not accepted in git.
You can try to pack large objects into separate pack, and .keep it,
or try to ressurect the patches from git mailing list archive.

HTH.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
