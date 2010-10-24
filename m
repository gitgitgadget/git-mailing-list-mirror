From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [BUG, PATCH v5 0/3] Fix {blame,cat-file} --textconv for cases with symlinks
Date: Sun, 24 Oct 2010 21:40:08 +0400
Message-ID: <20101024174008.GA28961@landau.phys.spbu.ru>
References: <cover.1285758714.git.kirr@mns.spb.ru> <20101022200516.GA13926@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@mns.spb.ru>,
	Junio C Hamano <gitster@pobox.com>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Cl??ment Poulain <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 24 19:40:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PA4YP-00028m-B6
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 19:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684Ab0JXRkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 13:40:13 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:54981 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203Ab0JXRkM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 13:40:12 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id 2842C7F1A; Sun, 24 Oct 2010 21:40:08 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <20101022200516.GA13926@sigill.intra.peff.net>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159887>

On Fri, Oct 22, 2010 at 04:05:16PM -0400, Jeff King wrote:
> On Wed, Sep 29, 2010 at 03:35:21PM +0400, Kirill Smelkov wrote:
> 
> > Kirill Smelkov (3):
> >   tests: Prepare --textconv tests for correctly-failing conversion
> >     program
> >   blame,cat-file: Demonstrate --textconv is wrongly running converter
> >     on symlinks
> >   blame,cat-file --textconv: Don't assume mode is ``S_IFREF | 0664''
> 
> I finally got around to reviewing this series again (thanks for your
> patience, Kirill). This latest version (v5) looks good to me.

Thanks, Jeff. And thanks for your and everyone's patience with me too.

Kirill
