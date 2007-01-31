From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Make gitk work reasonably well on Cygwin.
Date: Wed, 31 Jan 2007 17:28:44 +0100
Organization: eudaptics software gmbh
Message-ID: <45C0C3BC.BD01337E@eudaptics.com>
References: <BAY13-F213DF79906B3889D42369D0A50@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 17:31:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCIJN-0003aW-Qb
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 17:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbXAaQ1w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 11:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbXAaQ1w
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 11:27:52 -0500
Received: from main.gmane.org ([80.91.229.2]:48693 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030238AbXAaQ1v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 11:27:51 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCIJ6-0000JO-OJ
	for git@vger.kernel.org; Wed, 31 Jan 2007 17:27:37 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 17:27:36 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 17:27:36 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38271>

Mike Nefari wrote:
> 
> The gitk gui layout was completely broken on Cygwin. If gitk was started
> without previous geometry in ~/.gitk, the user could drag the window sashes
> to get a useable layout. However, if ~/.gitk existed, this was not possible
> at all.
> 
> The fix was to rewrite makewindow, changing the toplevel containers and
> the particular geometry information saved between sessions. Numerous bugs
> in both the Cygwin and the Linux Tk versions make this a delicate
> balancing act: the version here works in both but many subtle variants
> are competely broken in one or the other environment.

Your mailer has garbled your patch. But once this is fixed, it works
quite well, both on my Linux box with Tk 8.4, where gitk's layout was
suboptimal, as well as under MinGW, also with Tk 8.4.

Thank you, you saved my day!

-- Hannes
