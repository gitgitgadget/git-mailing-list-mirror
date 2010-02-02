From: Ron Garret <ron1@flownet.com>
Subject: Re: What does git reset do?
Date: Tue, 02 Feb 2010 00:24:26 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-2B8474.00242602022010@news.gmane.org>
References: <ron1-A2A2DE.23475601022010@news.gmane.org> <op.u7hpv8nd4oyyg1@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 09:25:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcE4Q-0004LB-PH
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 09:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365Ab0BBIZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 03:25:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:55021 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752774Ab0BBIZI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 03:25:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NcE4I-0004Gc-UL
	for git@vger.kernel.org; Tue, 02 Feb 2010 09:25:06 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 09:25:06 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 09:25:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138700>

In article <op.u7hpv8nd4oyyg1@localhost.localdomain>,
 "Octavio Alvarez" <alvarezp@alvarezp.ods.org> wrote:

> > So... what does git reset do?
> 
> Sets the current head (and branch, if not detached) to the specified  
> commit...

Ah.  It's the "and branch" part that I was missing.  Thanks!

Hm... maybe "detached head" is not as inappropriate a term as I first 
thought.  When you checkout a branch, HEAD really is "attached" to the 
branch insofar as the branch head gets "dragged along" on commits and 
resets.  (Have I got that right?)

rg
