From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit-2.1 and qgit-1.5.8
Date: Mon, 31 Dec 2007 19:07:50 +0100
Message-ID: <e5bfff550712311007j1cd8223es51b6a59dfb958193@mail.gmail.com>
References: <e5bfff550712302335ie96e143g55c93e984fba6aaa@mail.gmail.com>
	 <4778CB78.2010906@yahoo.it>
	 <e5bfff550712310358g347d883fm9866f328f24e3ad0@mail.gmail.com>
	 <47792B3E.60509@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Filippo Zangheri" <filippo.zangheri@yahoo.it>,
	"Linux Kernel Development" <linux-kernel@vger.kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Boaz Harrosh" <bharrosh@panasas.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753296AbXLaSIE@vger.kernel.org Mon Dec 31 19:09:15 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753296AbXLaSIE@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9P4X-00076r-SV
	for glk-linux-kernel-3@gmane.org; Mon, 31 Dec 2007 19:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbXLaSIE (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 31 Dec 2007 13:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbXLaSHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Dec 2007 13:07:52 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:15039 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbXLaSHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Dec 2007 13:07:51 -0500
Received: by rv-out-0910.google.com with SMTP id k20so4641491rvb.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2007 10:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2G7V2lnKF4rpIhIcA+zaagB4gjti4Kc8HY6ydUW//zU=;
        b=BgYcAX+naf04jrAimLkDd6kd4CcUPqTqb4Mg81qIwBCIedUpbKJab36ZVrEqlXaQz58fERCA7klGjCezHU94c9MprRUuvQ5zQphMMX7UVXFnmX/FkbIJDWWVJE1y5lSf4b4URod5BQ8mWnGQLjmXgvqOA5JIZGuHlF92a3nd+2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pvZ5Fu5IrUnsm57AzbSq1QbO6mqVBcOLjsStnNustKF4LfgFTMYKTZ9F5eWNiB69ATQ5NXzobPkcoe9Vi847dMK75DnOeeKm0r3CBI7hnfM8/YdPThvxf9jloZpCU1YnbKLTnYz5LfrkqJ9OQB5lm4dzsQvzySe2yT+rVZyHOnU=
Received: by 10.141.13.16 with SMTP id q16mr6492521rvi.99.1199124470878;
        Mon, 31 Dec 2007 10:07:50 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Mon, 31 Dec 2007 10:07:50 -0800 (PST)
In-Reply-To: <47792B3E.60509@panasas.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69412>

On Dec 31, 2007 6:47 PM, Boaz Harrosh <bharrosh@panasas.com> wrote:
> On Mon, Dec 31 2007 at 13:58 +0200, "Marco Costalba" <mcostalba@gmail.com> wrote:
> > On Dec 31, 2007 11:59 AM, Filippo Zangheri <filippo.zangheri@yahoo.it> wrote:
> >> Hi,
> >>
> >> I git-cloned qgit-2.1 from your repository, then ran `qmake qgit.pro`, but `make` gave me errors.
> >
> > Yes, you need qmake of Qt4 not the Qt3 one.
> >
> <snip>
>
> A Theoretical question.
> Is it possible to compile Qt4 app all statically linked and run it on a Qt3 based KDE
> machine. Some thing like the windows installation, where every thing is self-contained?
>

It's also very practical...I have _only_ KDE 3 installed, not KDE 4 ;-)

I have both Qt4 and Qt3 development (shared) libraries installed and
there is absolutely no compatibility problem, the only thing you have
to remember is when running

qmake qgit.pro

the first time, you need to be sure is the Qt4 qmake, not the Qt3.
Because I have Qt3 qmake in path, not the Qt4 one, I need to
explicitly give the whole path the first time I configure the sources,
something like

/usr/lib/qt4/bin/qmake qgit.pro

Then no other settings are needed, when you call make, the Makefiles
are already built by qmake to search for the correct libraries.


Hope this helps...

Marco
