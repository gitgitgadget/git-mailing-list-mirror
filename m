From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitweb indentation wrong in Internet Explorer
Date: Wed, 11 Oct 2006 19:47:24 +0200
Organization: At home
Message-ID: <egjang$nmh$1@sea.gmane.org>
References: <20061011172553.GA1147@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Oct 11 19:48:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXiC8-000816-4y
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 19:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161166AbWJKRsh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 13:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161167AbWJKRsh
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 13:48:37 -0400
Received: from main.gmane.org ([80.91.229.2]:35237 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161166AbWJKRsg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 13:48:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GXiBh-0007uG-5s
	for git@vger.kernel.org; Wed, 11 Oct 2006 19:48:13 +0200
Received: from host-81-190-20-194.torun.mm.pl ([81.190.20.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 19:48:13 +0200
Received: from jnareb by host-81-190-20-194.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 19:48:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-194.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28730>

Ralf Baechle wrote:

> I have a report from an MSIE suffering user:
> 
>> When I use it (and I believe I've seen this on my laptop as well as my
>> workstation) all left-hand margin whitespace is collapsed to nothingness.
>> Once can still parse the code, but it's harder with no indentations.
> 
> A screenshot from a Windows laptop to illustrate the problem is at
> http://www.linux-mips.org/~ralf/gitweb.png.  It shows the code was
> preformatted correctly which seems to be an IE bug but the following patch
> seems to work around it.

Which version of gitweb? We have removed s/ /&nbsp;/g; in esc_html
subroutine in favor of using "white-space: pre;" in CSS some time ago,
and we have added escaping FORM FEED and ESCAPE characters.

Could you send git patches, by the way? Or at least '-p' diffs?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
