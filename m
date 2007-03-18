From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git push to a non-bare repository
Date: Sun, 18 Mar 2007 23:01:28 +0100
Organization: At home
Message-ID: <etkcrn$e9a$1@sea.gmane.org>
References: <vpq648ye9w6.fsf@olympe.imag.fr> <7vr6rml4fb.fsf@assigned-by-dhcp.cox.net> <45FDB447.5070507@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 23:02:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT3S4-0002ms-Vn
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 23:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933333AbXCRWCA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 18:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933331AbXCRWB7
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 18:01:59 -0400
Received: from main.gmane.org ([80.91.229.2]:49343 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933333AbXCRWB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 18:01:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HT3Rh-0003ZP-Pp
	for git@vger.kernel.org; Sun, 18 Mar 2007 23:01:45 +0100
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Mar 2007 23:01:45 +0100
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Mar 2007 23:01:45 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42530>

Sam Vilain wrote:

> Junio C Hamano wrote:

>>> I don't understand the design choice here: git had two options to
>>> avoid this scenario:
>>
>> Actually, there are no such "design choices".  That's entirely
>> up to the repository owners to arrange post-update hook, to
>> allow you to do anything you want.  
>>
>> The default is not to encourage people (who do not know what
>> they are doing anyway) to push into non-bare repository.
>>   
> 
> Maybe it's worth making it an error (that can be forced) if you're
> pushing to the head that's checked out in a non-bare repository ?
> 
> It's pretty nasty behaviour for people used to darcs / bzr et al.

Perhaps it would be for the best.

BUT unless you arrange some fancy post-update hook you have two
sane choices:
 * push to bare repository, with 1:1 refs mapping
 * push to non-bare repository, but with mapping pushed refs on
   pushee to remotes refs (remote / tracking branches) on remote
   side.

In all other choices there madness lies... ;-)

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
