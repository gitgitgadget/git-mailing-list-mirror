From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git files data formats documentation
Date: Sun, 06 Aug 2006 01:43:19 +0200
Organization: At home
Message-ID: <eb3ad8$fq6$1@sea.gmane.org>
References: <44D42F0D.3040707@gmail.com> <eb2onf$7up$1@sea.gmane.org> <44D4FC52.6030807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Aug 06 01:43:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9VnC-0007YJ-DM
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 01:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbWHEXmv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 19:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbWHEXmv
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 19:42:51 -0400
Received: from main.gmane.org ([80.91.229.2]:36540 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932664AbWHEXmu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 19:42:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G9Vn1-0007XB-38
	for git@vger.kernel.org; Sun, 06 Aug 2006 01:42:43 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Aug 2006 01:42:43 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Aug 2006 01:42:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24940>

A Large Angry SCM wrote:

> Jakub Narebski wrote:

>> I do wonder why there is <OCTAL_MODE> (and not <BINARY_OCTAL_MODE>) 
>> but <BINARY_OBJ_ID> (and not <HEX_OBJ_ID>).
>> 
> 
> <OCTAL_MODE> because it's an ASCII string. <BINARY_OBJ_ID> because it's 
> the 20 byte digest.

I meant why git use ASCII string for octal mode, while using 20 byte digest
for object-id in tree format. More consistent would be use binary and
binary, or ASCII and ASCII (i.e. <HEX_OBJ_ID>).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
