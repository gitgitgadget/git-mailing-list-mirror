From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git-svn: use SVN::Ra::get_dir2 when possible
Date: Fri, 31 Oct 2014 23:22:22 +0000
Message-ID: <20141031232222.GA30046@dcvr.yhbt.net>
References: <1414792434.54806.YahooMailBasic@web172304.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Nov 01 00:22:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkLWV-0007cB-68
	for gcvg-git-2@plane.gmane.org; Sat, 01 Nov 2014 00:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759390AbaJaXWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2014 19:22:23 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49568 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752564AbaJaXWX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2014 19:22:23 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7CBF1F838;
	Fri, 31 Oct 2014 23:22:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1414792434.54806.YahooMailBasic@web172304.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> Tested-by: Hin-Tak Leung <htl10@users.sourceforge.net>
> 
> Okay, this one on top of my "git 2.1.0 + 10 recent git svn improvement patches"
> allow me to fetch further.
> 
> I suspect the problem must be elsewhere though, and this just band-aided
> over it.
> 
> For me, reverting the additional patches and just use git 2.1.0 also allow
> me to fetch further, so the problem appear to me to be associated with
> the additional patches.

Junio already pulled all of those git-svn patches into git 2.2.0-rc0:

http://mid.gmane.org/xmqq7fzgt0q4.fsf@gitster.dls.corp.google.com

Can you give that a try?  I've been able to complete the vbox
fetch without problems.

> But you are saying that git-svn on debian as shipped
> exhibit this problem? 

No, I'm saying unrelated, (old) functionality such as
"git svn show-ignore" also got broken by this SVN bug.
