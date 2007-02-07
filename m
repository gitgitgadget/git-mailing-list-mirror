From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add --patchdepth parameter to git-am.sh
Date: Wed, 07 Feb 2007 10:44:08 +0100
Organization: At home
Message-ID: <eqc6ua$pc$1@sea.gmane.org>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net> <200702051924.39205.andyparkins@gmail.com> <7vfy9ibcdx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 10:43:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEjKY-0008Ko-0U
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 10:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbXBGJnG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 04:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbXBGJnG
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 04:43:06 -0500
Received: from main.gmane.org ([80.91.229.2]:47381 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161072AbXBGJnD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 04:43:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HEjKF-0007To-UR
	for git@vger.kernel.org; Wed, 07 Feb 2007 10:42:51 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 10:42:51 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 10:42:51 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38903>

Junio C Hamano wrote:

> Andy Parkins <andyparkins@gmail.com> writes:
> 
>> If the series of patches you are applying via git-am was based in a
>> different directory there was no way to strip the directory (as you
>> would with git-apply).
>>
>> This patch adds a --patchdepth option to git-am.sh whose argument is
>> passed as a "-p" option to git-apply.
[...]
> 
> I do not understand this remark, as applypatch does not have -p
> either.  If we were to do this, I agree with others that this
> should simply be called -p (we do not have name crash with
> existing options, do we?).

Perhaps options should be -p as short version, and --patchdepth 
(or --strip as in GNU patch) as long version?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
