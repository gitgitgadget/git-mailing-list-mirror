From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to resolve git-am conflict (possible bug)
Date: Sat, 12 Aug 2006 11:18:07 +0200
Organization: At home
Message-ID: <ebk6be$31k$2@sea.gmane.org>
References: <ebj7er$64j$1@sea.gmane.org> <7vslk2rbq8.fsf@assigned-by-dhcp.cox.net> <ebk5tf$31k$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Aug 12 11:17:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBpcq-0007mt-9t
	for gcvg-git@gmane.org; Sat, 12 Aug 2006 11:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWHLJRp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Aug 2006 05:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWHLJRp
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Aug 2006 05:17:45 -0400
Received: from main.gmane.org ([80.91.229.2]:55762 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751385AbWHLJRo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Aug 2006 05:17:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GBpcl-0007le-LE
	for git@vger.kernel.org; Sat, 12 Aug 2006 11:17:43 +0200
Received: from host-81-190-24-83.torun.mm.pl ([81.190.24.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Aug 2006 11:17:43 +0200
Received: from jnareb by host-81-190-24-83.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Aug 2006 11:17:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-83.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25257>

Jakub Narebski wrote:

> Junio C Hamano wrote:
[...] 
>> More likely explanation is that you edited the patch by hand for
>> some reason, and made it inapplicable to the base blob the
>> "index" line records.

Original (not edited) version of patch generates nice merge conflict.

> It would be nice then if git-am was more verbose, for example
> "Applying patch to blob 7ea52b1... gitweb/gitweb.perl" or something
> like that.

Or at least some information what git-am is attempting before second 
'patch failed' error message...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
