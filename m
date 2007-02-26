From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-remote and remotes with '.' in their names
Date: Mon, 26 Feb 2007 12:28:27 +0100
Organization: At home
Message-ID: <erug4s$kn7$1@sea.gmane.org>
References: <87k5y5tlol.fsf@briny.internal.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 26 12:27:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLe15-0003x3-Nx
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 12:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965240AbXBZL1R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 06:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965241AbXBZL1R
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 06:27:17 -0500
Received: from main.gmane.org ([80.91.229.2]:56692 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965240AbXBZL1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 06:27:16 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HLe0F-0002ZF-US
	for git@vger.kernel.org; Mon, 26 Feb 2007 12:26:48 +0100
Received: from host-89-229-2-22.torun.mm.pl ([89.229.2.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Feb 2007 12:26:47 +0100
Received: from jnareb by host-89-229-2-22.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Feb 2007 12:26:47 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-2-22.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40617>

Paul Collins wrote:

> With this patch I get the correct list, but then it will break if
> there are ever config keys like "remote.$remote_name.foo.bar".

I don't think there would ever be key (variable) names with dots in them;
if I remember correctly we don't allow this now.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
