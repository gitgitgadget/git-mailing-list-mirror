From: Bill Burdick <bill@mobilereasoning.com>
Subject: Re: cvsserver problem with eclipse?
Date: Mon, 01 May 2006 16:23:42 +0000
Message-ID: <4456360E.8060305@mobilereasoning.com>
References: <4455B863.8040808@mobilereasoning.com> <46a038f90605011338i5498f857lf230d9a965aa759@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050704020009050602030307"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 01 23:21:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FafpX-0001fY-61
	for gcvg-git@gmane.org; Mon, 01 May 2006 23:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWEAVVI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 17:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWEAVVI
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 17:21:08 -0400
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:36241 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S932251AbWEAVVH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 May 2006 17:21:07 -0400
Received: from Shofar.mobilereasoning.com (CPE-24-166-171-225.kc.res.rr.com [24.166.171.225])
	by ms-smtp-02.rdc-kc.rr.com (8.13.6/8.13.6) with ESMTP id k41LL4DC014810;
	Mon, 1 May 2006 16:21:05 -0500 (CDT)
Received: by Shofar.mobilereasoning.com (Postfix, from userid 1012)
	id 7BDBE22C22; Mon,  1 May 2006 15:36:41 -0500 (CDT)
Received: from [10.0.0.10] (hiram.mobilereasoning.com [10.0.0.10])
	by Shofar.mobilereasoning.com (Postfix) with ESMTP
	id 17CE4208F2; Mon,  1 May 2006 15:36:41 -0500 (CDT)
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605011338i5498f857lf230d9a965aa759@mail.gmail.com>
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	Shofar.mobilereasoning.com
X-Spam-Level: *
X-Spam-Status: No, hits=1.8 required=5.0 tests=DATE_IN_PAST_03_06,
	REMOVE_REMOVAL_NEAR autolearn=no version=2.63
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19390>

This is a multi-part message in MIME format.
--------------050704020009050602030307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

OK, I replaced the eclipse file (yoda) with the latest from the head.  
Then I changed it in my git project, committed it, and pushed it to the 
shared repo.  Finally, I did a "compare with latest from head" and it 
proceeded to update the file and then said that there were no changes.  
Here's the log:

Valid-responses ok error M E Checked-in Valid-requests Template 
Set-sticky MT Clear-static-directory Module-expansion 
Set-static-directory Clear-sticky New-entry Merged Removed Updated 
Remove-entry Update-existing Copy-file Created Notified Mod-time
valid-requests
Valid-requests remove add status Entry watchers ci tag log co Modified 
Questionable admin Root history valid-requests Global_option Argumentx 
annotate Valid-responses Unchanged Directory rlog Argument 
expand-modules diff editors update
ok
Root /tmp/public.git
CMD> cvs -n update -d "/yoda/yoda"
Global_option -n
Argument -d
Directory .
/tmp/public.git/yoda
Entry /yoda/1.9///
Modified yoda
u=rw,g=rw,o=r
48
Argument yoda
Directory .
/tmp/public.git/yoda
update
M C yoda
Update-existing ./
/tmp/public.git/yoda/yoda
/yoda/1.10/+//
u=rw,g=rw,o=rw
95
ok
RESULT> Status OK: org.eclipse.team.cvs.core code=0 ok null
Valid-responses ok error M E Checked-in Valid-requests Template 
Set-sticky MT Clear-static-directory Module-expansion 
Set-static-directory Clear-sticky New-entry Merged Removed Updated 
Remove-entry Update-existing Copy-file Created Notified Mod-time
valid-requests
Valid-requests remove add status Entry watchers ci tag log co Modified 
Questionable admin Root history valid-requests Global_option Argumentx 
annotate Valid-responses Unchanged Directory rlog Argument 
expand-modules diff editors update
ok
Root /tmp/public.git
CMD> cvs status "yoda"
Directory .
/tmp/public.git/yoda
Entry /yoda/0///
Modified yoda
u=rw,g=rw,o=r
0
Argument yoda
Directory .
/tmp/public.git/yoda
status
M ===================================================================
M File: yoda    Status: Needs Checkout
M Working revision:    0
M Repository revision:    1.10    /tmp/public.git/yoda/yoda,v
M Sticky Tag:        (none)
M Sticky Date:        (none)
M Sticky Options:        (none)
M
ok
RESULT> Status OK: org.eclipse.team.cvs.core code=0 ok null


Martin Langhoff wrote:

> On 5/1/06, Bill Burdick <bill@mobilereasoning.com> wrote:
>
>> OK, I changed the way I was testing this to match your usage plan and I
>> still got the same results.  It works just fine for vanilla CVS; cvs
>> status shows the re revision in the repo and cvs update brings it in.
>
>
> That's a good start!
>
>> Eclipse has the same funky behavior: Compare with latest at the project
>> level shows no differences, but compare with latest on the changed file
>> actually does an update instead of popping up the Eclipse diff viewer.
>
>
> Hmmm. Eclipse does some weird funky sh*t sometimes. Can you ask it to
> get you a log? There's an option in Eclipse CVS control settings that
> will enable logging of cvs commands to the console. Enable it, and
> then start Eclipse from the commandline, piping stderr and stdout to a
> logfile.
>
> There are also some weird differences depending on how you ask for the
> update or diff. I hate doing this but I'll have to ask you to tell me
> exactly how you ask for the diff and for the update.
>
> And the platform you are running Eclipse on.
>
>> By the way, I had trouble at first accessing the repo with SSH because
>> of permissions on the sqlite db.  I'm not totally sure about the
>> implications for multiple users, but maybe just using a common group
>> will work fine?
>
>
> Yes, a common group is the thing to do.
>
>  $ chgrp gitusers *sqlite
>  $ chmod g+w *sqlite
>
>> I'm really happy with git and git-cvsserver!  I'm hoping to be able to
>> standardize on it for our Eclipse work.  It seems like it should be
>
>
> Great to hear that!
>
> cheers,
>
>
>
> martin
>


--------------050704020009050602030307
Content-Type: text/x-vcard; charset=utf-8;
 name="bill.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="bill.vcf"

begin:vcard
fn:Bill Burdick
n:Burdick;Bill
org:Mobile Reasoning
email;internet:bill@mobilereasoning.com
title:Chief Scientist
tel;work:913-484-0172
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------050704020009050602030307--
