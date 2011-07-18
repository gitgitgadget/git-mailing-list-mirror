From: Timo Besenreuther <timo.besenreuther@gmail.com>
Subject: Re: git-ftp: retry, sftp support
Date: Mon, 18 Jul 2011 10:58:24 +0200
Message-ID: <138AFDD9-CE91-4019-BAF3-B6F301D4225E@gmail.com>
References: <CACPiFCL22yr096_nNfjvfP_bkJRC7HA65GUF12wedzV=cz-_kg@mail.gmail.com> <m3vcv0yqb4.fsf@localhost.localdomain> <CACPiFCK4B96cTAz8JEBMOpktZG2R5HsYA2YgEdRuqO55XTOVcg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?iso-8859-1?Q?Ren=E9_Moser?= <mail@renemoser.net>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 11:05:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qijl3-0004ge-Ne
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 11:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174Ab1GRJEw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 05:04:52 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:43883 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132Ab1GRJEv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2011 05:04:51 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Jul 2011 05:04:50 EDT
Received: by eye22 with SMTP id 22so1159356eye.2
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 02:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=BJN7HOxPiwm3pqOK5kNPIJ642UCIoUoJwkgrIeUH97Y=;
        b=nTpIeezV3ijfBALq7/TUNlsL7MnD6MKyduamqHjMjN8Blp/HRvx19UPpkM5sLKCFlF
         wUVlMdkTu06W1IA120DjtQyDrY51TqvZWtaFUc7K2HkyYC8AHlBVnenEn9i3J6UfZEa+
         Uq6U5Q04ZOUZevqdOaV1RKwdz9A+ardmws0uA=
Received: by 10.14.22.6 with SMTP id s6mr2016548ees.95.1310979507336;
        Mon, 18 Jul 2011 01:58:27 -0700 (PDT)
Received: from [192.168.178.25] (mnch-5d866eb7.pool.mediaWays.net [93.134.110.183])
        by mx.google.com with ESMTPS id q22sm2008486eea.18.2011.07.18.01.58.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jul 2011 01:58:26 -0700 (PDT)
In-Reply-To: <CACPiFCK4B96cTAz8JEBMOpktZG2R5HsYA2YgEdRuqO55XTOVcg@mail.gmail.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177364>

Hey guys,

I think there's some confusion here.

git-ftp is a bash tool written by Rene Moser (github resmo) to sync a g=
it repo with an FTP server.
It is not in git core. I just added some minor improvements. My github =
repo is just a fork.

Regards,
Timo


On Jul 18, 2011, at 10:09 AM, Martin Langhoff wrote:

> 2011/7/18 Jakub Narebski <jnareb@gmail.com>:
>> Martin Langhoff <martin.langhoff@gmail.com> writes:
>>=20
>>> Ren=E9, Timo,
>>>=20
>>> Thanks for git-ftp -- it has saved me from going crazy with low cos=
t
>>> hosting setups that only support ftp.
>>=20
>> Could you give us a link?  It isn't in git core, is it?
>=20
> git remote -v
> origin	git://github.com/BeezyT/git-ftp.git (fetch)
> origin	git://github.com/BeezyT/git-ftp.git (push)
>=20
>> How git-ftp differs from ftp / ftps remote helper (git-remote-ftp et=
c.)?
>=20
> AIUI, the ftp/ftps remote helpers are to keep a git _repo_ on a serve=
r
> that runs ftp.
>=20
> This git-ftp is a "deploy the tip of my branch onto a production
> server" tool. The usage model is
>=20
> - hack on your html/php website on your dev machine, in a git checkou=
t
> - commit your code
> - use git-ftp to publish to the hosting server
>=20
> Maybe it should be called "git ftpdeploy".  It's a handy trick. I
> found it via http://stackoverflow.com/questions/2950107/git-push-into=
-production-ftp
>=20
>=20
>=20
>=20
> m
> --=20
>  martin.langhoff@gmail.com
>  martin@laptop.org -- Software Architect - OLPC
>  - ask interesting questions
>  - don't get distracted with shiny stuff  - working code first
>  - http://wiki.laptop.org/go/User:Martinlanghoff
