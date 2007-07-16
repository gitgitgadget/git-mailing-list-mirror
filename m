From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: Tips for debugging fast-import front-ends
Date: Mon, 16 Jul 2007 15:32:31 +0200
Organization: eudaptics software gmbh
Message-ID: <469B736F.12FA24EA@eudaptics.com>
References: <Pine.LNX.4.64.0707161336570.24955@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 15:31:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAQg8-0001Sf-AF
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 15:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760212AbXGPNbw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 09:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759839AbXGPNbw
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 09:31:52 -0400
Received: from main.gmane.org ([80.91.229.2]:55879 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759272AbXGPNbv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 09:31:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IAQfu-00025q-Lu
	for git@vger.kernel.org; Mon, 16 Jul 2007 15:31:42 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 15:31:42 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 15:31:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52675>

Julian Phillips wrote:
> At some point in the "messy" phase I get an error from fast-import saying:
> 
> fatal: path foo not in branch
> 
> This seems to happen when I attempt to copy a file that is also changed in
> the same commit.  What I would like to do is find out what things look
> like just before that point - the problem is that fast-import seems to not
> create anything on failure.  So, apart restarting the import and stopping
> just before the broken commit, is there any way to find out what
> fast-import thinks the branch looks like?

Redirect the input stream to a file instead of to fast-import, then feed
fast-import from this file. This way you can reproduce the failure more
quickly. Also, you can run fast-import from a debugger.

-- Hannes
