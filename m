From: Javier Domingo <javierdo1@gmail.com>
Subject: Re: Centralized git
Date: Tue, 31 Jul 2012 15:08:27 +0200
Message-ID: <CALZVapm-=HXdfb6LCrc60HgUJA0ptzb+E5r3Y1C2w_0eBo1onQ@mail.gmail.com>
References: <CALZVapnwGK=cKdHbZRsN0Ust7TAvFqa3AmYD7pzgoxdDxQh+uw@mail.gmail.com>
 <CALZVapkUu+hckMRAaNULSW5s9Q7P+78eVt1Q+ZrKFdPYb5uFVQ@mail.gmail.com>
 <CAH-tXsCGxpqP+C2CiCCB88exMT6H3w0id-otFWPRXrhhreRfWg@mail.gmail.com> <CALZVapniy5iNJbuOikZdgHv2qQ80nDSATw8udV=Tk2wNgxXY4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: jaseem abid <jaseemabid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 15:08:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwCBy-00083o-Ne
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 15:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882Ab2GaNIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 09:08:49 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:52636 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab2GaNIt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 09:08:49 -0400
Received: by weyx8 with SMTP id x8so4313357wey.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 06:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XvqJeXd/V0FuNNAm6LZwB5ZKm2bV8e1f9AbZHjx+TwU=;
        b=CSN0TMQVTELojtwSDppd9C7YYfwyVJOzCj7Naer38sLrEpDDhSa0PtSQetD836FRYk
         K4AAh8kClcNdkPZEPkRi+a1R8tGtUYi9GZz0UsY9xA/nNbhsQt8pimip2hk7jJEYVDcd
         JaG1bxQEUCml7m1wDgCtRSKTvmKNKDqMtfUlNDo/sf0pANrSJBEBk990L9HTHCdbJ5bF
         Bczt5I8GejzBR3F8KozBonnPfUF2NqcbdQtTWpICKqc1FTkM8p1gG6qk7Uj7Gi0dQ18E
         vKrLEx4vIONxzRPxQ/IofZECTYHLKrjddS/srmrcua47lYBBUZFzmUlQ30gBudqLqY2h
         US6g==
Received: by 10.217.2.197 with SMTP id p47mr7049529wes.55.1343740127998; Tue,
 31 Jul 2012 06:08:47 -0700 (PDT)
Received: by 10.216.55.211 with HTTP; Tue, 31 Jul 2012 06:08:27 -0700 (PDT)
In-Reply-To: <CALZVapniy5iNJbuOikZdgHv2qQ80nDSATw8udV=Tk2wNgxXY4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202653>

Network, in this case is cheaper. The thing is that If I commit
frecuently, will have plenty of GBs of history, that nearly for sure I
won't use. I just need to have other people's work to merge. But I
want to think in Git style, I am pretty accustomed to that way of
doing things. That is why I sent this mail here.

The idea is that if I modify 700MBs of video, with 20 commits I would
get in 21GB. And making a pull would be... just even more horrible
than anything. That is why I need to have also last checkouts filter.
Just download branch's HEADs.

Javier Domingo



2012/7/31 jaseem abid <jaseemabid@gmail.com>
>
> On Tue, Jul 31, 2012 at 5:33 PM, Javier Domingo <javierdo1@gmail.com> wrote:
> >
> > I am currently planifying a 3D project, and I will be having large binary
> > files. If I add a distributed VCS, the amount of disk space required will
> > increase significantly.
>
>
> You are going to transfer something that wont fit into your hard disk
> up and down your network once in a while ?
>
> I assume disk to be cheaper than network.
>
> --
> Jaseem Abid
> http://jaseemabid.github.com
