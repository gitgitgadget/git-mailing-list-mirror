From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH 08/12] MINGW: fix main() signature in http-fetch.c and
 remote-curl.c
Date: Sat, 3 May 2014 11:43:41 +0400
Message-ID: <20140503074341.GA8960@seldon>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
 <1398762726-22825-9-git-send-email-marat@slonopotamus.org>
 <5360B5EC.1070907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 09:43:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgUbx-0005dD-Q1
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 09:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbaECHnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 03:43:46 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:34920 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbaECHnp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 03:43:45 -0400
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WgUbl-0002L9-F9; Sat, 03 May 2014 11:43:41 +0400
Content-Disposition: inline
In-Reply-To: <5360B5EC.1070907@gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248024>

On Wed, Apr 30, 2014 at 10:35:56AM +0200, Karsten Blees wrote:
> Am 29.04.2014 11:12, schrieb Marat Radchenko:
> > On MinGW, compat/mingw.h defines a 'mingw_main' wrapper function.
> > Fix `warning: passing argument 2 of 'mingw_main' from incompatible
> > pointer type` in http-fetch.c and remote-curl.c by dropping 'const'.
> > 
> 
> Would you mind cross checking your changes with the msysgit fork?
> Fixing the same thing in a slightly different manner will just cause
> unnecessary conflicts (i.e. unnecessary work for the Git for Windows
> maintainers, as well as for you to come up with an alternate solution
> for something that's long been fixed).
>
> See https://github.com/msysgit/git/commit/9206e7fd (squashed from
> https://github.com/msysgit/git/commit/0115ef83 and
> https://github.com/msysgit/git/commit/6949537a). 

6949537a is just an unnecessary hack and would have to be rewritten
no matter who would try to submit it upstream.
