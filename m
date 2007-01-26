From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] Heavily expanded update hook to send more useful emails than the old hook
Date: Fri, 26 Jan 2007 16:08:59 +0100
Organization: At home
Message-ID: <epd5g5$q3t$1@sea.gmane.org>
References: <29b04c45a795406bd9b278eb44321fe572dc8adf.1169801884.git.andyparkins@gmail.com> <200701260901.04813.andyparkins@gmail.com> <7vejpi17e3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 16:08:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HASgT-0005SV-L6
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 16:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030733AbXAZPIF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 10:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030731AbXAZPIF
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 10:08:05 -0500
Received: from main.gmane.org ([80.91.229.2]:46819 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030735AbXAZPIE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 10:08:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HASgE-00058a-PI
	for git@vger.kernel.org; Fri, 26 Jan 2007 16:07:54 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 16:07:54 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 16:07:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37864>

Junio C Hamano wrote:

> I've been wondering if we would want to have example-hooks/
> directory (not necessarily under contrib/).  Different people
> seem to want different things from the hooks and I'd like to
> avoid "my version is better than yours" arms race to result in
> unnecessary bloat of example hooks that are copied to every
> repository but yet left disabled.

contrib/hooks, or contrib/examples/hooks would be IMVHO also
good place for example hooks. Perhaps on install they should
be copied (at least for rpm/deb install) to
/usr/share/git-core/examples or /usr/share/git-core/examples/hooks

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
