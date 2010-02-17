From: Steven Drake <sdrake@xnet.co.nz>
Subject: Re: [PATCH] Add `log.decorate' configuration variable.
Date: Wed, 17 Feb 2010 19:55:12 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1002171950040.8560@vqena.qenxr.bet.am>
References: <alpine.LNX.2.00.1002171239430.2477@vqena.qenxr.bet.am> <7vljespt2l.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.1002171427080.3414@vqena.qenxr.bet.am> <7v635wimac.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 08:33:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhePU-0007Mg-0c
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 08:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933796Ab0BQHdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 02:33:17 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:45181 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933934Ab0BQHdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 02:33:16 -0500
Received: from idran.drake.org.nz (ip-118-90-92-203.xdsl.xnet.co.nz [118.90.92.203])
	by ananke.wxnz.net (Postfix) with ESMTP id 1A1EB17195D;
	Wed, 17 Feb 2010 20:03:00 +1300 (NZDT)
In-Reply-To: <7v635wimac.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140211>

On Tue, 16 Feb 2010, Junio C Hamano wrote:

> I was not worried about what your change does.  I am worried about
> protecting what the code after your change currently does from future
> changes done by other people while you are not actively watching the
> patches in flight on this list.
Ok, I'll send a new patch that should be a lot better shorty.

Have you commited the git_config_maybe_bool() code?

> We generally avoid doing this, as we may later want to add different
> values to "log.decorate", and keep the older git working as if nothing is
> specified, rather than barfing, so that people can access the same
> repository, perhaps over NFS, from different machines with varying vintage
> of git.
Good point.
 
By the way is it alright to send patches that use inbody-headers and/or 
scissors?
-- 
Steven
