From: David Kastrup <dak@gnu.org>
Subject: Re: git-gui problem with version number.
Date: Fri, 27 Jul 2007 07:25:13 +0200
Message-ID: <85y7h25sg6.fsf@lola.goethe.zz>
References: <86odhzpg2l.fsf@lola.quinscape.zz>
	<20070727044634.GG20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 07:25:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEIKO-0000QJ-QS
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 07:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207AbXG0FZZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 01:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754986AbXG0FZZ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 01:25:25 -0400
Received: from mail-in-15.arcor-online.net ([151.189.21.55]:44964 "EHLO
	mail-in-15.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754908AbXG0FZY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jul 2007 01:25:24 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-15.arcor-online.net (Postfix) with ESMTP id B7AC24543A;
	Fri, 27 Jul 2007 07:25:23 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id 9FA77212FB7;
	Fri, 27 Jul 2007 07:25:23 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-061-025.pools.arcor-ip.net [84.61.61.25])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 4706C1CB778;
	Fri, 27 Jul 2007 07:25:23 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 3E7801C39595; Fri, 27 Jul 2007 07:25:13 +0200 (CEST)
In-Reply-To: <20070727044634.GG20052@spearce.org> (Shawn O. Pearce's message of "Fri\, 27 Jul 2007 00\:46\:34 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3779/Thu Jul 26 21:33:22 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53890>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> David Kastrup <dak@gnu.org> wrote:
>> Hi, git-gui does not get along with the creativeness in git
>> versioning:
>
> What version of git-gui?  gitgui-0.7.5-67-g91464df and later have
> fixes to handle all of the fun cases in git versioning.  Like the
> one you have here.
>  
>> git-gui
>> Error in startup script: expected version number but got "1.5.3.rc2.4.g726f9-dirty"
>>     while executing
>> "package vcompare $_git_version $vr"

The one coming with the mentioned version number.  I suspect that this
may be a matter of the Perl libraries being used: I experience this on
an Ubuntu Dapper, but not on other (newer) systems compiled from the
same source.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
