From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git gui: Quote git path properly when starting another
	gui in a submodule
Date: Thu, 28 Jan 2010 15:45:16 -0800
Message-ID: <20100128234516.GB20488@spearce.org>
References: <878wbln0oa.fsf@users.sourceforge.net> <20100128005142.GK5452@spearce.org> <alpine.DEB.1.00.1001280244430.4985@pacific.mpi-cbg.de> <20100128014205.GA8166@spearce.org> <7v4om7ndm4.fsf@alter.siamese.dyndns.org> <20100128025647.GB8166@spearce.org> <4B61FFA7.4090205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Jan 29 00:45:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nae3L-000898-Cs
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 00:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755265Ab0A1XpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 18:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755096Ab0A1XpY
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 18:45:24 -0500
Received: from mail-iw0-f172.google.com ([209.85.223.172]:40246 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232Ab0A1XpY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 18:45:24 -0500
Received: by iwn2 with SMTP id 2so674611iwn.19
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 15:45:22 -0800 (PST)
Received: by 10.231.153.1 with SMTP id i1mr69668ibw.35.1264722319407;
        Thu, 28 Jan 2010 15:45:19 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 20sm691270iwn.9.2010.01.28.15.45.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Jan 2010 15:45:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B61FFA7.4090205@web.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138286>

Jens Lehmann <Jens.Lehmann@web.de> wrote:
> In do_git_gui() the path of the git executable has to be put into a list,
> otherwise calling it will fail when when spaces are present in its path.
> 
> Reported-by: Heiko Voigt <hvoigt@hvoigt.net>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
> 
> 
> Am 28.01.2010 03:56, schrieb Shawn O. Pearce:
> > Jens Lehmann (2):
> >       git-gui: Use git diff --submodule when available
> >       git-gui: Add a special diff popup menu for submodules
> 
> Today Heiko reported me this bug I introduced with the second patch.
> Sorry for the hassle.

Applied, thanks.
 
-- 
Shawn.
