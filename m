From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Sun, 21 Mar 2010 13:36:11 +0100
Message-ID: <fabb9a1e1003210536n5272ad68kf730d8263fe4c379@mail.gmail.com>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com> 
	<fabb9a1e1003191139v6ea37df3uba441f2cba9bc992@mail.gmail.com> 
	<32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com> 
	<alpine.DEB.1.00.1003201148230.7596@pacific.mpi-cbg.de> <f3271551003201334o4919cd47s44d06288b0d6068b@mail.gmail.com> 
	<20100320210406.GA29899@progeny.tock> <alpine.DEB.1.00.1003211125290.7596@pacific.mpi-cbg.de> 
	<20100321110807.GA24016@progeny.tock> <alpine.DEB.1.00.1003211236050.7596@pacific.mpi-cbg.de> 
	<f3271551003210525l761cf36eh69cdfddf4e645ef3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephan Beyer <s-beyer@gmx.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 13:36:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtKOU-0001Nt-6Y
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 13:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348Ab0CUMgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 08:36:33 -0400
Received: from mail-bw0-f211.google.com ([209.85.218.211]:54213 "EHLO
	mail-bw0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab0CUMgc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 08:36:32 -0400
Received: by bwz3 with SMTP id 3so4480741bwz.29
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 05:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=1LPZ33yf9XbntCZ6QA9+mm+wlbojWuJL1KUzzbRKS/0=;
        b=mxq9HDm/U+LAIQZEng/XUKdy+sY84AiYsTujApGhYTLtL2/2q1Zx6EQKuWA4YPamBk
         b22ttAiHSEeXh3OrFvD5fxKp4j/1/zHb+WZ+K77/toUgYMJMQvaY9P14ovXWJzdqtV7L
         riahi8JQjtAFXVJBotvVrtv4V1UFNvS4jJDJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kzkCOad6GtuPOg00cHFhrBLKa8YlEchwwFJRNOfK+s4D+nh1DprXSzkoX1uvyVj584
         c1J2maDziHITu+1lnaBGuirxUOg4FB3CZcJrGkq3hGMW+ZUD8wnjE4GaO/7cT8xvWoXv
         92qSC+W13cR6h8Wm1ksEbtvGbydx7DVd0fmoQ=
Received: by 10.204.138.81 with SMTP id z17mr3166807bkt.49.1269174991235; Sun, 
	21 Mar 2010 05:36:31 -0700 (PDT)
In-Reply-To: <f3271551003210525l761cf36eh69cdfddf4e645ef3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142823>

Heya,

On Sun, Mar 21, 2010 at 13:25, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Occasionally, it might help to post patches for small components
> of the project with unittests to get a wider test audience.

I suggest that (and this is a suggestion for all git GSoC projects)
that all students are required to post a weekly status update to the
mailing list. If they then prefix those mails with [GSoC update] it is
1) easy to filter out these emails for those who are not interested in
them and 2) easy later on to get a quick overview of who did what
when, by searching for all [GSoC update] emails. At first these emails
can just be a description of what was done  in the past week, which
design decisions were made (and why), and what the current status of
the project is. Later on these should be complemented by patches to
the git list (prefixed with [RFC/GSoC/PATCH] or such) with the
progress of the student so far.

In this particular case I think it'd be a good idea to start sending
patches around 3-4 weeks into the project, since by June 20 you hope
to have something minimally usable. I reckon it would be good to keep
these patches in pu to give them wider exposure, and to start merging
them to next as appropriate. For example, as soon as there is full
read support that would be a good time to merge to next to allow more
people to give it a try.

Junio, how do you feel about keeping these (most likely
fairly-unstable) GSoC patches in pu? I think it would be a great
motivation for our students (look, I've got my work into pu!), and
it'd be a great way to make it easy for everybody else to try out the
work of our students.

-- 
Cheers,

Sverre Rabbelier
