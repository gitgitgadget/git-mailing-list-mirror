From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Is there an updated version of git-vcs-p4?
Date: Mon, 13 Sep 2010 20:53:05 +0200
Message-ID: <AANLkTi=x7T+VgnC0s7L+un5UORc2LwisSF-EPrh8RAE0@mail.gmail.com>
References: <AANLkTi=okJRFeBhbURB8Ez4Vb65fNdacKeko+4sx9ihy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git mailing list <git@vger.kernel.org>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 20:53:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvE9n-0002Nx-JV
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 20:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856Ab0IMSx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 14:53:27 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44775 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372Ab0IMSx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 14:53:26 -0400
Received: by ywh1 with SMTP id 1so2130398ywh.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 11:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=bJDLpnzRWdWeeX9Fy/4vLbTBW0LgM/yfNycRC82F+Dg=;
        b=IScJPB+RbisaPSWb+DHBaoS3LsGGX7+8HRtuE0IEbpkG943txmanF9lv3JRBk4pOHa
         aQ7P4WYmkHkKMOged6vua5tQ7Z7XHz8dI9ILLQ0BuN100oIY+CqugpHEyoqE4QSABnwV
         ZR3mp1omJt/pwejFd3bUTwrqxI8Pgg35y8mpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xTRbbzgfZdMpRQ+aNZkadpH9OnUGJdb6kj70qBFKZkgSpdljfAUsJkChPJY/E8LuMl
         Bx4YwirrL69youh6tDvcWFptOCPYcZQXT8+2LUxDwhH8cmzNhT0QKr3lP3oguWb6k+1p
         5DzQF+MR/z/j/zw1xb1ISaQWpFrP02xr7Qqc0=
Received: by 10.151.6.4 with SMTP id j4mr241431ybi.274.1284404006075; Mon, 13
 Sep 2010 11:53:26 -0700 (PDT)
Received: by 10.150.204.21 with HTTP; Mon, 13 Sep 2010 11:53:05 -0700 (PDT)
In-Reply-To: <AANLkTi=okJRFeBhbURB8Ez4Vb65fNdacKeko+4sx9ihy@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156112>

Heya,

On Mon, Sep 13, 2010 at 11:04, Tor Arvid Lund <torarvid@gmail.com> wrote:
> I'm having trouble getting exporting to work. Looking at the C code, I
> quickly realize that there's _much_ I don't know anything about, but
> it seems to me that vcs-p4.c needs to support the "refspec "
> capability. Am I on the right track?
>
> My reasoning so far: the version of vcs-p4.c that I have, contained a
> prefixcmp for "export ". This made "git push" barf with the current
> version of transport-helper.c, so I did something like this:

The export capability that is now in git is different from the one
Daniel sketched initially. It's not really done for prime time anyway
(see my email to Shawn about it not working). If you're interested in
working on the git remote-helper infrastructure, let me know, and I
can tell you more about how it works in #git-devel on freenode.net for
example :).

-- 
Cheers,

Sverre Rabbelier
