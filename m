From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-ftp for /contrib
Date: Thu, 27 May 2010 17:54:02 -0700 (PDT)
Message-ID: <m3r5kwrgjz.fsf@localhost.localdomain>
References: <1274987983.17078.35.camel@zoulou.moser.lan>
	<1275000359-sup-1204@ezyang>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?Ren=E9_Moser?= <mail@renemoser.net>,
	git <git@vger.kernel.org>
To: "Edward Z. Yang" <ezyang@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri May 28 02:54:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHnq3-0001Vh-SH
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 02:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598Ab0E1AyK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 20:54:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44786 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571Ab0E1AyI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 20:54:08 -0400
Received: by fxm10 with SMTP id 10so343505fxm.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 17:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=00/F6Cu7zpoApOEGuevVD4uiA4zzwUKg41IUMT1vq1M=;
        b=AIWzbaOQEKwC4KEAU9YuNiSHqkjVQfM4Px9kXKXrf6ZIF8+PeaRiXmUpxh2yrI7lvh
         29RlDO9vrj6W5yJxCoqXiE0KCxQVb6awJ2qRw97txoxV2pFtPlrHD7sFn+d4YiQqWZ+d
         pM6vkNsV50Rl6nOA+unJMUQLellK3gyecdDHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=Eorok/8QqaahfpsRj5kmmAZ4G+xAAAyQx1kSiFrtsZ/sZojQVuHXJSP9pfXR5ST4wk
         8KETNFqalwj+W0fjqn2pnf/4YvrWMuZZlAtzP88jg+jNXmuhjjQQ7pJgEfugADfG8iTf
         GAKT9EO0rI3z4mM+7Y3hyfiwQdfyQWlaJ6F34=
Received: by 10.103.80.5 with SMTP id h5mr6627705mul.82.1275008044389;
        Thu, 27 May 2010 17:54:04 -0700 (PDT)
Received: from localhost.localdomain (abwk209.neoplus.adsl.tpnet.pl [83.8.234.209])
        by mx.google.com with ESMTPS id 12sm3978165muq.33.2010.05.27.17.54.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 17:54:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o4S0takH004046;
	Fri, 28 May 2010 02:55:47 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o4S0tDlI003990;
	Fri, 28 May 2010 02:55:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1275000359-sup-1204@ezyang>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147909>

"Edward Z. Yang" <ezyang@MIT.EDU> writes:

> Excerpts from Ren=E9 Moser's message of Thu May 27 15:19:43 -0400 201=
0:
> >=20
> > I scripted a small tool called git-ftp for optimal interaction betw=
een
> > git and ftp. I use it quite often and I thought it might fit in the
> > contrib section of git.
> >=20
> > Please have a look at http://github.com/resmo/git-ftp and give me s=
ome
> > feedback. See README and an (almost outdated) screencast.
>=20
> What a coincidence! I've also made a small Python script for git<->ft=
p
> synchronization, unsurprisingly called the same thing.
>=20
> http://github.com/ezyang/git-ftp
>=20
> (Unfortunately, since it's written in Python it seems pretty unlikely
> to go into the contrib section of git.)

I don't know about adding this script to contrib/ section (you would
probably need to send properly formatted patch adding it in approriate
place in contrib/), but could each of you add your project to the

  http://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools

page on Git Wiki?  Thanks in advance.


P.S. I wonder how hard would be to add native support for "dumb"
ftp:// protocol, so that "git fetch ftp://example.com/repo.git"
_and_ "git push ftp://example.com/repo.git" works.
--=20
Jakub Narebski
Poland
ShadeHawk on #git
