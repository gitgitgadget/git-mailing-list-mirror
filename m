From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: perl t9700 failures?
Date: Sun, 29 Jun 2008 15:53:31 -0700 (PDT)
Message-ID: <m3zlp3hn19.fsf@localhost.localdomain>
References: <alpine.LFD.1.10.0806291241210.27776@hp.linux-foundation.org>
	<7vzlp47zy8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Lea Wiemann <LeWiemann@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 00:55:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD5nW-0006eS-5j
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 00:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbYF2Wxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 18:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbYF2Wxg
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 18:53:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:24795 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbYF2Wxf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 18:53:35 -0400
Received: by nf-out-0910.google.com with SMTP id d3so367625nfc.21
        for <git@vger.kernel.org>; Sun, 29 Jun 2008 15:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=RdNWZLlHQ4tTAd+Nv3RShebPqpyMx2/fm8RRMCOEGAI=;
        b=viUZaSp9Zzgvoj/g92DdGXvHFJWCDvRw3RyAZnF74mxHiKO/PzjWcuvFZa+3l6Vc2n
         TPavk16noHKCO1gGSdZTEoeuEI45WkFSrv80MBAe5oXmSSRl8HI+ajMaYNvzwnvaZ6CQ
         kR7amkGEIpq7tiDUPNrmB4I6Bk5KPmDyKhPsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=fhdAhh1z1bpn0DIUa3X1JISzqnTAEV51Ep8a6t8hkGNkcnlQGK6a3zYT+6QJv9sloQ
         Sw6/FEFy7pusdgxunWhlSwQR7PFH8Gaq5p+WsQLagjU76g24HA3OfrBzrYhU4LOiG7gD
         QZ8xHEKmhYSN4Tl7K3jzzTDJwDElmKeLZOoDY=
Received: by 10.210.25.18 with SMTP id 18mr3520143eby.152.1214780012322;
        Sun, 29 Jun 2008 15:53:32 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.214.210])
        by mx.google.com with ESMTPS id h1sm2962657nfh.19.2008.06.29.15.53.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Jun 2008 15:53:31 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5TMqh99014966;
	Mon, 30 Jun 2008 00:52:53 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5TMqI5a014957;
	Mon, 30 Jun 2008 00:52:18 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vzlp47zy8.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86846>

Junio C Hamano <gitster@pobox.com> writes:

> +perl -MTest::More -e 0 2>/dev/null || {
> +	say skip "Perl Test::More unavailable, skipping test"
> +	test_done
> +}
> +

I think it would be nice to have "test_skip" function in test-lib.sh;
a few tests beside this one (t9500 gitweb test, git-svn tests) have
not always filled requirements.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
