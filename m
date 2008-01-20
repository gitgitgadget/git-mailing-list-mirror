From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Any command to simplify 'git fetch origin && git reset --hard origin/master'?
Date: Sun, 20 Jan 2008 16:51:19 +0800
Message-ID: <46dff0320801200051p4dd21930u5712a72baaf9af78@mail.gmail.com>
References: <46dff0320801182122t1581b366yad123407aaad6326@mail.gmail.com>
	 <alpine.LSU.1.00.0801191114310.5731@racer.site>
	 <46dff0320801190603w4f0b2595v495ed10f2a87b0cc@mail.gmail.com>
	 <alpine.LSU.1.00.0801192247280.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 20 09:51:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGVuF-0004bp-2i
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 09:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbYATIvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 03:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbYATIvX
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 03:51:23 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:32398 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbYATIvW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 03:51:22 -0500
Received: by py-out-1112.google.com with SMTP id u52so2301964pyb.10
        for <git@vger.kernel.org>; Sun, 20 Jan 2008 00:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6Ryvzx+HDbTSh+ZAKAdZorw00Ajn7JHK/nZQ7I9dXko=;
        b=rWq/MNuuXTBSmRKtN3d+O0HMmNR95ZS3Bz+6kwXfaHZMo0K74zXJN/27jcVpeRTKeUJgby1JWZFm+gwHZzv4CR9w1N3dpehnqYsCcHShZCEsXb4pyOSppxfjmP1BQ07SGrc2Zl5l18PMDFcyNhig7/VP1D9yIrjhCjzFOHFDBjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l0Mk/kEjD2dGIAW9TupKP8FS3UDPGWj14vHM0B4mTr6YeNTrcgz/4lmj7gWEzLgFtbS6dDWnrBfklUGRTmBGoaTHoUGPoanEsolNvlW1+5EYva+6gNeP0JFhGxkwjJVqe727q93ShBct9LoqDwb8Jx7omqoOZ5v7mfnWt6gkmug=
Received: by 10.35.96.6 with SMTP id y6mr6254536pyl.46.1200819079062;
        Sun, 20 Jan 2008 00:51:19 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sun, 20 Jan 2008 00:51:19 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0801192247280.5731@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71165>

On Jan 20, 2008 6:50 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 19 Jan 2008, Ping Yin wrote:
>
> > On Jan 19, 2008 7:15 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > > On Sat, 19 Jan 2008, Ping Yin wrote:
> > >
> > > > I often encounter the case that the origin reposotory is rebased and
> > > > i make sure i want to use the origin head as my master Now I have to
> > > > do
> > > >   $ git fetch origin && git reset --hard origin/master
> > >
> > > Just make an alias if you're too lazy to type.
> > >
> > > Personally, I do not see much sense in it, and it is too dangerous to
> > > bless it with an option to fetch or pull.
> >
> > Can any alias do this? Since a parameter 'origin' or something should be
> > passed in.
>
> Yes.  Something like
>
>         $ git config alias.imtoolazytotype \
>                 '!sh -c "git fetch $0 && git reset --hard $0/master"'
>
> See http://git.or.cz/gitwiki/Aliases for more, especially the part about
> advanced aliases with arguments.
>
wonderful!
> Hth,
> Dscho
>
>



-- 
Ping Yin
