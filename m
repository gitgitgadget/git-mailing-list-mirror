From: Petr Baudis <pasky@suse.cz>
Subject: Re: linking libgit.a in C++ projects
Date: Thu, 31 Jul 2008 13:20:37 +0200
Message-ID: <20080731112037.GP32184@machine.or.cz>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com> <20080731105727.GF7008@dpotapov.dyndns.org> <ac9f0f090807310410u461f5584ved74769d8452c539@mail.gmail.com> <0EC13CCC-0F7B-41A0-BEB2-67E6EC8D5E37@simplicidade.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cte <cestreich@gmail.com>, Dmitry Potapov <dpotapov@gmail.com>,
	git@vger.kernel.org
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 13:21:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOWE0-00069I-Ak
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 13:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbYGaLUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 07:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbYGaLUj
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 07:20:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39036 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022AbYGaLUj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 07:20:39 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 1E3F0393A530; Thu, 31 Jul 2008 13:20:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <0EC13CCC-0F7B-41A0-BEB2-67E6EC8D5E37@simplicidade.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90931>

On Thu, Jul 31, 2008 at 12:16:45PM +0100, Pedro Melo wrote:
> I think the point Dmitry was trying to make is that you should compile 
> libgit as C, using gcc, and then link it with your C++/Objective C code.
>
> No patch is required to git, only to your makefile/xcode project file.

libgit has a certain (albeit currently unofficial and non-settled) API
and the API is defined in header files that must be eatable by C++
compilers in order to do this.

				Petr "Pasky" Baudis
