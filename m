From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Change set based shallow clone
Date: Tue, 12 Sep 2006 02:06:56 +0200
Organization: At home
Message-ID: <ee4tmo$mhm$1@sea.gmane.org>
References: <17669.8191.778645.311304@cargo.ozlabs.ibm.com> <20060911142644.32313.qmail@science.horizon.com> <7vy7sqic4e.fsf@assigned-by-dhcp.cox.net> <17669.55963.930152.564529@cargo.ozlabs.ibm.com> <7v1wqige41.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Sep 12 02:07:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMvo5-00015p-KL
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 02:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbWILAHJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 20:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965198AbWILAHJ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 20:07:09 -0400
Received: from main.gmane.org ([80.91.229.2]:64477 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965197AbWILAHH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Sep 2006 20:07:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GMvnn-00014I-4S
	for git@vger.kernel.org; Tue, 12 Sep 2006 02:06:59 +0200
Received: from host-81-190-17-209.torun.mm.pl ([81.190.17.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Sep 2006 02:06:59 +0200
Received: from jnareb by host-81-190-17-209.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Sep 2006 02:06:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26871>

Junio C Hamano wrote:

> Paul Mackerras <paulus@samba.org> writes:
> 
>> Junio C Hamano writes:
>>
>>> That's a dubious idea.
>>> 
>>>  - Why assume a tag points directly at a commit, or if it is
>>>    not, why assume "foo^{}" (dereferencing repeatedly until we
>>>    get a non-tag) is special?
>>
>> Umm, I'm not sure what you're getting at here - if one shouldn't make
>> those assumptions, why does git ls-remote output both the tag and
>> tag^{} lines?
> 
> This was originally done to support Cogito's tag following which
> was in its infancy.  So in that sense it is already special (iow
> we know one user that can take advantage of it), but my point
> was that its usefulness for a commit chain fetching application
> (i.e. Cogito) does not automatically mean it is also useful for
> visualizers like gitk and gitweb.

Actually 'git ls-remote .' _is_ useful for gitweb, see the new 
git_get_references code. 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
