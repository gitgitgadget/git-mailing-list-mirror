From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 00/17] Series short description
Date: Tue, 18 Dec 2007 09:11:00 +0000
Message-ID: <b0943d9e0712180111l3294e1adj60b5271b9820c60c@mail.gmail.com>
References: <20071214105238.18066.23281.stgit@krank>
	 <b0943d9e0712170309n415dc6cs9d1c1f8a9c687bf8@mail.gmail.com>
	 <20071217224812.GA6342@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 10:11:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4YU4-0003AV-Dr
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 10:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbXLRJLF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 04:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbXLRJLF
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 04:11:05 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:53717 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbXLRJLB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Dec 2007 04:11:01 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2199883rvb.1
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 01:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=s2AMcxbsD4Ph1RVYSIpoefRs1IvhIpI/xeVvgVszm7o=;
        b=jjbeK8CGQvsGCO6xVdJDiIs0/b8YA9MKhtLqVtHlj462b9oN+bI9X4vxVLJsLYvpvPniJIW9MeGiou5b7gfdl1Zy2QBSB3tONRhsw1kTUFcLQSIDK7KVJaN9+PS3pVh5fgQ0RsQP9gMoCIY1GHaP8G7M7QYT9QkbaX4ioapv7do=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=reOrPrcvz0l5aymezVQuobDZExRo3CGsV7i8NweEQcx3kNuo3CZiO9d+gENmYkkcjksWlbOcDjCdwtPwzvldrYm5dw18f3+iELYu807BZje8K6uYwtvfBvJZaFOEwK9+9WOmefK02y3oAXvGt4ZVSynPfiiE+up+15nIVY4Kr6s=
Received: by 10.140.158.4 with SMTP id g4mr3495310rve.44.1197969060187;
        Tue, 18 Dec 2007 01:11:00 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Tue, 18 Dec 2007 01:11:00 -0800 (PST)
In-Reply-To: <20071217224812.GA6342@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68712>

On 17/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-12-17 11:09:06 +0000, Catalin Marinas wrote:
>
> > On 14/12/2007, David K=E5gedal <davidk@lysator.liu.se> wrote:
> >
> > > The following series an emacs interface to stgit patch stacks. It
> > > shows a buffer with the the output of "stg series" and allows you
> > > to do some common operations on it, such as push/pop,
> > > commit/uncommit, edit, rename, repair, and coalesce.
> >
> > That's really cool stuff! Thanks.
>
> Yes, incredibly useful.

Other useful commands would be support for 'patches' and a local
diff/status (and maybe a menu).

> Be careful about merging past the "goto" patch -- I'm pretty sure it
> breaks when called from a subdirectory, and I don't have time to fix
> that right now. (It should be a clean fix, though -- just adjust the
> cwd for precisely those git subprocesses that need it, which is very
> few. I think.)

Why not just change the cwd when the command starts and it should be
safe for all the git subprocesses.

> If you like, I can advance "safe" to include as many patches as I
> think you should merge right now.

OK, thanks.

--=20
Catalin
