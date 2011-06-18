From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 0/7] user-configurable git-archive output formats
Date: Sat, 18 Jun 2011 08:28:48 -0700 (PDT)
Message-ID: <m3wrgjtb1c.fsf@localhost.localdomain>
References: <20110614181732.GA31635@sigill.intra.peff.net>
	<20110614181821.GA32685@sigill.intra.peff.net>
	<4DF7B90B.9050802@lsrfire.ath.cx>
	<20110614201433.GB1567@sigill.intra.peff.net>
	<20110614204521.GA12776@sigill.intra.peff.net>
	<20110615223030.GA16110@sigill.intra.peff.net>
	<4DFCBB92.5040308@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@github.com>, Junio C Hamano <gitster@pobox.com>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: =?iso-8859-15?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jun 18 17:28:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXxSC-0008AB-V6
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 17:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731Ab1FRP2w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Jun 2011 11:28:52 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48465 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab1FRP2v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2011 11:28:51 -0400
Received: by wwe5 with SMTP id 5so1309887wwe.1
        for <git@vger.kernel.org>; Sat, 18 Jun 2011 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=s/uP5DMpgcKWfJLYZfrHq7iVO4R2W0NjozbBMc3Ieyo=;
        b=iP1qhdwTunYM6+yPZMOSqcjtZ3pylQuq5i2Qnegs/PbA6McuHlISjg/rULKHxqo7dE
         wnlZcnyfhpRknGZl+3+3jCNz++9xmIgJzdEJlW7F9HRAF89+LtpNnKzJHswUyjwnEUFO
         OyQTV20bPsdu16Xd0/Jr4zR30jCKGvKvrqzV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=RHOahLnpZKqGxeHnGJEeqPJFkekoOPvBZD/nnZk0sZtD9JpFVYrhReZ+pKs1GJsfct
         Xd2yvQ9JrptGLdJgsi6COdbUGzRvrMGJpE0py6LnNJsrUi+ZXJx13qB/wCU+h9mtPbDM
         xTGUvwYfg6y4CjDhMoluJTJx2B6Kodp5+Ei5w=
Received: by 10.216.237.8 with SMTP id x8mr260806weq.37.1308410929947;
        Sat, 18 Jun 2011 08:28:49 -0700 (PDT)
Received: from localhost.localdomain (abrz104.neoplus.adsl.tpnet.pl [83.8.119.104])
        by mx.google.com with ESMTPS id d7sm1950075wek.21.2011.06.18.08.28.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 18 Jun 2011 08:28:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5IFS1pH021393;
	Sat, 18 Jun 2011 17:28:11 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p5IFRSHC021375;
	Sat, 18 Jun 2011 17:27:28 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4DFCBB92.5040308@lsrfire.ath.cx>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175974>

Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
> Am 16.06.2011 00:30, schrieb Jeff King:
>> On Tue, Jun 14, 2011 at 04:45:21PM -0400, Jeff King wrote:
>>=20
>>> The gzip path is not configurable at all. Probably it should read t=
he
>>> path and arguments from the config file. In fact, we could even all=
ow
>>> arbitrary config like:
>>>
>>>   [tarfilter "tgz"]
>>>     command =3D gzip -c
>>>     extension =3D tgz
>>>     extension =3D tar.gz
>=20
> Configuration options whose values are appended instead of overwritte=
n
> by duplicate definitions are a new concept for git, I think.  Perhaps
> it's not a big thing, but I think it's better avoided.

Actually they are not a new concept, but they are quite rare.  `git con=
fig`
has even special options to deal with them ('--replace-all', '--add',=20
'--get-all', '--unset-all'.

=46or example "core.gitProxy" can be set multiple times, and of course
"remote.<remotename>.fetch", 'pull' and 'url'.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
