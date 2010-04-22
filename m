From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Thu, 22 Apr 2010 17:27:23 -0500
Message-ID: <20100422222723.GB12000@progeny.tock>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
 <20100422155806.GC4801@progeny.tock>
 <87wrvzs590.fsf@frosties.localdomain>
 <alpine.LFD.2.00.1004221445310.7232@xanadu.home>
 <87sk6n4426.fsf@frosties.localdomain>
 <x2qc376da901004221448i373a342p1d7b763383e80472@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Goswin von Brederlow <goswin-v-b@web.de>,
	Nicolas Pitre <nico@fluxnic.net>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 23 00:27:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O54rc-00064V-CL
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 00:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830Ab0DVW1L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 18:27:11 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58809 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776Ab0DVW1J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 18:27:09 -0400
Received: by gwj19 with SMTP id 19so2340235gwj.19
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 15:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4vM1I3JRvXTEOIGhhvulgT000SLWx1ttP9fAKFBwW18=;
        b=KQFoOxrrBNUXWgbAPzaGsbugu5FrOcVx1mpqyGWwgnJLgJzSJG9/LVHbw2IgU2yo45
         x3CbQVoN8+GXynbWq+JsGqqX0BPCToUGZFmvbbTsMAJlWp27lWA7y9oA4f4o/Obu8R7F
         XZKZ7Bghzn+/HoCX3Nz/8bcRgBMnvOEXPL7K0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=sSic4LcES0NcB7YLzJKUJNNKKx0qL+4hNUsOoAwC+ouhjpr/4IR4ArOmlKgWHxkwed
         t6jS8L3NZ207mX3AbMcxCOIjfd892SHUzaov3Utp50NpmWE7fn9p37DSfIcYstTQ0WRW
         TeuDkno72dEPeaWFyFyItVAftovlRMwqutfwI=
Received: by 10.150.247.23 with SMTP id u23mr10312359ybh.150.1271975225168;
        Thu, 22 Apr 2010 15:27:05 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm241835iwn.4.2010.04.22.15.27.04
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Apr 2010 15:27:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <x2qc376da901004221448i373a342p1d7b763383e80472@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145574>

Adam Brewster wrote:

> Consider
>=20
> $ echo -e '#!/bin/bash\nif git diff-tree --quiet HEAD; then git commi=
t
> -a; else git commit; fi' > `git --exec-path`/git-ci
> $ chmod 555 `git --exec-path`/git-ci

Or just put it in your $PATH. :)

By the way, all this talk of =E2=80=9Cif there is an index=E2=80=9D sou=
nds funny to
my brainwashed ears.  Every version control system I have tried uses
an index to ensure consistency during a commit; it=E2=80=99s just that =
most
of them hide it from the user.

This may sound pedantic, I realize.

Have fun,
Jonathan
