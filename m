From: Matthew Ruffalo <mmr15@case.edu>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 07 Jun 2013 14:45:45 -0400
Message-ID: <51B22A59.20607@case.edu>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org> <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info> <CALkWK0n2VsEP31jMB2kZ4x=wa90o8QPkR=ZWETfm=H5RC1kKcg@mail.gmail.com> <alpine.DEB.1.00.1306070518510.28957@s15462909.onlinehome-server.info> <CALkWK0nUoF2VX6Ns09vQHYo11520_4r9ikYmkZW108aQm1RpoQ@mail.gmail.com> <vpqhah9248u.fsf@anie.imag.fr> <CALkWK0mLVxKGvvYmREFyEkp6CgWuOEmML5V4ajF8R0SK62D4Gg@mail.gmail.com> <20130607183325.GC12924@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?ISO-8859-1?Q?Nguy=ADn_Th=E1i_Ng=F7c?= <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 20:51:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul1lU-0007gK-45
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 20:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085Ab3FGSvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 14:51:48 -0400
Received: from mpv2.tis.CWRU.Edu ([129.22.105.37]:64803 "EHLO
	mpv2.tis.cwru.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757094Ab3FGSvq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 14:51:46 -0400
X-Greylist: delayed 359 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jun 2013 14:51:45 EDT
Received: from mpv5.tis.CWRU.Edu (EHLO mpv5.cwru.edu) ([129.22.105.51])
	by mpv2.tis.cwru.edu (MOS 4.3.5-GA FastPath queued)
	with ESMTP id AMT94556;
	Fri, 07 Jun 2013 14:45:40 -0400 (EDT)
Received: from mail-qe0-f46.google.com (EHLO mail-qe0-f46.google.com) ([209.85.128.46])
	by mpv5.cwru.edu (MOS 4.3.5-GA FastPath queued)
	with ESMTP id AFG83294;
	Fri, 07 Jun 2013 14:45:44 -0400 (EDT)
Received: by mail-qe0-f46.google.com with SMTP id nd7so445801qeb.33
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 11:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=DtwgTfUqE+3tt6mqGDI+QokTuLpViYOKBu7j/FMtftI=;
        b=AUnXP5Eqz/9Xp+lahYYWUrzyYb+0NwFemCbP8iqeLyQhL4KtBcPeusfHmLuL2J0WFW
         7fA2upMykiGIqlqD1rFqTK8OB0cew8UqHbGTqyGCb931iRuhfS/XgqBEQiUITr9gVrsK
         smN72ypXayn+74ieUYNjNQ3RzK23IGDT/0em2xXDm44GfPcN1R5H9s4geYYBzANc9Uyo
         b2V75osIsIpfPRuOJj/h5E61BfBkyOu4KpM6UrV+FcApuSLDG+LPgHCd4EFYlSDWQXPs
         d2IPWicvG9XbMgeMPPQpZhxxeBZLQYUxa7kRiMb9P2fVkz53wVsSTIiL6iiCBl9jHLVs
         h/fg==
X-Received: by 10.229.15.10 with SMTP id i10mr6305qca.52.1370630744539;
        Fri, 07 Jun 2013 11:45:44 -0700 (PDT)
X-Received: by 10.229.15.10 with SMTP id i10mr6296qca.52.1370630744443;
        Fri, 07 Jun 2013 11:45:44 -0700 (PDT)
Received: from [129.22.151.147] (giygas.STUDENT.CWRU.Edu. [129.22.151.147])
        by mx.google.com with ESMTPSA id y14sm5526654qac.0.2013.06.07.11.45.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 11:45:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <20130607183325.GC12924@google.com>
X-Gm-Message-State: ALoCoQnpuRIkYM3uFAfenon7J7Y/LkX5TQVXVBIxMLnBCfPuADgnF53kevFmnFdDHxXNyWP1gcCcnEeR0urHDtfePaYRAV9tGY8yZejxqLPkLx22rTRtIy1WdshlUs/9OsYR8ZLwL0br/96bkUVxLiSMWH5X7UwkhA==
X-Junkmail-Whitelist: YES (by domain whitelist at mpv2.tis.cwru.edu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226669>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> I think he way forward on Windows is
> Why is there only one way forward?  Why do you get to pick it, given
> that you've said you're not interested in working on it?
>
> [...]
>>                                               I never understood why
>> users on Windows want to use something as POSIX'y as git.git.
> Plenty of users on Windows use a command line.  I have even been such
> a user from time to time.  I'm quite grateful for Dscho et al's work
> on making that less painful.
>
> Jonathan
I agree completely. It's rare that I use Windows now, but a few years 
ago I installed Cygwin on any machine that I would use in any serious 
capacity. I haven't needed to do this since I started to use Git; the 
Windows installer ships all of the POSIX utilities that I need (with the 
possible exception of 'tree', and the caveat that scp can't handle files 
 >= 2GB).

I'm very appreciative of the work that's gone in to Git for Windows, and 
from my perspective it's a pleasant coincidence that it includes a POSIX 
shell and associated tools.

MMR...
