From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Items not covered by repository-layout.txt
Date: Mon, 10 Jul 2006 23:42:42 +0200
Organization: At home
Message-ID: <e8uhjg$5o1$1@sea.gmane.org>
References: <e8ue98$o7t$1@sea.gmane.org> <7v1wstb12x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Jul 10 23:42:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G03WY-0007zP-QC
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 23:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965255AbWGJVmf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 17:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965256AbWGJVmf
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 17:42:35 -0400
Received: from main.gmane.org ([80.91.229.2]:45254 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965255AbWGJVmf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 17:42:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G03WD-0007wH-61
	for git@vger.kernel.org; Mon, 10 Jul 2006 23:42:17 +0200
Received: from host-81-190-19-52.torun.mm.pl ([81.190.19.52])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Jul 2006 23:42:17 +0200
Received: from jnareb by host-81-190-19-52.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Jul 2006 23:42:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-19-52.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23657>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> I have noticed few files in .git/ directory which currently are not covered
>> (and neither is their format) by Documentation/repository-layout.txt
>>
>> * COMMIT_EDITMSG (temporary file, when I decided during writing commit
>>   message that I should change something before commit)
>> * FETCH_HEAD (format?)
>> * HEAD, ORIG_HEAD and probably some other *_HEAD
>> * .tmp-vtag (I'm not sure what have left that, probably git-verify-tag
>>   broken due to lack of signing PGP keys)
>> * description file
>>
>> I know they are fairly obvious, but having everything that one could fing in
>> his/her git-core managed .git repository would be nice... 

I have just noticed that _config_ file (!)is not covered by repository-layout.txt
 
> Yup, please make it so.

Could you then tell me what is the format of FETCH_HEAD and what other *_HEADs 
can be seen in $GIT_DIR (MERGE_HEAD?)?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
