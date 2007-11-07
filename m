From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Inconsistencies with git log
Date: Thu, 8 Nov 2007 10:00:42 +1100
Message-ID: <ee77f5c20711071500x71008de5y5ea37aa1df2ba803@mail.gmail.com>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com>
	 <Pine.LNX.4.64.0711072242230.4362@racer.site>
	 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 00:01:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iptto-0000XE-Uz
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 00:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758405AbXKGXAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 18:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758491AbXKGXAo
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 18:00:44 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:44047 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758250AbXKGXAn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 18:00:43 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2190674rvb
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 15:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=JaNqxPSWMtlCZTbMJhuxQGwKcQHondymFVFXyG24W2w=;
        b=reM84ImhtNNfcxEC7EIRsf3wigDMFEH8b5HzDoYCeaaqpA4T48OFYW3W1fyzVN0GjDn161Fa0JCAxUsk2t026DtHF7sDvCj+zzH2KFAdK1eu/6P3LeKMJtdL4jsVWB1qfTJ6HTJspc1X8LjoObTkLyFMKGkIQNj5uVVbM/ODIQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SMC/rRWuPj8o1d5zTQgIJNgqY1JIT290gR1oZUK/uSnNlftXRZxro43M3cyTZi6YRXDNameF+9n/OVptJY3J3in7ogc37CTnem9N6xznO952jP356xBNSTjk6mqtAz8dmq87CXQVzbJgrGPZOYrnYC8mOoElT6OKP8i5VoujN4A=
Received: by 10.141.107.13 with SMTP id j13mr3887415rvm.1194476442897;
        Wed, 07 Nov 2007 15:00:42 -0800 (PST)
Received: by 10.141.115.4 with HTTP; Wed, 7 Nov 2007 15:00:42 -0800 (PST)
In-Reply-To: <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63887>

On Nov 8, 2007 9:45 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 11/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Wed, 7 Nov 2007, Jon Smirl wrote:
> >
> > > In project root:
> > >  git log arch/powerpc/platforms/52xx
> > > works as expected
> > >
> > >  cd arch/powerpc/platforms/52xx
> > >  git log arch/powerpc/platforms/52xx
> > > fatal: ambiguous argument 'arch/powerpc/platforms/52xx': unknown
> > > revision or path not in the working tree.
> > > Use '--' to separate paths from revisions
> >
> > Try "git log ."
>
> Shouldn't git log default to "git log ."?

It might be nice if it did, but since Git tracks whole *trees* (not
files) then it makes more sense to show the log of the repository in
its default mode.

On the other hand, it'd sure be nice if git-status would show relative
paths when you're in subdirectories, especially when you're in a
deeply nested directory hierarchy. It's a lot easier to see that
"foo.txt" and "../bar.txt" have modifications. Furthermore, it is the
relative path that you have to pass to git-add anyway, so quick
copy-n-pasting from git-status output often doesn't work.


Dave.
