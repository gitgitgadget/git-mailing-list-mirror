From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: use correct mime type even if filename has multiple dots.
Date: Sat, 16 Sep 2006 23:44:52 +0200
Organization: At home
Message-ID: <eehr7e$5i0$1@sea.gmane.org>
References: <20060916210933.GX17042@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Sep 16 23:44:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOhxk-0008Lc-KO
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 23:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbWIPVob (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 17:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbWIPVob
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 17:44:31 -0400
Received: from main.gmane.org ([80.91.229.2]:35971 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751828AbWIPVoa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Sep 2006 17:44:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GOhxT-0008I5-He
	for git@vger.kernel.org; Sat, 16 Sep 2006 23:44:19 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Sep 2006 23:44:19 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Sep 2006 23:44:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27137>

Martin Waitz wrote:

> Match the last part of the filename agains the extention from the
> mime database instead of insisting that it starts at the first dot.
[...]
> -     $filename =~ /\.(.*?)$/;
> -     return $mimemap{$1};

Actually, that is non-greedy match, so the above code insist that 
extension starts at the _last_ dot.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
