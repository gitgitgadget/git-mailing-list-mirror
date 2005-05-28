From: Daniel Serpell <daniel.serpell@gmail.com>
Subject: Re: More gitweb queries..
Date: Fri, 27 May 2005 21:03:24 -0400
Message-ID: <f0796bb705052718035cd5dbe2@mail.gmail.com>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
	 <20050527235924.GB19491@vrfy.org>
Reply-To: Daniel Serpell <daniel.serpell@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat May 28 03:01:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbphe-0004p0-Gl
	for gcvg-git@gmane.org; Sat, 28 May 2005 03:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVE1BD3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 27 May 2005 21:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVE1BD3
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 21:03:29 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:24806 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261895AbVE1BDZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 21:03:25 -0400
Received: by wproxy.gmail.com with SMTP id 68so959034wri
        for <git@vger.kernel.org>; Fri, 27 May 2005 18:03:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q4oIG6y0X+JG/vdFbh+SjTJMX3UvuBNSsniTG/yUiC9LavuKE0HZa5f46l1myfqLeZA0DuLmUNchLq/ihUNrxZLME+jngxT+tM78lB7tjBjSo2/+vQLj9t2s2fuIjzhoc0kBKOcDGUFyShp/XYQQPVCV+allFtweMsIzn8PZsuY=
Received: by 10.54.82.13 with SMTP id f13mr715975wrb;
        Fri, 27 May 2005 18:03:24 -0700 (PDT)
Received: by 10.54.18.68 with HTTP; Fri, 27 May 2005 18:03:24 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20050527235924.GB19491@vrfy.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi!

On 5/27/05, Kay Sievers <kay.sievers@vrfy.org> wrote:
> On Fri, May 27, 2005 at 12:24:20PM -0700, Linus Torvalds wrote:
> >   Combining some of the features of the two (that =FCber-cool revis=
ion
> >   history graph from gitk rules, for example) might be cool. I get =
the
> >   urge to do octopus-merges in the kernel just because of how good =
they
> >   look in gitk ;) ]
>=20
> I would like to show something like the graph too, but I don't really=
 know
> how to do this in html. Seems slippery if not impossible.
> If anybody has a nice idea how to represent that, I will give it a tr=
y.

Well, you could draw them in javascript, using
http://www.walterzorn.com/jsgraphics/jsgraphics_e.htm :-)

Alternatively, you could use a fixed set of little images, a bar "|", a
dot "o" and branches like "Y", "7" and "\". Obviously, octopus-merges
are very difficult to draw using only those.

BTW, I tried searching on gitweb, and I think that found a problem, see=
:
http://ehlo.org/~kay/gitweb.cgi?p=3Dgit/git.git;a=3Dsearch;s=3Dcheck
At the bottom of the page, highlighting of the search term stops and th=
e
commits are all the same color.

        Daniel.
