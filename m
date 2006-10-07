From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] move --show-cdup, --show-prefix, and --show-git-dir out of git-rev-parse.
Date: Sat, 07 Oct 2006 23:14:34 +0200
Organization: At home
Message-ID: <eg95a6$2v7$1@sea.gmane.org>
References: <20061007210429.GA2871@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Oct 07 23:14:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWJUp-00058o-3p
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 23:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932865AbWJGVOI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 17:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932866AbWJGVOI
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 17:14:08 -0400
Received: from main.gmane.org ([80.91.229.2]:61844 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932865AbWJGVOF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 17:14:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GWJUY-00055e-4U
	for git@vger.kernel.org; Sat, 07 Oct 2006 23:13:54 +0200
Received: from host-81-190-22-223.torun.mm.pl ([81.190.22.223])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 23:13:54 +0200
Received: from jnareb by host-81-190-22-223.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 23:13:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-22-223.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28507>

Martin Waitz wrote:

> They don't really have anything to do with refs.

But is it a good idea to add yet another command? We have too many of them
already...

I'd rather add one command, git-admin/git-config, or just move the options
to the "git" command. So we would have "git --show-git-dir" in addition to
"git --git-dir=<directory>".
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
