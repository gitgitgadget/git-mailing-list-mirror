From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: stgit: managing signed-off-by lines
Date: Fri, 25 Jan 2008 09:43:51 -0500
Message-ID: <9e4733910801250643u11819491i961d092deae7c5d7@mail.gmail.com>
References: <9e4733910801241227n659a5b34x7f77f25101aa225f@mail.gmail.com>
	 <20080125083853.GA5804@diana.vm.bytemark.co.uk>
	 <9e4733910801250534s7ab11b15uff3c782165a8e2ea@mail.gmail.com>
	 <20080125143026.GA10132@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 15:44:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIPnC-0005wq-6D
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 15:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915AbYAYOnx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2008 09:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752901AbYAYOnx
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 09:43:53 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:47498 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbYAYOnw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2008 09:43:52 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1108145wah.23
        for <git@vger.kernel.org>; Fri, 25 Jan 2008 06:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Im7d+A9v+PpFwjRPnlS8G3FLqQ33f/NKvm9Y3S8sc08=;
        b=sAm7kZ0jSXqSiYE1dzQUbM8lraEPo/BNhBlLWQQeWQNHNY13j+b97XzvpoljYpd89VpWE1mkaq8KRDU2lulHgfhXqsVe0f7IJKa/zqWqSOI4sJRkWFC+klVLQbRQRDrMy3dffRZGJUMGIG5xexkjfo7cvYn1rw1qNpRRWh6fhvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bG61S+UU8lhlJ3beDoXHlk4rFhwNWywiPSUfeRCroZoSz+T020Q11MPWrrOom07MJR1JD8iLb8AV1+Fu05O+fwLJZcLQiUKfl4pfd5l/rdgp/2Q7qjZ3thnTgpg2a9wxOkt29t5M2lYpQgQV8zBxRMZaX6uKr1x0bKc8x+sR1Bg=
Received: by 10.114.110.12 with SMTP id i12mr2387174wac.73.1201272231178;
        Fri, 25 Jan 2008 06:43:51 -0800 (PST)
Received: by 10.114.93.14 with HTTP; Fri, 25 Jan 2008 06:43:51 -0800 (PST)
In-Reply-To: <20080125143026.GA10132@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71710>

On 1/25/08, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-01-25 08:34:53 -0500, Jon Smirl wrote:
>
> > On 1/25/08, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> >
> > > What command are you using to export patches?
> >
> > I am using "stg export" from one branch and then "stg import -s" on
> > another. After I import the patch and do 'stg edit' on it, it has
> > the signed-off-by line in it. When it is export from that branch th=
e
> > signed-off-by get added again.
> >
> > You don't want to strip the signed-off-by lines on import, they may
> > be from other people. I would think that on export you could look
> > and see if my signed-off-by line is already on the patch before
> > adding it again.
>
> I haven't set up my templates to add sign-offs on export; instead, I
> give --sign to "stg import". This always does the right thing:
>
>   1. It's smart enough to notice if my sign-off is already there, and
>      don't add another copy.
>
>   2. My sign-off is propagated even if the patches are transferred by
>      pulling instead of by email or "stg export".

Yes, I added Signed-of-by to the export and mail templates. I did it
six months ago and I had forgotten. I can fix this by just removing it
from the export template. I've learned to use 'stg mail' now and it is
the only way I publicly expose patches. It works to just add the
Signed-off-by at the email stage.

Longer term you may want to add a de-dupe check for the signed-off-by
lines that gets called in all contexts.
>
> For patches that I write myself (so that they are never "stg
> import"ed), I add the sign-off manually in the commit message, with
> the aid of this elisp snippet:
>
>   (defun sign-off ()
>     "Insert sign-off line."
>     (interactive)
>     (git-append-sign-off (git-get-committer-name) (git-get-committer-=
email))))
>
> Adding the sign-off conditionally in "stg mail" and "stg export", as
> you suggest, could of course be done. But that would have to be
> command line options, since the template system can't really express
> that kind of transformation.
>
> --
> Karl Hasselstr=F6m, kha@treskal.com
>       www.treskal.com/kalle
>


--=20
Jon Smirl
jonsmirl@gmail.com
