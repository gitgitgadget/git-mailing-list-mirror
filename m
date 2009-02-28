From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] autoconf: Add limited support for --htmldir
Date: Sat, 28 Feb 2009 08:59:50 +0100
Message-ID: <200902280859.52004.jnareb@gmail.com>
References: <9a0027270902272323y44091bfakcb640f168c33a824@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Syzdek <david@syzdek.net>
X-From: git-owner@vger.kernel.org Sat Feb 28 09:01:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdK8f-00025m-3I
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 09:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbZB1IAK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2009 03:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbZB1IAJ
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 03:00:09 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:37329 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbZB1IAI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 03:00:08 -0500
Received: by fxm24 with SMTP id 24so1357091fxm.37
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 00:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=wUMAaPpJq6aGAc6a4W6F3n7g5C0C1xlhLGdqWp/ztwM=;
        b=LxczjqUq96MOEETbo0AUWvUxmefWuzK179eYrzymvTj1Qn6CTjHBpjAmFE8UH7ZL3F
         xrsRv97lBMk5UV8Drazp6q7s0NVBBn9IwWRMgIROsCPuNedP+kXZe58RojCMrjPJOdIb
         MGkTQQZyeYFi0whDVvDbatSxVyPaFCvBfYacA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Jmhf1yIRacoglSY/9WT2T3RkiakwzKQxYcsWNlgJ3PfLkVsURJv0GS1v6ANdt5X/bY
         nQdOl2lzYl8ROf9vxBM8TOEBtXWun15cUgS7ou74+dKV5WP3ecX3yGvtcQwFhmayecI0
         jdnyoW6qyGvDp12nGY1h0+gmM5VRaksxhxMGw=
Received: by 10.181.216.14 with SMTP id t14mr974783bkq.201.1235808003353;
        Sat, 28 Feb 2009 00:00:03 -0800 (PST)
Received: from ?192.168.1.15? (abwe96.neoplus.adsl.tpnet.pl [83.8.228.96])
        by mx.google.com with ESMTPS id f31sm11304876fkf.35.2009.02.28.00.00.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Feb 2009 00:00:02 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <9a0027270902272323y44091bfakcb640f168c33a824@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111754>

On Sat, 28 Feb 2009, David Syzdek wrote:

> I tested the below patch using autoconf 2.59 and autoconf 2.62. =C2=A0=
If
> the version of autoconf used to create the configure script supports
> the `--htmldir' option then the htmldir is set by either autoconf or
> the user defined value. =C2=A0If the version of autoconf does not sup=
port
> the `--htmldir' option, then htmldir defaults to [DATADIR/doc/git].
>=20
> This way a newer version of autoconf is not required for users on
> distros more than a year or so old, however users on newer distros ar=
e
> able to use the '--html' flag.

Thanks a lot.
--=20
Jakub Narebski
Poland
