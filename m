From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH 1/2] Add --date={local,relative,default}
Date: Thu, 26 Apr 2007 08:54:01 +0200
Message-ID: <87y7kfzkvq.fsf@morpheus.local>
References: <alpine.LFD.0.98.0704250800030.9964@woody.linux-foundation.org> <11775633782185-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 11:05:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgzuY-0007Ss-Rs
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 11:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbXDZJFH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 26 Apr 2007 05:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754780AbXDZJFH
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 05:05:07 -0400
Received: from main.gmane.org ([80.91.229.2]:56687 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754778AbXDZJFF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 05:05:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hgyx9-0004bW-Js
	for git@vger.kernel.org; Thu, 26 Apr 2007 10:03:47 +0200
Received: from dns.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Apr 2007 10:03:47 +0200
Received: from davidk by dns.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Apr 2007 10:03:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dns.vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:JoE22camQZC0IE6K0qiKh8Lxl94=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45625>

Junio C Hamano <junkio@cox.net> writes:

> ++
> +`--date=3Drelative` shows dates relative to the current time,
> +e.g. "2 hours ago".
> ++
> +`--date=3Dlocal` shows timestamps in user's local timezone.
> ++
> +`--date=3Ddefault` shows timestamps in the original timezone
> +(either committer's or author's).

Why is "default" called "default" and not, say, "original"?  What if I
changed the default format to "local" using local configuration.  What
would "default" show then?

--=20
David K=C3=A5gedal
