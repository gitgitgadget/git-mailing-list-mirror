From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: kha/safe and kha/experimental updated
Date: Wed, 19 Dec 2007 10:19:23 +0000
Message-ID: <b0943d9e0712190219oa6ebe5bk321f090e4fe0469a@mail.gmail.com>
References: <20071214105238.18066.23281.stgit@krank>
	 <b0943d9e0712170309n415dc6cs9d1c1f8a9c687bf8@mail.gmail.com>
	 <20071217224812.GA6342@diana.vm.bytemark.co.uk>
	 <20071218052115.GA13422@diana.vm.bytemark.co.uk>
	 <b0943d9e0712180809l4d2d01b8j32ab2a410885cc5e@mail.gmail.com>
	 <m3hcigot3h.fsf@roke.D-201>
	 <b0943d9e0712180852y62c5bea2x61463b235b26ca04@mail.gmail.com>
	 <87bq8nkoma.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
To: "=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Wed Dec 19 11:20:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4w21-0000zV-Pp
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 11:20:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978AbXLSKTZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 05:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752972AbXLSKTZ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 05:19:25 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:4044 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623AbXLSKTY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 05:19:24 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2602461rvb.1
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 02:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Ts721IHF2bbG6+GvTlFzjW9VKLKSvpCrqmqvJiRYo14=;
        b=IAl2ohS5A63pd5xTmKmt0vFhPxWFFAQtpFk73E0CR2gR49cOc3yPe2vjPOctKwGelG3z+sK/ZfNPuosOgDOoKmr0ClUkti07w0PyA8UXMv6u2qhKvmAhWm/FbAamKwMsdv4PgWLU5hp5LzOMoA5avfDXwAmUbS7u0Mo1FNbRDd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=u+NuoGpMAAkUYylJ5n0+zp3gAWkAmoUPvzICmtuQvi1fVkUBYT+PKPAEwik8a0CIV5HYhK+OSRlLIc/aIH2Pr/VRNTQEcZqHn5PKzIbZ3GsLnv+BVWq+bTfcpczXxZhk/phSjG2m3LbShhC7KOsfwH5D2+G0rrGw6zMiY7JvH+c=
Received: by 10.141.132.8 with SMTP id j8mr1313511rvn.125.1198059563444;
        Wed, 19 Dec 2007 02:19:23 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Wed, 19 Dec 2007 02:19:23 -0800 (PST)
In-Reply-To: <87bq8nkoma.fsf@lysator.liu.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68880>

On 19/12/2007, David K=E5gedal <davidk@lysator.liu.se> wrote:
> "Catalin Marinas" <catalin.marinas@gmail.com> writes:
> > I'd also like to re-add the stgit.keeporig option and additional
> > functionality so that the *.{ancestor,current,patched} can be left =
in
> > the working tree. Some people might use them when manually fixing
> > conflicts (I have a look at them from time to time when the emacs +
> > ediff shows a hard to understand conflict).
>
> Since all the information is in git, it is of course easy to recreate
> it. But the important question to ask is: how do you use these extra
> files? git.el provides a way to diff against both parent versions, an=
d
> maybe that is actually what you need.
>
> I don't mind that you want these files, but they are mostly clutter t=
o
> me.

You can set stgit.keeporig to 'no' if you don't want these files.

=46or people not using emacs + git.el, the files might be useful. As yo=
u
said, you could use 'git diff -2/-3' but, in various occasions I just
wanted to copy a block of code from one of the checked-out stages.
Without this feature, I would have to use plain git and remember what
stage corresponds to my patch.

Note that there are other users (apart from me) that use StGIT almost
exclusively. I really don't like forcing them to use more and more
plain git commands (at some point, they might even discover 'git
rebase -i' to be good enough and give up on StGIT :-)).

--=20
Catalin
