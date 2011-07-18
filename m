From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git-ftp: retry, sftp support
Date: Mon, 18 Jul 2011 04:09:59 -0400
Message-ID: <CACPiFCK4B96cTAz8JEBMOpktZG2R5HsYA2YgEdRuqO55XTOVcg@mail.gmail.com>
References: <CACPiFCL22yr096_nNfjvfP_bkJRC7HA65GUF12wedzV=cz-_kg@mail.gmail.com>
 <m3vcv0yqb4.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Ren=E9_Moser?= <mail@renemoser.net>,
	Timo Besenreuther <timo.besenreuther@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 10:10:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiiuK-0002VU-JI
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 10:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968Ab1GRIKV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 04:10:21 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52522 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745Ab1GRIKT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2011 04:10:19 -0400
Received: by vxh35 with SMTP id 35so1449309vxh.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 01:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Rim/La75aSieBytbuLPn0PbWOEO3o/I6Lt89/cV+Nio=;
        b=jqxhDC4q0qRGbDgM7QKWsI1YnpQOWXrQS3vH9bbWrPb8vSZC0j5jU8atGXxVAZjm9L
         QqyiTcx0TDxQGj/mUqOHy+rShX18NZWIHDot5oSYgZ5h0lBZKwssWL6BTpjKFNZJX5dP
         ltzeXuq/kw6evLiOVhqY8/RnT5JT/ZWz328k0=
Received: by 10.52.24.147 with SMTP id u19mr2475764vdf.525.1310976619180; Mon,
 18 Jul 2011 01:10:19 -0700 (PDT)
Received: by 10.220.200.132 with HTTP; Mon, 18 Jul 2011 01:09:59 -0700 (PDT)
In-Reply-To: <m3vcv0yqb4.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177360>

2011/7/18 Jakub Narebski <jnareb@gmail.com>:
> Martin Langhoff <martin.langhoff@gmail.com> writes:
>
>> Ren=E9, Timo,
>>
>> Thanks for git-ftp -- it has saved me from going crazy with low cost
>> hosting setups that only support ftp.
>
> Could you give us a link? =A0It isn't in git core, is it?

git remote -v
origin	git://github.com/BeezyT/git-ftp.git (fetch)
origin	git://github.com/BeezyT/git-ftp.git (push)

> How git-ftp differs from ftp / ftps remote helper (git-remote-ftp etc=
=2E)?

AIUI, the ftp/ftps remote helpers are to keep a git _repo_ on a server
that runs ftp.

This git-ftp is a "deploy the tip of my branch onto a production
server" tool. The usage model is

 - hack on your html/php website on your dev machine, in a git checkout
 - commit your code
 - use git-ftp to publish to the hosting server

Maybe it should be called "git ftpdeploy".  It's a handy trick. I
found it via http://stackoverflow.com/questions/2950107/git-push-into-p=
roduction-ftp




m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
