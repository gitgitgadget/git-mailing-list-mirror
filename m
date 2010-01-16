From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Stamp Git commit id into file during build process
Date: Sat, 16 Jan 2010 22:27:22 +0100
Message-ID: <201001162227.23236.jnareb@gmail.com>
References: <a1138db31001161050i73eade1bif968ca1256dcef2c@mail.gmail.com> <m3d419desd.fsf@localhost.localdomain> <a1138db31001161312i2c032c38tcc0fb162c61fbb35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Richards <paul.richards@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 22:27:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWGBN-0002cm-1t
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 22:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386Ab0APV1c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Jan 2010 16:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752296Ab0APV1b
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 16:27:31 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:65353 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab0APV1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 16:27:31 -0500
Received: by fxm25 with SMTP id 25so35656fxm.21
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 13:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ey6qKICwWAbl9+RmN+sRpSoQwmDRmmYJHZEm73NYpnE=;
        b=jej/TH3C4ic8jf14IiriYtzNluAJKSgJ80M8P1k3zEsAI9v0Czrj+p9QVCeOuD4c7m
         uAXRBWXqhgyMgYJYQnIwxhsFGWlcM+JnaRT9nI7L4/5i5jRiUKQtQ2FHuKHAfuAPIexu
         +AL7SDU8FQXX6ePle6LOCrio/fBCxnWxED+Xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=RgxBvnYDbM/O00j/xq3RMPvnvKdUVlIrUeHMzseMAArx0qbQJNjtTxZrWkueIM60Er
         klYedlequNQRhPBTqEzAS/I7FQEEzwfzXh4JcSJddql6VAM2eQuTRPpjE6ZwzJr4ZVtb
         SKDMOspqGy/6JtVRsQwzN1atxfB9p+KnDKvM0=
Received: by 10.223.58.71 with SMTP id f7mr4405579fah.45.1263677249096;
        Sat, 16 Jan 2010 13:27:29 -0800 (PST)
Received: from ?192.168.1.13? ([72.14.240.162])
        by mx.google.com with ESMTPS id h2sm3681164fkh.2.2010.01.16.13.27.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Jan 2010 13:27:27 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <a1138db31001161312i2c032c38tcc0fb162c61fbb35@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137260>

Dnia sobota 16. stycznia 2010 22:12, Paul Richards napisa=C5=82:
> 2010/1/16 Jakub Narebski <jnareb@gmail.com>:
>> Paul Richards <paul.richards@gmail.com> writes:

>>> I am in the process of migrating from Subversion to Git. =C2=A0One =
thing I
>>> am unsure of is how to stamp the 'version' or 'commit id' into a fi=
le
>>> as part of a build process.

>> Take a look how for example git project and Linux kernel use "git de=
scribe"
>> in GIT-VERSION-GEN script, and how they use GIT-VERSION-GEN script i=
n the
>> Makefile.=20
>=20
> Thanks, it appears though that "git describe" does not work in Cygwin=
 git. :(

If you got something like

  $ git describe
  fatal: cannot describe 'a27cb622b30f18cb8510b7b3856d4029e617d95b'

it means that you don't have any tags in your history.  You should tag =
your
releases (released versions) using annotated tags.

Anyway you have

  $ git describe --always
  a27cb62

--=20
Jakub Narebski
Poland
