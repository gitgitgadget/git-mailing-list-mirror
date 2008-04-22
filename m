From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Don't force imap.host to be set when imap.tunnel is set
Date: Tue, 22 Apr 2008 16:07:12 +0100
Message-ID: <fukuv0$aba$1@ger.gmane.org>
References: <200804211459.07527.andyparkins@gmail.com> <7vbq424c8f.fsf@gitster.siamese.dyndns.org> <fuka50$pce$1@ger.gmane.org> <20080422104146.GA11198@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 17:11:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoK6M-0002Re-IT
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 17:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbYDVPHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 11:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbYDVPHW
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 11:07:22 -0400
Received: from main.gmane.org ([80.91.229.2]:37120 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbYDVPHW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 11:07:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JoK5Y-0004Gg-CL
	for git@vger.kernel.org; Tue, 22 Apr 2008 15:07:20 +0000
Received: from 194.70.53.227 ([194.70.53.227])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 15:07:20 +0000
Received: from andyparkins by 194.70.53.227 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 15:07:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 194.70.53.227
User-Agent: KNode/0.10.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80129>

Jeff King wrote:

> I think Junio's point is that it's easy to start dereferencing NULL,
> because later parts of the code assume that "host" is always set, even
> if only to use it for informational purposes. So those callsites either
> need to be fixed to handle a NULL host, or perhaps something like this
> instead (totally untested):

Agreed.  Yours is a much better solution.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
