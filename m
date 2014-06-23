From: Stephen Kelly <steveire@gmail.com>
Subject: Re: gitk with submodules does not show new commits on other branches
Date: Mon, 23 Jun 2014 19:35:26 +0200
Message-ID: <lo9ogu$4in$1@ger.gmane.org>
References: <lo6o2h$vva$1@ger.gmane.org> <53A6F978.4010005@web.de> <lo9mg1$bma$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 19:36:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz89t-00083M-Rq
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 19:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756617AbaFWRfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 13:35:54 -0400
Received: from plane.gmane.org ([80.91.229.3]:53590 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756586AbaFWRfx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 13:35:53 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Wz89e-0007u6-KD
	for git@vger.kernel.org; Mon, 23 Jun 2014 19:35:42 +0200
Received: from 188.111.54.34 ([188.111.54.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 19:35:42 +0200
Received: from steveire by 188.111.54.34 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 19:35:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 188.111.54.34
User-Agent: KNode/4.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252359>

Stephen Kelly wrote:

> Failing all of that, can you show me where the code would need to be
> changed to list all of the newly-reachable commits? I can keep a commit
> for myself then.

I see that gitk is showing the output of git diff --submodule, similar to 
git submodule summary.

Assuming that is not going to be changed, maybe I can hack parseblobdiffline 
locally. I have not really tried to read of write tcl code before though, so 
I'd still prefer a 'proper' solution somehow.

Thanks,

Steve.
