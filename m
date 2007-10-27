From: Sergei Organov <osv@javad.com>
Subject: Re: Minor inconsistency: "git tag" requires space after -m.
Date: Sat, 27 Oct 2007 17:14:03 +0400
Message-ID: <ffvdir$g2n$1@ger.gmane.org>
References: <ffv8ul$5a2$1@ger.gmane.org> <Pine.LNX.4.64.0710271347510.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 15:14:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IllUn-0002MQ-QO
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 15:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183AbXJ0NOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 09:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbXJ0NOV
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 09:14:21 -0400
Received: from main.gmane.org ([80.91.229.2]:50050 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957AbXJ0NOU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 09:14:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IllUV-0004Fy-63
	for git@vger.kernel.org; Sat, 27 Oct 2007 13:14:15 +0000
Received: from 87.236.81.130 ([87.236.81.130])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Oct 2007 13:14:15 +0000
Received: from osv by 87.236.81.130 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Oct 2007 13:14:15 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87.236.81.130
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62490>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Hi,
>
> On Sat, 27 Oct 2007, Sergei Organov wrote:
>
>> It seems options parsing is somewhat broken in git-tag:
>> 
>> $ git tag -a -m"Annotated tag" annotated-tag
>> usage: git-tag [-n [<num>]] -l [<pattern>] | [-a | -s | -u <key-id>] [-f | -d | -v] [-m <msg> | -F <file>] <tagname> [<head>]
>> $ git tag -a -m "Annotated tag" annotated-tag
>> $ git --version
>> git version 1.5.3.4
>> 
>> This is inconsistent with, say, "git commit", that groks -m"Message"
>> (without space after -m) just fine.
>
> As it happens, we are in the middle of adding our own option parser which 
> probably solves the issue.  Can you please retest when we have that, and 
> use it in builtin-tag?

I'm 100% sure there will be no inconsistencies once you unify options
parsing among the tools, but I won't refrain from re-testing this
anyway.

-- 
Sergei.
