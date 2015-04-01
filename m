From: Kenneth Lorber <keni@his.com>
Subject: Re: bug & patch: exit codes from internal commands are handled incorrectly
Date: Tue, 31 Mar 2015 20:10:05 -0400
Message-ID: <B30AC3FD-A046-40C4-8D37-70835205E446@his.com>
References: <13474FB1-5310-42E5-82A9-4047FEFEFF4A@his.com> <885593BD-3024-4811-83A5-D3A0C4CE6AC1@his.com> <xmqqegrw7omv.fsf@gitster.dls.corp.google.com> <4B764581-0053-467C-93B5-C238EF5AE112@his.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Kenneth Lorber <keni@his.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 02:19:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd6Ml-0006KP-8v
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 02:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbbDAARY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 20:17:24 -0400
Received: from smtp-nf-106.his.com ([216.194.251.35]:33600 "EHLO
	smtp-nf-106.his.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbbDAARX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2015 20:17:23 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Mar 2015 20:17:22 EDT
Received: from cuda201.his.com (cuda201.his.com [216.194.248.226])
	by smtp-nf-106.his.com (Postfix) with ESMTPS id A9A1F61053
	for <git@vger.kernel.org>; Tue, 31 Mar 2015 20:10:11 -0400 (EDT)
X-ASG-Debug-ID: 1427847010-061c4176268ef2e0001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.248.252]) by cuda201.his.com with ESMTP id iRGAQ2T7gGcwwWaA; Tue, 31 Mar 2015 20:10:10 -0400 (EDT)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.248.252
Received: from mail-sterling.his.com (mail-sterling.his.com [216.194.248.141])
	by smtp-nf-202.his.com (Postfix) with ESMTP id BD1526032E;
	Tue, 31 Mar 2015 20:10:10 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail-sterling.his.com (Postfix) with ESMTP id 1A2BA3F90017;
	Tue, 31 Mar 2015 20:10:10 -0400 (EDT)
X-Barracuda-RBL-Trusted-Forwarder: 216.194.248.141
X-Virus-Scanned: amavisd-new at mail-sterling.his.com
Received: from mail-sterling.his.com ([127.0.0.1])
	by localhost (mail-sterling.his.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PJAauY94SYCR; Tue, 31 Mar 2015 20:10:06 -0400 (EDT)
Received: from polyhymnia.home (pool-173-73-55-199.washdc.fios.verizon.net [173.73.55.199])
	by mail-sterling.his.com (Postfix) with ESMTPSA id DCCC83FB000D;
	Tue, 31 Mar 2015 20:10:05 -0400 (EDT)
X-Barracuda-Apparent-Source-IP: 173.73.55.199
X-ASG-Orig-Subj: Re: bug & patch: exit codes from internal commands are handled incorrectly
In-Reply-To: <4B764581-0053-467C-93B5-C238EF5AE112@his.com>
X-Mailer: Apple Mail (2.1878.6)
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.248.252]
X-Barracuda-Start-Time: 1427847010
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
Received-SPF: pass (his.com: domain of keni@his.com designates 216.194.248.141 as permitted sender)
X-Virus-Scanned: by bsmtpd at his.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.17408
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266586>

Ping?  The original version of this got some discussion, but this version - nothing.

Thanks,
Keni

On Feb 1, 2015, at 5:32 PM, Kenneth Lorber <keni@his.com> wrote:

> 
> On Dec 18, 2014, at 2:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
>> Kenneth Lorber <keni@his.com> writes:
>> 
>>>> Bug: exit codes from (at least) internal commands are handled incorrectly.
>>>> E.g. git-merge-file, docs say:
>>>>      The exit value of this program is negative on error, and the number of
>>>>      conflicts otherwise. If the merge was clean, the exit value is 0.
>>>> But only 8 bits get carried through exit, so 256 conflicts gives
>>>> exit(0), which means the merge was clean.
>> 
>> Wouldn't any cmd_foo() that returns negative to main() be buggy?
> 
> Yes.
> 
>> 
>> Your change sweeps such problems under the rug, which is not a
>> healthy thing to do.
> 
> Agreed.  (See below.)
> 
>> 
>> Expecting that the exit code can signal small positive integers and
>> other generic kinds of failures is a losing proposition.  I think it
>> is a better fix to update cmd_merge_file() to return 1 (when ret is
>> positive), 0 (when ret is zero) or 128 (when ret is negative), or
>> something simple like that, and update the documentation to match
>> that, without touching git.c::main().
> 
> The new patch uses 0, 1, and 2 to match diff(1).
> 
>> Among the in-tree users, I notice git-cvsserver.perl is already
>> using the command incorrectly.  It does this:
>> 
>>           my $return = system("git", "merge-file", $file_local, $file_old, $file_new);
>>           $return >>= 8;
>> 
>>           cleanupTmpDir();
>> 
>>           if ( $return == 0 )
>>           {
>>               $log->info("Merged successfully");
>>               ...
>>           }
>>           elsif ( $return == 1 )
>>           {
>>               $log->info("Merged with conflicts");
>>               ...
>>           }
>>           else
>>           {
>>               $log->warn("Merge failed");
>>               next;
>>           }
>> 
>> which assumes $return == 1 is special "half-good", which is not
>> consistent with the documented interface.  It will incorrectly
>> say "Merge failed" when there are two or more conflicts.
>> 
>> And with such a "1 or 0 or -1" change, you will fix that caller as
>> well ;-)
> 
> I'll call that a win.
> 
> The attached patch covers the following:
> - fixes all places where "make test" attempts to call exit() with a value <0 or >255
> - changes git-merge-file.txt to reflect the change in exit codes
> - fixes the exit codes for merge-file
> - adds a warning (which should probably be changed to something clearer) if git.c:run_builtin() is going to cause an out-of-bounds exit
> - fixes a typo in t7007-show.sh
> - replaces return(0) with exit(0) in test-parse-options.c
> 
> The diff is cut against 15598cf41beed0d86cd2ac443e0f69c5a3b40321 (2.3.0-rc2)
> 
> Thanks,
> Keni
> 
> 
> <d2.ship>
> 
