From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC] Clean way to disable pager
Date: Sun, 19 Aug 2007 23:28:27 +0200
Message-ID: <20070819212827.GA5442@steel.home>
References: <vpq1wdz307k.fsf@bauges.imag.fr>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 19 23:29:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMsKT-00067h-8R
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 23:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbXHSV2b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 17:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753265AbXHSV2b
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 17:28:31 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:26861 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455AbXHSV2a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 17:28:30 -0400
Received: from tigra.home (Fa819.f.strato-dslnet.de [195.4.168.25])
	by post.webmailer.de (fruni mo42) (RZmta 10.3)
	with ESMTP id J01bafj7JJVDtM for <git@vger.kernel.org>;
	Sun, 19 Aug 2007 23:28:28 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2F2A2277BD
	for <git@vger.kernel.org>; Sun, 19 Aug 2007 23:28:28 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 7853ABDFB; Sun, 19 Aug 2007 23:28:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <vpq1wdz307k.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTc4XQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56152>

Matthieu Moy, Sun, Aug 19, 2007 19:26:07 +0200:
> I think that deserves an less-hacky, and documented way. I'd suggest a
> --no-pager, or --dont-paginate, that would do the opposite of -p as a
> global option for git.

Ack.

Besides, some platforms having no way to unset an environment
variable, a really cumbersome to work with them (Cygwin/Win32, yes),
so this switch is actually the only way to achive something stable.
