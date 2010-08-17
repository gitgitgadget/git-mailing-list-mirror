From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update] git-remote-svn: The final one
Date: Tue, 17 Aug 2010 21:52:37 +0530
Message-ID: <20100817162233.GD6947@kytes>
References: <20100817144215.GC24886@kytes>
 <15605020.115671.1282060094242.JavaMail.root@mail.hq.genarts.com>
 <20100817155933.GB6947@kytes>
 <AANLkTikyrC07OnMJWDmC7n0ks3TdOxb=jPmKWbK9Nc7u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 18:24:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlOxx-0002kj-Hw
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 18:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757948Ab0HQQYk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 12:24:40 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62315 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757937Ab0HQQYk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 12:24:40 -0400
Received: by ywh1 with SMTP id 1so2563049ywh.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 09:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BW9MY0p9Uz8/05B3MQsggmWvvPUduw4J3NPX0MRWdiE=;
        b=DDwiOYrdCPniULzBZ0agcUPGzSfiC+jwZ2IeCy34t8Ecnx80qhp+7E3HmUNp1U8LOM
         eoeFHk7NOnvvn9OzATRRdHS6tD3eh2LEYe8spoV4Ibq5ay3opl//XP1uOm6GqB9m7czK
         xZB0j22fY0B3I2NRFGlcwIBowCHz626KwZdWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=r09MEHF2MylDn8NHeFIeWOWEfb5BTzfaF7uS4FuiXsCw45sAUPBhxZ9fXR+9dygGPz
         K2v2A4GBEANtNyfs+1LAeeWhsNjEIkhE5sFV93Vte3E1Xy8bjYftWiLCAXx7QrERM4Qb
         GfUDtB1CbjfAfr4/aSTnYFWY+4X2SeNqAKfP0=
Received: by 10.231.183.67 with SMTP id cf3mr7500608ibb.187.1282062279056;
        Tue, 17 Aug 2010 09:24:39 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id r3sm6257288ibk.7.2010.08.17.09.24.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 09:24:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikyrC07OnMJWDmC7n0ks3TdOxb=jPmKWbK9Nc7u@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153760>

Hi Erik,

Erik Faye-Lund writes:
> On Tue, Aug 17, 2010 at 5:59 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
> > Stephen Bash writes:
> >> First, congratulations on making it through GSoC. =A0I've been avi=
dly following your progress since our off-list discussion at the beginn=
ing of the summer, and I'm excited to watch the work continue.
>=20
> +1 on the congratulation! I've also been following the progress, but
> from a distance. As I use git-svn to work with SVN at $dayjob, I can'=
t
> wait to get something running.

Thanks :)

> > We're doing better than that- when the whole thing is complete, we
> > should have perfectly seamless two-way compatibility.
>=20
> Does this include handling SVN repos where the layout have changed
> during it's lifetime? If so, how will this look on the git side?

Yes, but we don't know yet. There's been some speculation about
re-implementing the branch/ tag mapper in git-svn on top of
git-remote-svn once it's complete. Anyway, Sam's illustration has been
most insightful to me on this issue [1]. Will has also started
thinking about this and has some preliminary notes outlining the
challenges. When the notes are more mature, I'll post them to the list
so we can get a wider audience to discuss this at length :)

[1] http://article.gmane.org/gmane.comp.version-control.git/150007

-- Ram
