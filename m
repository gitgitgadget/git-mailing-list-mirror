From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: CMake, was Re: [PATCH 09/11] Add MSVC porting header files.
Date: Mon, 17 Aug 2009 23:29:59 +0200
Message-ID: <3af572ac0908171429k62db72c1jd43ae814be569e4a@mail.gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-2-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-3-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-4-git-send-email-lznuaa@gmail.com>
	 <alpine.DEB.1.00.0908171902300.4991@intel-tinevez-2-302>
	 <3af572ac0908171231n30864c85ud67454a03ca08fbe@mail.gmail.com>
	 <alpine.DEB.1.00.0908172147240.8306@pacific.mpi-cbg.de>
	 <3af572ac0908171251y355a1e2bjf2d10192bc3eca2e@mail.gmail.com>
	 <3f4fd2640908171420j2a359e99ga3d6fc3109547af6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 23:30:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md9mM-0004mq-BS
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 23:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758103AbZHQV37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 17:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758084AbZHQV37
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 17:29:59 -0400
Received: from mail-fx0-f215.google.com ([209.85.220.215]:38207 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655AbZHQV37 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 17:29:59 -0400
Received: by fxm11 with SMTP id 11so19016fxm.39
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 14:30:00 -0700 (PDT)
Received: by 10.223.145.7 with SMTP id b7mr970778fav.29.1250544599928; Mon, 17 
	Aug 2009 14:29:59 -0700 (PDT)
In-Reply-To: <3f4fd2640908171420j2a359e99ga3d6fc3109547af6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126290>

On Mon, Aug 17, 2009 at 11:20 PM, Reece Dunn<msclrhd@googlemail.com> wrote:

> Realistically, you'd need CMake for Windows/msvc and autotools for
> POSIX systems. I know that CMake is supported on POSIX, but not
> everyone has access to it. Poppler, for example, has this dual build
> system to support Windows as well as other systems (that, and it has
> KDE4 bindings, so CMake is pretty much a given).

It's not exactly like that. It would be more accurate to say "if you
have POSIX, CMake will work; if you don't have POSIX, it may or may
not work".

I'd say 99% of git users run git on a platform which supports enough
POSIX to build CMake.

Please note if you are cross-compiling git, you need CMake (hence
POSIX) on the platform you are cross-compiling on (the "host
platform"), not on the platform you are cross-compiling for (the
"target platform").

> For CMake to work, it would need to support building all of git
> (including the man, html and pdf documents from the asciidoc sources),
> the localisation support and the optional packages (OpenSSL, CURL). I
> know that KDE uses CMake, so this should all be possible.

All possible. Plus using CMake would make easier to build installers
(NSIS, WiX, .deb, .rpm, etc), submit the results of the tests to a
dashboard ( http://my.cdash.org/ ), and more.

-- 
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
