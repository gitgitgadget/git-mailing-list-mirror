From: Marcin Owsiany <marcin@owsiany.pl>
Subject: Re: git-svn stubbornly re-creating branch "master"
Date: Sat, 6 Jun 2009 11:55:01 +0100
Message-ID: <20090606105501.GA29758@beczulka>
References: <20090329171347.GA26866@beczulka> <37fcd2780903291252i19bba8ccx9dfb73e763d95b15@mail.gmail.com> <237967ef0904030357u15ef77f2rb3299b6f6c651404@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 12:55:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCtYZ-0005vg-FN
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 12:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbZFFKzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 06:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbZFFKzH
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 06:55:07 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:52355 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbZFFKzF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 06:55:05 -0400
Received: by ewy6 with SMTP id 6so2844617ewy.37
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 03:55:05 -0700 (PDT)
Received: by 10.216.12.198 with SMTP id 48mr1553076wez.223.1244285705021;
        Sat, 06 Jun 2009 03:55:05 -0700 (PDT)
Received: from beczulka (dsl-49-57.dsl.netsource.ie [213.79.49.57])
        by mx.google.com with ESMTPS id m5sm2557538gve.3.2009.06.06.03.55.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 03:55:04 -0700 (PDT)
Received: from mowsiany by beczulka with local (Exim 4.69)
	(envelope-from <marcin@owsiany.pl>)
	id 1MCtYD-0004J3-SC; Sat, 06 Jun 2009 11:55:01 +0100
Content-Disposition: inline
In-Reply-To: <237967ef0904030357u15ef77f2rb3299b6f6c651404@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120908>

This discussion seems to have stalled...

On Fri, Apr 03, 2009 at 12:57:52PM +0200, Mikael Magnusson wrote:
> 2009/3/29 Dmitry Potapov <dpotapov@gmail.com>:
> > On Sun, Mar 29, 2009 at 18:13:47 +0100, Marcin Owsiany
> > <porridge@debian.org> wrote:
> >>
> >> As you can see, "master" sprang back to life after the last command.
> >
> > It looks like git-svn does not like a repo without 'master'. It seems
> > the problem was caused by this patch:
> > http://git.kernel.org/?p=git/git.git;a=commit;h=1e889ef36c45b5554f7e317493ed3f4f901f8d9f
> >
> > I have added Eric to CC...
> 
> Why not just check if HEAD points to a valid commit, rather than
> master? It should do the same
> in the newly created repo case, and stop annoying people on updates.

There seems to be agreement that while conventions are nice, git should
not force branch names on people. Can someone implement Mikael's
suggestion?

-- 
Marcin Owsiany <marcin@owsiany.pl>              http://marcin.owsiany.pl/
GnuPG: 1024D/60F41216  FE67 DA2D 0ACA FC5E 3F75  D6F6 3A0D 8AA0 60F4 1216
 
"Every program in development at MIT expands until it can read mail."
                                                              -- Unknown
