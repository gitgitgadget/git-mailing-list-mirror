From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: stgit: lost all my patches again
Date: Thu, 4 Oct 2007 08:10:12 -0400
Message-ID: <9e4733910710040510v53cd390el35cf5b4251e6d@mail.gmail.com>
References: <9e4733910710032229m38fb4e47k5aa0b2b2e0eb2251@mail.gmail.com>
	 <20071004083304.GB17778@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 14:10:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdPX6-0001Nd-9s
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 14:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797AbXJDMKQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007 08:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbXJDMKQ
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 08:10:16 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:5732 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbXJDMKO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2007 08:10:14 -0400
Received: by nz-out-0506.google.com with SMTP id s18so133266nze
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 05:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CdHPAPaBaYwyrLAK8Q5JksTI6wgJKeA7V6F9zdVIWWI=;
        b=DSa3KfAR9E77QNg/aSaJfQ+s0e5WTcS7PKS0DZaB+8GCQUcMfRGvJkqa1blqd9wpXWaRxj0z24zcLRqTgsNeU3o92Bw/oIIOScEC1zmg66DXHik+eDhzPlM/9mU7ydamWKTQJfckhNKFx24/X2cVV9e4EWYY//U+qYPIl5Y9BHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k5ZESNqwiOxYRYmaBwqUS2K99CHqhoIZhQW0WIIX3N0d4UzaYKca1ugQM5sMDovpJF2bEhYvVPGzd8gosZXjiX/NaEI9gakgL3wQW+cgO4cNTg9Tn39cL5MKTYKj37HujRwHL1iOXWiOVVEOmERC8iVLslKQL8s3mVTSX+9xTN0=
Received: by 10.114.56.1 with SMTP id e1mr7014905waa.1191499812892;
        Thu, 04 Oct 2007 05:10:12 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Thu, 4 Oct 2007 05:10:12 -0700 (PDT)
In-Reply-To: <20071004083304.GB17778@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59940>

On 10/4/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-10-04 01:29:17 -0400, Jon Smirl wrote:
>
> > for some reason the refresh from that command didn't close. Then st=
g
> > pushed all the patches back after the edit and they got included
> > into that patch.
>
> That's really weird. As far as I know there isn't a concept of
> "closed" patches in StGit -- there's no need, because they're always
> closed!

Must be the other way around then, the next nine patches didn't get
opened right. Their descriptions ended up in the right place but the
deltas all ended up in the first patch.

> > I did the 'stg refresh' from a directory that was not being tracked
> > by git. It is in the .gitignore list. This appears to be the root o=
f
> > the problem.
>
> Mmmph. This is not the only StGit command that's apparently not safe
> to run from a subdirectory. See e.g. https://gna.org/bugs/?9986.
>
> I plan to do some StGit hacking this weekend. I guess subdirectory
> safeness ought to be at the top of my list ...
>
> --
> Karl Hasselstr=F6m, kha@treskal.com
>       www.treskal.com/kalle
>


--=20
Jon Smirl
jonsmirl@gmail.com
