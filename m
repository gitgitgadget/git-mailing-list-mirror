From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: configuring git public repository
Date: Fri, 12 Sep 2008 16:36:11 +0200
Message-ID: <8c5c35580809120736x4170b2dbq3438bd619326ae00@mail.gmail.com>
References: <19449377.post@talk.nabble.com>
	 <8e04b5820809120533o1e7da548l6868660767a5435d@mail.gmail.com>
	 <m3vdx1o72x.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Ciprian Dorin Craciun" <ciprian.craciun@gmail.com>,
	sagi4 <geetha@angleritech.com>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 16:37:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke9m0-0000BH-Qe
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 16:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbYILOgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 10:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461AbYILOgR
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 10:36:17 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:10088 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbYILOgR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 10:36:17 -0400
Received: by wr-out-0506.google.com with SMTP id 69so547796wri.5
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yhAkxGXJe9727bPu+rwV61j0wpPhysk+377NpDXBrtU=;
        b=ktHjCMLJpkgzap5C7Lq4k9jjllJ2oOWmw0QUrVXRytVCLHig4Ys2zJjSNVcCb2oV6o
         VjEdO2yQ6b+CthmzA11hYDktwD12tC+5iPaOv5RIFO6j8KwCZAwouvz+3r1F1p+XtKD3
         F6Pcws8cJRXqxDPtIr+hwbt/1Hmd3C4MKA6As=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=l7eG3b0odY7larxSyZwTnEtUiUtAxyOi6qiUk/Sw2qndXqPNIBYUmZ1xdHSvCCRQSK
         errpH5brnhn2N7er1Xe47oWiTg/aEyb84c+qkVlt6V6P9N8btynGun1iRM4wzgYMUzXf
         7SyZriAOS8lT6I+4BDSw+wWJlAquxxt3eh2sc=
Received: by 10.114.196.13 with SMTP id t13mr3394699waf.219.1221230172379;
        Fri, 12 Sep 2008 07:36:12 -0700 (PDT)
Received: by 10.114.166.20 with HTTP; Fri, 12 Sep 2008 07:36:11 -0700 (PDT)
In-Reply-To: <m3vdx1o72x.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95727>

On Fri, Sep 12, 2008 at 2:57 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>
> "Ciprian Dorin Craciun" <ciprian.craciun@gmail.com> writes:
>
> > On Fri, Sep 12, 2008 at 7:47 AM, sagi4 <geetha@angleritech.com> wrote:
> > >
> > > Hi all,
> > >
> > > I am new git..
> > >
> > > I would like to configure git as a public repository for my rails
> > > application..
>
> >    -- by using gitweb? and serving it as http://...;
>
> Gitweb (and cgit, and git-php) is _web interface_ to repository, which
> means that you can check the state of repository, view current version
> and the log of changes, and many other things from a web browser.

<plug>
Current cgit also allows cloning over http using the same url as for
browsing the repo, i.e. you may

  $ git clone http://hjemli.net/git/cgit

This has one advantage over just publishing the repo; you don't have
to run `git-update-server-info` (thanks to the work done by Shawn O.
Pearce on git-http-backend, which is shamelessly reimplemented in
cgit).
</plug>

--
larsh
