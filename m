From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: Propagating config to clones/pulls
Date: Tue, 7 Sep 2010 16:36:23 -0500
Message-ID: <i66bas$q4t$1@dough.gmane.org>
References: <A8F08AD5-6DB5-4A4D-9A8F-79DDBD93E666@getgosu.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 23:37:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot5rP-0000oN-OE
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 23:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840Ab0IGVhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 17:37:43 -0400
Received: from lo.gmane.org ([80.91.229.12]:38358 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754564Ab0IGVhm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 17:37:42 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ot5rJ-0000jv-Bh
	for git@vger.kernel.org; Tue, 07 Sep 2010 23:37:41 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 23:37:41 +0200
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 23:37:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155745>

"Douglas Tan" <douglas@getgosu.com> wrote in message 
news:A8F08AD5-6DB5-4A4D-9A8F-79DDBD93E666@getgosu.com...
>I have some config settings that I'll like to make default for anyone 
>cloning/pulling from the central remote bare repository. I've tried to do 
>this by editing the config file in the bare repository on the server but 
>the change doesn't appear when cloning. How can I go about pushing default 
>config settings to anyone cloing or pulling from the repository?--

Based on the assumption that your "child" repos are supposed to have the 
same .git/config files, I tried using git-init --template=x with a config 
file in template directory "x", but git-init only picks up the config file 
on an initialization of a new repo, not on a reinitialization of an existing 
repo.

v/r,
Neal 
