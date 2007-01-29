From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Replace perl code with pure shell code
Date: Mon, 29 Jan 2007 13:43:54 +0100
Organization: At home
Message-ID: <epkq3v$66p$1@sea.gmane.org>
References: <45BDABB5.4070301@fs.ei.tum.de> <86zm82dpql.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 29 13:43:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBVqq-0001Vf-Td
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 13:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbXA2Mmv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 07:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbXA2Mmv
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 07:42:51 -0500
Received: from main.gmane.org ([80.91.229.2]:52010 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305AbXA2Mmu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 07:42:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HBVqQ-0007ap-Pc
	for git@vger.kernel.org; Mon, 29 Jan 2007 13:42:46 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 13:42:46 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 13:42:46 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38076>

Randal L. Schwartz wrote:

>>>>>> "Simon" == Simon 'corecode' Schubert <corecode@fs.ei.tum.de> writes:
> 
> Simon> +                      destname="refs/$branch_top/${name#refs/heads/}" ;;
> 
> I don't think this is portable shell.  At least Perl is the same everywhere.
> Ignore me if this is a shell syntax on something other than bash.

I think ${var#pattern} is a POSIX shell syntax.

Nevertheless Perl embedded in shell script is (a bit) horrible.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
