From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update] git-remote-svn: The final one
Date: Tue, 17 Aug 2010 22:48:49 +0530
Message-ID: <20100817171846.GG6947@kytes>
References: <20100817144215.GC24886@kytes>
 <15605020.115671.1282060094242.JavaMail.root@mail.hq.genarts.com>
 <20100817155933.GB6947@kytes>
 <AANLkTikyrC07OnMJWDmC7n0ks3TdOxb=jPmKWbK9Nc7u@mail.gmail.com>
 <AANLkTim5RYDuius6Oa6KX0weQhwVz+_YP=1-ujb3-CuJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, Stephen Bash <bash@genarts.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Stefan Sperling <stsp@elego.de>,
	Bert Huijben <rhuijben@collab.net>,
	Will Palmer <wmpalmer@gmail.com>,
	Philip Martin <philip.martin@wandisco.com>,
	Jonas Gehring <jonas.gehring@boolsoft.org>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 19:20:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlPqJ-0000CV-Ep
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 19:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758020Ab0HQRUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 13:20:51 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39965 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840Ab0HQRUt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 13:20:49 -0400
Received: by pzk26 with SMTP id 26so2469900pzk.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 10:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GPTVUrI0GfWVNoyyTB0kqSqeznhaHyCiFhy5HbmUq8c=;
        b=bIf/7Yk19pwhx2h0AwOrU47NqdNAzUxL4nMMJgsRympmeFqb704VkzzTDkcwM8H/jQ
         v3/OAUUYq/scZtts6SVae18DYX6PIS5187yxhgjXpLdkJjI4ecmAPZOX27nS7NUfdjFM
         vBB9KcEM+N7gVsVJdkAvGMoF6Auf9okRER2C4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=x2mUgjFl7uvFKM0BV9d6J6teKlub/nstlFfGNPQvKCqH1acnrNmZ2n7hH4Hje4KSy7
         Vw1g1AGufCreMHyzwnl1a8TmHLSRfF++m2omPPIo1+kxoLss7HJIxHOpOCAGHlZ3Ru1b
         eK35EdIbYoBbJE5ndIp+bMz0lbMY/xfPeiYhQ=
Received: by 10.114.95.4 with SMTP id s4mr8238370wab.36.1282065649025;
        Tue, 17 Aug 2010 10:20:49 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id x9sm14710254waj.15.2010.08.17.10.20.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 10:20:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim5RYDuius6Oa6KX0weQhwVz+_YP=1-ujb3-CuJ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153767>

Hi Sverre,

Sverre Rabbelier writes:
> Heya,
> 
> On Tue, Aug 17, 2010 at 11:10, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> > On Tue, Aug 17, 2010 at 5:59 PM, Ramkumar Ramachandra
> > <artagnon@gmail.com> wrote:
> >> We're doing better than that- when the whole thing is complete, we
> >> should have perfectly seamless two-way compatibility.
> >
> > Does this include handling SVN repos where the layout have changed
> > during it's lifetime? If so, how will this look on the git side?
> 
> Perhaps it makes sense to start a new thread to hash that out for when
> the time comes to implement that?

Good idea. I've posted a new timeline. I'll put up some branch/ tag
mapper notes next week.

-- Ram
