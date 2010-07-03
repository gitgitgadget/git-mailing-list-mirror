From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update extra!] git-remote-svn: Week 9
Date: Sat, 3 Jul 2010 21:47:33 +0200
Message-ID: <20100703194733.GA3092@debian>
References: <20100702215752.GD2306@debian>
 <AANLkTintNXXpyS5LpG6K7ltg-t6Mz0IuYT7GxMkFkVwa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Daniel Shahaf <daniel@shahaf.name>, Sam Vilain <sam@vilain.net>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 03 21:45:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OV8f0-0006eS-0C
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 21:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755983Ab0GCTpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jul 2010 15:45:52 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39570 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755813Ab0GCTpv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 15:45:51 -0400
Received: by ewy23 with SMTP id 23so1320071ewy.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 12:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Aqw0FiU7rrkJSkgSXZ89aV5seHG8qwDHhOy9SX36MtQ=;
        b=VIse8x3fKXQIJ/Z14NxK6d+bWEVGvMupTzbzSemFnj7/3EwYm7lJ48fRxGVLOBZP5n
         FOfmoX3wFoScGR/X1yR8qyHr2h/I+y0r4YpI4Wp3+RL8S2fHBbK+Qb4M5SY9EZVsOoCC
         uyzBuJom6/iLbMlm2+U8SX3TSaIZX0o3iY7V4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=MHXC618NCCRrYcDCnKCqqplapCghmESMQAhiAtkuYReY2N6aNifrEzjZ0meXCECmvP
         mOzda0yJnlgBZr7sBW4K6iJ+Qr05rM88Z9ezvggiilSWpKT8zLjnp32W3iIW/0QrwtXR
         FeSuY0dKgu+vXx5+cGVUmrUDallRAh+0aMei0=
Received: by 10.213.97.198 with SMTP id m6mr740730ebn.25.1278186350155;
        Sat, 03 Jul 2010 12:45:50 -0700 (PDT)
Received: from debian (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id a48sm18087996eei.18.2010.07.03.12.45.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 03 Jul 2010 12:45:48 -0700 (PDT)
Mail-Followup-To: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Daniel Shahaf <daniel@shahaf.name>, Sam Vilain <sam@vilain.net>
Content-Disposition: inline
In-Reply-To: <AANLkTintNXXpyS5LpG6K7ltg-t6Mz0IuYT7GxMkFkVwa@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150197>

Hi Tay,

Tay Ray Chuan writes:
> Hi,
> 
> On Sat, Jul 3, 2010 at 5:57 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> > [snip]
> > The client runs successfully and
> > manages to dump 5000 revisions of the ASF repository:
> >
> > 11.34s user 3.50s system 21% cpu 1:07.69 total
> >
> > That's about 75 revisions per second, which isn't too bad I hope. This
> > is over the network, and my internet connection isn't all that fast.
> 
> I wonder if you could mirror the test SVN repository locally with
> svnsync so that we can a) spare their bandwidth b) minimize the effect
> of network bottlenecks on stats - I'm sure you could get more
> impressive stats that way.

Excellent idea. Unfortunately, I don't have enough disk space to
mirror the whole ASF repository on my laptop- I'll try it when I get
back to my desktop (in 15~20 days).

In my prelimiary benchmark, I also found that I beat `svnsync` over
the same network connection :)

> Even better, having the SVN repo and the "exported" git repo on
> separate hard disks to minimize I/O as a bottleneck.

Unfortunately, a lot of middleware components are missing and we
cannot export it to a Git repository just yet- see my previous email
about this [1]. Great idea though- will try it in future.

> (Great work, by the way.)

Thanks, and thanks for the feedback! :)

[1]: http://article.gmane.org/gmane.comp.version-control.git/150035

-- Ram
