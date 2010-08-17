From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [GSoC update] git-remote-svn: The final one
Date: Tue, 17 Aug 2010 18:10:39 +0200
Message-ID: <AANLkTikyrC07OnMJWDmC7n0ks3TdOxb=jPmKWbK9Nc7u@mail.gmail.com>
References: <20100817144215.GC24886@kytes>
	<15605020.115671.1282060094242.JavaMail.root@mail.hq.genarts.com>
	<20100817155933.GB6947@kytes>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Bash <bash@genarts.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Stefan Sperling <stsp@elego.de>,
	Bert Huijben <rhuijben@collab.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Will Palmer <wmpalmer@gmail.com>,
	Philip Martin <philip.martin@wandisco.com>,
	Jonas Gehring <jonas.gehring@boolsoft.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 18:11:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlOkb-0004Ho-Mp
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 18:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757657Ab0HQQKm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 12:10:42 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43380 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757462Ab0HQQKl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 12:10:41 -0400
Received: by vws3 with SMTP id 3so4700537vws.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 09:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=JzolbopOi0WSmABdCLLRbr6ES33iACNRgigMFg/H2GM=;
        b=lrt401mB6xtwCTs828o7IA1vrVBybOncN1UJlosgDMVQV8G40jSmQROPE0/sBSEZBQ
         xVu8JPB+SpQY5AmS7vcnt7YGw19dyFHFjeMfeOKjY60hYrv11HnM2E6EpvLTELatEWdz
         xoYp6Ccffgq4+nJltzzIFylzdknrx/n7c/SUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=hTW2PQouZopqGuGwXzH6oFtWC5qDWJEF43U4bA28/51YH1Gj0X6b3LI7oYv/jNOBY9
         FMeCFBAofIvLtqAPz9edXtrApPPRvPg/Ttah4hHW0I19ZdPk5r0kWroZzitw2nGDtl7e
         pcH+tm8trG1+M1kjK+yQ8es6tRvxkxY1QLM90=
Received: by 10.220.62.72 with SMTP id w8mr4149281vch.200.1282061439604; Tue,
 17 Aug 2010 09:10:39 -0700 (PDT)
Received: by 10.220.172.67 with HTTP; Tue, 17 Aug 2010 09:10:39 -0700 (PDT)
In-Reply-To: <20100817155933.GB6947@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153757>

On Tue, Aug 17, 2010 at 5:59 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Stephen Bash writes:
>> First, congratulations on making it through GSoC. =A0I've been avidl=
y following your progress since our off-list discussion at the beginnin=
g of the summer, and I'm excited to watch the work continue.

+1 on the congratulation! I've also been following the progress, but
from a distance. As I use git-svn to work with SVN at $dayjob, I can't
wait to get something running.

> We're doing better than that- when the whole thing is complete, we
> should have perfectly seamless two-way compatibility.

Does this include handling SVN repos where the layout have changed
during it's lifetime? If so, how will this look on the git side?
