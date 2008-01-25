From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: stgit: per branch cover letters
Date: Fri, 25 Jan 2008 12:03:10 -0500
Message-ID: <9e4733910801250903qcb53430p522b36197443a030@mail.gmail.com>
References: <9e4733910801250657p2d7fdc66o8a631d7587125949@mail.gmail.com>
	 <20080125164633.GA12321@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 18:04:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIRy8-0004nf-Di
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 18:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954AbYAYRDO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2008 12:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755566AbYAYRDN
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 12:03:13 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:20493 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326AbYAYRDL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2008 12:03:11 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1170444wah.23
        for <git@vger.kernel.org>; Fri, 25 Jan 2008 09:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=bq3ftrJqU390ChYwnxlZdTH/rAo6DReY+Ja4r46srq0=;
        b=HXjf6mbg3MM0wWtCg7caIKoGwk9EBPCQAOP8bXi4+v6p0G2ibhK0OZIiAwQgDAriMXemHlOVura2QG5SWGic2GuqTU6/5eoPmxfbi67WuLI9z9+9kqDKcJ3J8KtG63d1Sueu4T+6WwKbyow8KjH96IlYUofkCHmcSm9TAAL+YTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fAGLjcdc4SKAZnJIsMT94QV4MM09ma5HQuDcYSX/KuazwRiSENix33W+wNCO0yWsjvTTR6u71AKdZeLbnUfA2UlktdSb6yiFcdksBuLazKOo6717PM0UuPnDmoStJDWBI26M6IMceVET0SxL3FMHhRd5V+twzzl/JuoBX1vSE24=
Received: by 10.114.200.2 with SMTP id x2mr2576579waf.19.1201280590635;
        Fri, 25 Jan 2008 09:03:10 -0800 (PST)
Received: by 10.114.93.14 with HTTP; Fri, 25 Jan 2008 09:03:10 -0800 (PST)
In-Reply-To: <20080125164633.GA12321@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71719>

On 1/25/08, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-01-25 09:57:50 -0500, Jon Smirl wrote:
>
> > It would be convenient to have per branch cover letters that are
> > stored by stg and get automatically applied when a patch set is
> > mailed. Use 'stg edit' to alter them. The first time you email a
> > series you would get an editor to write the cover letter if you
> > hadn't already done it. You could track the "to=3D" this way also.
>
> I don't think we need to get quite that fancy. Wouldn't it suffice to
> have a --cover-file=3D<filename> option to stg mail, and if both
> --cover-file and --edit-cover were given, update that file with new
> diffstat etc?

I have five patch sets I'm currently juggling. It would be a lot more
convenient if stg remembered which cover letter went with the patch
set, the recipients for the mail and the current patch version/prefix.
In my tree each patch set is in it's own branch.

I can edit the config file to change these if need, I don't need a
fancy editor interface.


>
> And per-branch config options if you want to set these permanently, o=
f
> course.
>
> > Another useful feature would be a config option that says something
> > like "prompt for new version" when mailed. Now each time you mail
> > the series it throws you into the cover page editor with an
> > incremented patch version. You can just quit out of the editor if
> > you don't want to increment the version.
>
> Patches without cover letters can also have versions, so I don't thin=
k
> associating versions with cover letters is a splendid idea, but I get
> your point.
>
> I guess a solution much like the one for cover letters would work
> here. A separate file, and command-line and config options to point t=
o
> it.
>
> > I didn't know I wanted features like this until I made a patch that
> > has gone through 25 versions.
>
> Your feedback is much appreciated. Keep at it!
>
> --
> Karl Hasselstr=F6m, kha@treskal.com
>       www.treskal.com/kalle
>


--=20
Jon Smirl
jonsmirl@gmail.com
