From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [patch 12/16] host-OSF1.patch
Date: Wed, 28 Apr 2010 09:07:37 +0000
Message-ID: <20100428090736.GE36271@thor.il.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
 <20100427135904.486582000@mlists.thewrittenword.com>
 <l2jd2d39d861004270710w8e5416d5iad3fa7497e620733@mail.gmail.com>
 <20100427143912.GB36271@thor.il.thewrittenword.com>
 <p2rd2d39d861004270748q57802106gdd394cba68ce5ae7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Wed Apr 28 11:07:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O73F9-0000R5-J8
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 11:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008Ab0D1JHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 05:07:38 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:52898 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab0D1JHh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 05:07:37 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id E3A5B5C48;
	Wed, 28 Apr 2010 09:28:46 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com E3A5B5C48
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 22CF2AFC;
	Wed, 28 Apr 2010 09:07:37 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id 0B115BAB4; Wed, 28 Apr 2010 09:07:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <p2rd2d39d861004270748q57802106gdd394cba68ce5ae7@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145979>

On Tue, Apr 27, 2010 at 04:48:53PM +0200, Tor Arntsen wrote:
> On Tue, Apr 27, 2010 at 16:39, Gary V. Vaughan
> <git@mlists.thewrittenword.com> wrote:
> > On Tue, Apr 27, 2010 at 04:10:56PM +0200, Tor Arntsen wrote:
> 
> >> but (ref. a patch I sent earlier, in its
> >> first revision) I needed several other changes in order to compile on
> >> 5.1 (I also needed those you have above), e.g.
> >> -D_POSIX_C_SOURCE=1 NO_STRCASESTR = YesPlease NO_STRTOUMAX = YesPlease
> >> NO_STRLCPY = YesPlease NO_MEMMEM = YesPlease NO_UINTMAX_T = YesPlease
> >> NO_C99_FORMAT = YesPlease
> >> and
> >> NO_TCLTK = YesPlease
> >
> > Indeed, I don't mean to imply that this patch is all that is needed
> > for OSF1, merely that the changes it contains benefit only OSF1.
> 
> I see. In that case, as I have verified that those changes are indeed
> necessary for OSF1:
> 
> Acked-by: Tor Arntsen <tor@spacetec.no>

Wow, all these different pseudo-headers are starting to make my head
spin! ;)

> > Please bear in mind that I build using configure, and may have missed
> > something necessary for a make-only driven build.
> 
> Ah, Ok, that would explain it. I too found that with ./configure fewer
> changes were needed. The patch I was working on I tested both with and
> without configure.  If your patch goes in I could follow up with the
> changes needed for when not using configure, if you don't wish to
> tacke that.

Much appreciated, thank you.

Unless it's a requirement for having these patches accepted upstream,
then I'd rather not worry about the make only builds... I've mentioned
elsewhere that the idea of reliable builds predicated on the idea that
it is possible to maintain a static database of what options are
required on each combination of libc/cc/os/patchlevel with any kind of
reliability seems fundamentally flawed to me.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
