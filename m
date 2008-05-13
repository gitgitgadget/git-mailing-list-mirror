From: "=?ISO-8859-1?Q?Steve_Fr=E9cinaux?=" <nudrema@gmail.com>
Subject: Re: Using git from Python
Date: Tue, 13 May 2008 09:39:32 +0200
Message-ID: <f35478f50805130039s6dfe9411j63411f2f7a7db6c3@mail.gmail.com>
References: <alpine.DEB.1.10.0805071612510.26718@sf.creativecommons.org>
	 <9b013f14-c193-41bc-923f-5f9a09d4fd60@56g2000hsm.googlegroups.com>
	 <alpine.DEB.1.00.0805121116560.6810@swallowtail>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Dill <sarpulhu@gmail.com>, git@vger.kernel.org
To: "Asheesh Laroia" <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Tue May 13 09:40:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvp7s-00042s-6t
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 09:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756435AbYEMHj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 03:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755716AbYEMHj4
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 03:39:56 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:24993 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782AbYEMHje (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 03:39:34 -0400
Received: by an-out-0708.google.com with SMTP id d40so547991and.103
        for <git@vger.kernel.org>; Tue, 13 May 2008 00:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=pDGA0DDHteZyHFZz6K9516sqyDIPWcfBx4+xJvG9F0o=;
        b=dDNwjChv5AdM22p9xIivvs76q84tJAcu1Vw3xUu2QToLZpYDIXwJZIWYmcklQhzlCeF6woE8lVCycydBA06J2Vz8Vn4DhvFpduGNLsv9Dij/wsgUq/WMs8CGK/OwK3zISIZalm4uy4vbeyLdSHh8Va5Gw5Mvtph9FfuvXa5lMZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GX63QAVecyuXc42osu+vlDXi3n7VWIp3qd/05/bJMO/h85QVoGVHVbAb4YeYW4OLLPbu9yKwXZbW4fdxtis8nV5GvA9Az8PLuqyrU60xLhgtqYAci4bIsGNkeVOkR757Xsif10/qwXKpkon8eseqhSvuDW7vimSzEoPWafP3mDY=
Received: by 10.100.240.17 with SMTP id n17mr9309875anh.49.1210664372509;
        Tue, 13 May 2008 00:39:32 -0700 (PDT)
Received: by 10.100.45.13 with HTTP; Tue, 13 May 2008 00:39:32 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805121116560.6810@swallowtail>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81997>

Hi,

It is very fun, because I started my own project ten days ago with
similar goals: making python bindings for git. Since I didn't have
much imagination at that time, I called it "pygit", eventually
renaming it later with a better name.

While being quite similar to git-python at first glance, its primary
goal is to feel as pythonic as possible, and to be suitable for
porcelainish scripts (in such, it is quite low-level wrt the
operations it allows, and has repository writing at the top of its
todo list)...

Despite it seems a bit older than gitpython if you look at the commit
history, it seems less mature, probably because it's written mostly
from scratch and not a raw port of the ruby bindings. For instance,
docs are still missing, which is why I didn't announce it to this list
yet. It seems it is roughly on par with git-python feature-wise,
though.

I hope you'll like this one too ;-)

Ah, I forgot: here it is: http://code.istique.net/?p=pygit.git

(If you get an error, try reloading the page, the server gets crappy sometimes)

PS. Comments welcome.

On Mon, May 12, 2008 at 8:17 PM, Asheesh Laroia <asheesh@asheesh.org> wrote:
> On Fri, 9 May 2008, Dill wrote:
>
>
> > Also check out: http://gitorious.org/projects/git-python/
> >
>
>  That looks very friendly and object-oriented.  It doesn't seem to have
> write support, based on a quick look - is that right?  Is write support a
> feature you're considering adding?
