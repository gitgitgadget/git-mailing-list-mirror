From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit RFC] A more structured way of calling git
Date: Sat, 3 Nov 2007 10:56:36 +0000
Message-ID: <b0943d9e0711030356j4dcd31cbl54d838107240b3d0@mail.gmail.com>
References: <20071026192418.GA19774@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Yann Dirson" <ydirson@altern.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 11:57:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoGgT-0006Rq-Vs
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 11:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbXKCK4i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Nov 2007 06:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbXKCK4i
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 06:56:38 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:44576 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbXKCK4h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Nov 2007 06:56:37 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1026796rvb
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 03:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=eRgHo3cAIQ7G6d37XRZhpQyjC4zxQzkvWXUj2O7QGdI=;
        b=ID3qnrEYQqseqgrrO0BDzTdTRg2YkAeuGlkNurKz39oUi1N82wtjGpctCFeb5RCgj10Kgsiu7XdRRDeX5uhp+OQd0044aPTY7PZ9Md2K3+Uc9+PDo4RCmyuP6k5/BCpeDTGJ8b/GFZB14Qa6VhjZ+N1GZkoUdgLNVImsy15vFTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t6XMKrIlHOik60V2AYKRixIfqe4NSWgOOUGotpZ9d4kz6AUsq+DHC5MHnqfxI5uSditptfBlaUxKdA99K5F2fJxWznt8TNq/9RY/NBbkf6a6QdrUF3A2bSz9thHsTXnfWJ7hkW2rUV9rcYlH/K5pbRBfGRm7MllE2jSNarNF9w8=
Received: by 10.141.23.7 with SMTP id a7mr1382547rvj.1194087396657;
        Sat, 03 Nov 2007 03:56:36 -0700 (PDT)
Received: by 10.140.158.1 with HTTP; Sat, 3 Nov 2007 03:56:36 -0700 (PDT)
In-Reply-To: <20071026192418.GA19774@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63229>

On 26/10/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> I wanted to build an StGit command that coalesced adjacent patches to
> a single patch. Because the end result tree would still be the same,
> this should be doable without ever involving HEAD, the index, or the
> worktree.

Wouldn't HEAD need to be modified since the commit log changes
slightly, even though the tree is the same. Or am I misunderstanding
this?

> StGit's existing infrastructure for manipulating patches
> didn't lend itself to doing this kind of thing, though: it's not
> modular enough. So I started to design a replacement low-level
> interface to git, and things got slightly out of hand ... and I ended
> up with a much bigger refactoring than I'd planned.

Thanks for this. I'll need a bit of time to read it all and give
feedback. In general, I welcome this refactoring.

I'll go through the whole e-mail in the next days and get back to you.

--=20
Catalin
