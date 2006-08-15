From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/9] gitweb: Separate ref parsing in git_get_refs_list into parse_ref
Date: Tue, 15 Aug 2006 18:18:43 +0200
Organization: At home
Message-ID: <ebss3h$tgq$2@sea.gmane.org>
References: <200608140202.46160.jnareb@gmail.com> <200608140207.01108.jnareb@gmail.com> <7vu04ec04b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 15 18:21:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD1eU-0004An-V9
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 18:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbWHOQUY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 12:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbWHOQUY
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 12:20:24 -0400
Received: from main.gmane.org ([80.91.229.2]:12484 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030377AbWHOQUX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Aug 2006 12:20:23 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GD1e5-00044Y-SZ
	for git@vger.kernel.org; Tue, 15 Aug 2006 18:20:02 +0200
Received: from host-81-190-28-152.torun.mm.pl ([81.190.28.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 18:20:01 +0200
Received: from jnareb by host-81-190-28-152.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 18:20:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-28-152.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25461>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Note that for each ref there are usually two calls to git subroutines:
>> first to get the type of ref, second to parse ref if ref is of commit
>> or tag type.

[...]  
>> +# parse ref from ref_file, given by ref_id, with given type
>> +sub parse_ref {
>> +    my $ref_file = shift;
>> +    my $ref_id = shift;
>> +    my $type = shift || git_get_type($ref_id);
> 
> This git_get_type() is additional from the original.
> Future-proofing yourself for other new callers?

Yes, just in case.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
