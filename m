From: Steven Drake <sdrake@xnet.co.nz>
Subject: Re: [PATCH] Add `[decorate]' configuration section.
Date: Fri, 26 Feb 2010 13:06:13 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1002261304430.19372@vqena.qenxr.bet.am>
References: <16c38171fc04cee7bdc607bb4c6586925b15278c.1266394059.git.sdrake@xnet.co.nz> <7vr5ojwy38.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.1002261131190.19126@vqena.qenxr.bet.am> <7vk4u0rju2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 01:14:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nknr7-00064e-52
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 01:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934704Ab0BZAOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 19:14:17 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:52790 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934593Ab0BZAOO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 19:14:14 -0500
Received: from idran.drake.org.nz (ip-118-90-92-73.xdsl.xnet.co.nz [118.90.92.73])
	by ananke.wxnz.net (Postfix) with ESMTP id 7B0C2170A3C;
	Fri, 26 Feb 2010 13:14:11 +1300 (NZDT)
In-Reply-To: <7vk4u0rju2.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141082>

On Thu, 25 Feb 2010, Junio C Hamano wrote:

> Steven Drake <sdrake@xnet.co.nz> writes:
> 
> >   On Tue, 16 Feb 2010, Junio C Hamano wrote:
> >   > I was not worried about what your change does.  I am worried about
> >   > protecting what the code after your change currently does from future
> >   > changes done by other people while you are not actively watching the
> >   > patches in flight on this list.
> >
> > But that can easly be with the patch below.
> 
> What does that buy us?  "future changes" can revert your patch to
> builtin-log.c easily.
> 
> I was talking about having tests in the test suite; any "future changes"
> that breaks the output your series has established would not pass if you
> specify what the expected output should be there.  Of course they can
> change the test pattern in their patches, but then we will immediately
> know they are changing the output.

Sorry I didn't get what you meant!  I'll try writing a test.

-- 
Steven
