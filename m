From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Fix missing "HEAD" in the RewriteRule
Date: Sat, 07 Jun 2008 02:16:51 -0700 (PDT)
Message-ID: <m3bq2dy58j.fsf@localhost.localdomain>
References: <1212823166-25098-1-git-send-email-ask@develooper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 11:17:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4uYV-0004nu-K9
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 11:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176AbYFGJQz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jun 2008 05:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754452AbYFGJQz
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 05:16:55 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:35358 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978AbYFGJQy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jun 2008 05:16:54 -0400
Received: by fg-out-1718.google.com with SMTP id 19so915704fgg.17
        for <git@vger.kernel.org>; Sat, 07 Jun 2008 02:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=PRFOPMKKRAVbUpRoQx8xbi4eaNQfRiXopnWGjGXE3SE=;
        b=T3Gfdc/7AeyfXOoQsAhC3/jJDQSoAl915PyymxSYkQ52xRSeD0xLyYuixKbtt9qvf2
         f43f87Jc9UvMPLG8WL7WVJjHzmlS3u3XIctd/hMcg5xsU2VpwOanfQnhD2tuySoys34Q
         qkoOlB9h6N5NXdqq1kTVRr0mS424qiwOQ+Y5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=L7dX78j2ReTAbV6bsUKjM0SCj2SNz25MLH/gJVyVy05p6aYGETQ2+RrDG4OTUxWkCq
         Hm3TC/bzwjAWkpbfss6W7w1kkxmKNZvyqdnKElgQV0gY/Z5zeCkJJtiSiCCgzKc0g9c/
         sFl5TzogYzIHNDlMr7VeIvohxRqWbFDx6u59M=
Received: by 10.86.26.11 with SMTP id 11mr1568527fgz.23.1212830212551;
        Sat, 07 Jun 2008 02:16:52 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.218.155])
        by mx.google.com with ESMTPS id 4sm7066812fgg.9.2008.06.07.02.16.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Jun 2008 02:16:51 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m579Gl2U031699;
	Sat, 7 Jun 2008 11:16:47 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m579Gi1s031696;
	Sat, 7 Jun 2008 11:16:44 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1212823166-25098-1-git-send-email-ask@develooper.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84191>

Ask Bj=F8rn Hansen <ask@develooper.com> writes:

> Also add a few more hints for how to setup and configure gitweb as de=
scribed
> ---
>  gitweb/README |   18 ++++++++++++++----
>  1 files changed, 14 insertions(+), 4 deletions(-)
>=20
> The important change is to add HEAD into the regexp, everything else =
is
> optional...
[...]
> @@ -255,12 +255,15 @@ Webserver configuration
>  If you want to have one URL for both gitweb and your http://
>  repositories, you can configure apache like this:

Thanks a lot.

The only (minor) complaint is that from the commit message itself it
is not obvous that you meant web server (Apache) configuration trick
to have one URL for both gitweb and access via HTTP protocol for git
repositories (fetch, clone,...).

--=20
Jakub Narebski
Poland
ShadeHawk on #git
