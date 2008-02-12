From: Seth Falcon <seth@userprimary.net>
Subject: Re: [PATCH] git-gui: support Git Gui.app under OS X 10.5
Date: Mon, 11 Feb 2008 17:11:00 -0800
Message-ID: <m2d4r30yjf.fsf@userprimary.net>
References: <1202775434-28273-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jaysoffian@gmail.com
X-From: git-owner@vger.kernel.org Tue Feb 12 02:12:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOjgu-0006Zd-Ap
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 02:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbYBLBLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 20:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbYBLBLb
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 20:11:31 -0500
Received: from qmta05.emeryville.ca.mail.comcast.net ([76.96.30.48]:43929 "EHLO
	QMTA05.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752375AbYBLBLa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2008 20:11:30 -0500
Received: from OMTA01.emeryville.ca.mail.comcast.net ([76.96.30.11])
	by QMTA05.emeryville.ca.mail.comcast.net with comcast
	id oHgF1Y0070EPchoA50PT00; Tue, 12 Feb 2008 01:11:05 +0000
Received: from ziti ([64.81.164.13])
	by OMTA01.emeryville.ca.mail.comcast.net with comcast
	id oRB21Y0030Hfbhs8M00000; Tue, 12 Feb 2008 01:11:23 +0000
X-Authority-Analysis: v=1.0 c=1 a=ZcfQPAUpYgYA:10 a=Z4mJgif-AAAA:8
 a=qetXVVh6oFNlGDkbC48A:9 a=Fk_RTnag11wM8o-j4-2kOAx8xjcA:4 a=MSl-tDqOz04A:10
 a=F-J2dRE9H3gA:10 a=ln3u2lK54nYA:10
In-Reply-To: <1202775434-28273-1-git-send-email-jaysoffian@gmail.com> (jaysoffian@gmail.com's message of "Mon\, 11 Feb 2008 19\:17\:14 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.90 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73617>

jaysoffian@gmail.com writes:
> The Tk Framework moved its location in 10.5 compared to 10.4
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> Argh. Third time's a charm? Sorry, forgot to add my change before
> amending and resending.

I applied this and things work much better, thanks!

So...

Tested-by: Seth Falcon <seth@userprimary.net>

One thing.  When I quit git gui I see the following on the terminal:

TkMacOSXDoHLEvent failed : cppe 1                   ,kHighLevelEvent  61657674 0000 tvea,-1708


-- 
Seth Falcon | seth@userprimary.net | blog: http://userprimary.net/user/
