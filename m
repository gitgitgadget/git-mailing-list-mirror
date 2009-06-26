From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git svn: Support multiple branch and tag paths in the
 svn repository.
Date: Fri, 26 Jun 2009 07:18:33 +0200
Message-ID: <4A445A29.90907@op5.se>
References: <4A3A4945.6050307@drmicha.warpmail.net> <1245335463-4488-1-git-send-email-git@drmicha.warpmail.net> <4A3F9A44.8070805@xiplink.com> <4A410A90.1090101@xiplink.com> <20090625093602.GA3997@dcvr.yhbt.net> <7v3a9o0x48.fsf@alter.siamese.dyndns.org> <20090626003338.GA591@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jun 26 07:18:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK3pl-0001xm-CF
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 07:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbZFZFSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 01:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbZFZFSf
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 01:18:35 -0400
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:38271 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751269AbZFZFSf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2009 01:18:35 -0400
Received: from source ([72.14.220.152]) by na3sys009aob105.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSkRaLGTPy1lkzMxDtlQ7v9HaAwoh7Zny@postini.com; Thu, 25 Jun 2009 22:18:38 PDT
Received: by fg-out-1718.google.com with SMTP id d23so536116fga.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 22:18:36 -0700 (PDT)
Received: by 10.86.68.1 with SMTP id q1mr3319044fga.10.1245993516300;
        Thu, 25 Jun 2009 22:18:36 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 4sm200241fge.18.2009.06.25.22.18.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 22:18:35 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090626003338.GA591@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122279>

Eric Wong wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Wong <normalperson@yhbt.net> writes:
>>
>>> Acked and and pushed out to git://git.bogomips.org/git-svn along with a
>>> followup patch ...
>> Hmmm...
>>
>> t9138-git-svn-multiple-branches.sh does not seem to pass for me.
>>
>>     ...
>>     A    svn_project/tags_A/1.0
>>     A    svn_project/tags_A/1.0/a.file
>>     Checked out revision 3.
>>     ./test-lib.sh: line 329: .: filename argument required
>>     .: usage: . filename [arguments]
>>     FATAL: Unexpected exit with code 2
> 
> Oops, I wasn't reading the test too closely[1], this should fix it:
> 
> From 1ad8ff7b49f508ad37081a709d4230833564eca2 Mon Sep 17 00:00:00 2001
> From: Eric Wong <normalperson@yhbt.net>
> Date: Thu, 25 Jun 2009 16:09:59 -0700
> Subject: [PATCH] t9138: remove stray "." in tests
> 
> This breaks bash and probably some other shells, but worked
> fine with dash in my limited testing.
> 

Please reword to "The stray dots break bash and ..."
Right now it reads as if the patch itself breaks bash et al.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
