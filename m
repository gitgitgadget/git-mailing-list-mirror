From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: kha/safe and kha/experimental updated
Date: Tue, 18 Dec 2007 16:52:18 +0000
Message-ID: <b0943d9e0712180852y62c5bea2x61463b235b26ca04@mail.gmail.com>
References: <20071214105238.18066.23281.stgit@krank>
	 <b0943d9e0712170309n415dc6cs9d1c1f8a9c687bf8@mail.gmail.com>
	 <20071217224812.GA6342@diana.vm.bytemark.co.uk>
	 <20071218052115.GA13422@diana.vm.bytemark.co.uk>
	 <b0943d9e0712180809l4d2d01b8j32ab2a410885cc5e@mail.gmail.com>
	 <m3hcigot3h.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	"=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 17:52:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4fgU-0005Rm-VX
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 17:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758033AbXLRQwW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 11:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756948AbXLRQwW
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 11:52:22 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:19649 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763AbXLRQwV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Dec 2007 11:52:21 -0500
Received: by wr-out-0506.google.com with SMTP id c49so1739657wra.1
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 08:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=PvaARQ41e3vnRi1v+giZpvvRyE92FgW5frQUWsHky6g=;
        b=bJ4nAUGL2bm+L28rRT/CRC8JheYaZBOjPbQXfBxDd+ndhZ0RgB6vOb+LwL+2vDA7aOBb0AK15VTBARwGzIQwuXRquo0071nc3cCLZc3vMzHCnCte8YX5G6LF2iD8ECGrIGRDGVm3T6HVSSIrp+giq+ayf4tqE5pgJ5NjjKuac10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lpr7P1o8XBeaeWyGr8JZwuQ7clRhNNsQE4gi3CFqyRaIEei3Kgl/kblB8nEzPlKT1uqHC6HAs5JbvFyg4Os3NM31yxJgs1CGB63mlAJe97owl5587U8Xb93ZQlvaPvYPoB1KCmDnPt5mRpYXE3EyPhIH2atxzRyKnPjjYhRRaNk=
Received: by 10.140.207.16 with SMTP id e16mr5064177rvg.297.1197996738833;
        Tue, 18 Dec 2007 08:52:18 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Tue, 18 Dec 2007 08:52:18 -0800 (PST)
In-Reply-To: <m3hcigot3h.fsf@roke.D-201>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68779>

On 18/12/2007, Jakub Narebski <jnareb@gmail.com> wrote:
> "Catalin Marinas" <catalin.marinas@gmail.com> writes:
>
> > Thanks again for maintaining these branches.
> >
> > On 18/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> > >   git://repo.or.cz/stgit/kha.git safe
>
> > >       Remove "stg resolved"
> >
> > I'd like to keep this command. git-mergetool doesn't support the to=
ol
> > I use (emacs + ediff and more stgit-specific file extensions like
> > current, patch etc.). I also don't find 'git add' to be meaningful =
for
> > marking a conflict as solved.
>
> I also would like to have this command kept (and shown in 'stg help'!=
).
> Contrary to 'git add' it can check and add to index / update index
> only for files with conflict; we have -r (ancestor|current|patched)
> to choose one side, and we could add --check to check if there are
> no conflict markers with files (useful with -a/--all).

I'd also like to re-add the stgit.keeporig option and additional
functionality so that the *.{ancestor,current,patched} can be left in
the working tree. Some people might use them when manually fixing
conflicts (I have a look at them from time to time when the emacs +
ediff shows a hard to understand conflict).

--=20
Catalin
