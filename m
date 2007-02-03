From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] config.txt: update branch.<name>.merge documentation
Date: Sat, 3 Feb 2007 17:19:53 +0100
Message-ID: <8aa486160702030819k24a42ac4w115b83980d3ee17e@mail.gmail.com>
References: <87irejgsyj.fsf@gmail.com>
	 <20070203155652.GL5362@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Feb 03 17:20:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDNcj-0006zx-Mw
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 17:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946481AbXBCQT4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 3 Feb 2007 11:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946487AbXBCQT4
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 11:19:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:2562 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946481AbXBCQTz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Feb 2007 11:19:55 -0500
Received: by ug-out-1314.google.com with SMTP id 44so995954uga
        for <git@vger.kernel.org>; Sat, 03 Feb 2007 08:19:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=imcgAj0lW+ZRnOkUh1rvgW84b1qxeC0DuFvFSQRnlcb0jYQI3ggndyggAkeUbfrxD4Sdf0Jgv7XdhN/XwiyLwyRPsQ1koPsyXsEyNaE5zTq1WczQNK/uLgCbcZRu6NuL5+Kfhegnmut3VStRCl3KK4CXNrbSvKVb26ymY1NpLv8=
Received: by 10.78.203.13 with SMTP id a13mr922224hug.1170519593975;
        Sat, 03 Feb 2007 08:19:53 -0800 (PST)
Received: by 10.78.68.8 with HTTP; Sat, 3 Feb 2007 08:19:53 -0800 (PST)
In-Reply-To: <20070203155652.GL5362@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38572>

On 2/3/07, Yann Dirson <ydirson@altern.org> wrote:
> On Sat, Feb 03, 2007 at 04:29:40PM +0100, Santi B=E9jar wrote:
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index e5e019f..f129de9 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -233,11 +233,12 @@ branch.<name>.remote::
> >  branch.<name>.merge::
> >       When in branch <name>, it tells `git fetch` the default refsp=
ec to
> >       be marked for merging in FETCH_HEAD. The value has exactly to=
 match
> > -     a remote part of one of the refspecs which are fetched from t=
he remote
> > -     given by "branch.<name>.remote".
> > +     the remote or local part of one of the refspecs which are fet=
ched
> > +     from the remote given by "branch.<name>.remote".
>
> Since both local and remote refs are allowed, it would be useful to
> know how git-fetch decides how to handle them.  Looks like the 1st
> fetch refspec with that ref on either side is selected.

Yes, the first is selected.

>
> git-parser-remote also looks branch.*.merge with --get-all, so it is
> interesting to know what happens for multiple values (if git-fetch
> just marks them all, how does git-pull react ?).

The last sentence in the branch.<name>.merge says that it would
produce an octopus, is this enough?

Santi
