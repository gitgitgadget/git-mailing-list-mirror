From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Tue, 08 Aug 2006 02:10:33 +0200
Organization: At home
Message-ID: <eb8kph$j6i$1@sea.gmane.org>
References: <200608071626.52655.jnareb@gmail.com> <7v3bc82v7l.fsf@assigned-by-dhcp.cox.net> <eb8cdh$s6n$1@sea.gmane.org> <7v4pwo1a0r.fsf@assigned-by-dhcp.cox.net> <eb8e12$2aa$1@sea.gmane.org> <7vejvsyum8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 08 02:10:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAFBA-0004zF-W1
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 02:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWHHAKh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 20:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWHHAKh
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 20:10:37 -0400
Received: from main.gmane.org ([80.91.229.2]:17132 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932393AbWHHAKg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 20:10:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GAFB2-0004yi-LT
	for git@vger.kernel.org; Tue, 08 Aug 2006 02:10:33 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 02:10:32 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 02:10:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25056>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:

>> So the new guidelines would be:
>> * git_get_ prefix for subroutines related to git repository
>>   and returning single scalar (single value).
>> * git_read_ prefix for subroutines related to git repository, reading some
>>   files or multiline output, and returning hash reference, or list
>>   reference, or list.
> 
> I would suggest to use git_get for both, unless there is a good
> reason to differenciate them, since I do not understand why you
> would want to differenciate one value vs multivalue.

I'd rather have git_read_info_refs, because it _reads_ info/refs file, 
and git_read_refs as opposed to git_get_hash/git_get_ref/git_ref_to_hash
(or hash_from_ref). I'm not sure about git_read_projects vs. perhaps
git_get_project_list or git_list_projects. Neither about 
git_read_description vs. git_get_project_description

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
