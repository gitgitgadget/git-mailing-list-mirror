From: Bill Burdick <bill@mobilereasoning.com>
Subject: Re: cvsserver problem with eclipse?
Date: Mon, 01 May 2006 13:06:06 +0000
Message-ID: <445607BE.3090503@mobilereasoning.com>
References: <4455B863.8040808@mobilereasoning.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080307080808050004060902"
X-From: git-owner@vger.kernel.org Mon May 01 20:03:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fack9-0004cg-IN
	for gcvg-git@gmane.org; Mon, 01 May 2006 20:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWEASDa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 14:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWEASDa
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 14:03:30 -0400
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:7115 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S932187AbWEASD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 May 2006 14:03:29 -0400
Received: from Shofar.mobilereasoning.com (CPE-24-166-171-225.kc.res.rr.com [24.166.171.225])
	by ms-smtp-01.rdc-kc.rr.com (8.13.6/8.13.6) with ESMTP id k41I3SDb023849
	for <git@vger.kernel.org>; Mon, 1 May 2006 13:03:28 -0500 (CDT)
Received: by Shofar.mobilereasoning.com (Postfix, from userid 1012)
	id CB54A22C20; Mon,  1 May 2006 12:19:05 -0500 (CDT)
Received: from [10.0.0.10] (hiram.mobilereasoning.com [10.0.0.10])
	by Shofar.mobilereasoning.com (Postfix) with ESMTP id 6EF94208F2
	for <git@vger.kernel.org>; Mon,  1 May 2006 12:19:05 -0500 (CDT)
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <4455B863.8040808@mobilereasoning.com>
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	Shofar.mobilereasoning.com
X-Spam-Level: 
X-Spam-Status: No, hits=0.7 required=5.0 tests=DATE_IN_PAST_03_06 
	autolearn=no version=2.63
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19383>

This is a multi-part message in MIME format.
--------------080307080808050004060902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

FWIW, I'm using Eclipse 3.2RC1a.

Bill


Bill Burdick wrote:

> [taking this conversation to the list]
>
> OK, I changed the way I was testing this to match your usage plan and 
> I still got the same results.  It works just fine for vanilla CVS; cvs 
> status shows the re revision in the repo and cvs update brings it in.  
> Eclipse has the same funky behavior: Compare with latest at the 
> project level shows no differences, but compare with latest on the 
> changed file actually does an update instead of popping up the Eclipse 
> diff viewer.
>
> By the way, I had trouble at first accessing the repo with SSH because 
> of permissions on the sqlite db.  I'm not totally sure about the 
> implications for multiple users, but maybe just using a common group 
> will work fine?
>
> I'm really happy with git and git-cvsserver!  I'm hoping to be able to 
> standardize on it for our Eclipse work.  It seems like it should be 
> possible for us to continue to do integrations in Eclipse if we manage 
> git properly.  I've been waiting on arch, baz, and bzr for so long and 
> then suddenly, Linus pulls this out of his butt!
>
>
> Bill Burdick
>
>
>
> ---------- Forwarded message ----------
> From: *Martin Langhoff (CatalystIT)* < martin@catalyst.net.nz 
> <mailto:martin@catalyst.net.nz>>
> Date: May 1, 2006 6:41 AM
> Subject: Re: cvsserver problem with eclipse?
> To: Bill Burdick <bill.burdick@gmail.com <mailto:bill.burdick@gmail.com>>
> Cc: Martyn Smith < martyn@catalyst.net.nz 
> <mailto:martyn@catalyst.net.nz>>
>
> Hi Bill,
>
> the git repo you are using, did you set it up to just be a "naked" or
> "bare" repo, and enabled cvsserver alright? What version of git are you
> using?
>
> My usage plan would be to
>
> 1 - Have a git test project
> 2 - Publish it to a naked/bare repository where git-cvsserver is enabled
> 3 - Get the cvs checkout (try commandline cvs to make sure things work)
> 4 - Add commits in the git test project and push them to the repo
> 5 - Run cvs update
>
> If it's running ok with old school CVS client, then try with Eclipse. We
> have tested the update scenario quite a bit, and it works for us, so we
> need a bit more info.
>
> BTW, can I ask you to bounce these questions off the 
> git@vger.kernel.org <mailto:git@vger.kernel.org>
> mailing list? We will be happier answering these questions in a way that
> gets archived publicly. (Unless you are a direct client of Catalyst IT,
> that is! Are you at OpenUniversity perhaps?)
>
> cheers,
>
>
> martin
>
> Bill Burdick wrote:
>
>>  I made a test git repo with a branch called WillyTest and slurped it
>>  into Eclipse.  Then I checked out WillyTest into the git directory and
>>  committed a change.  A synchronize in Eclipse did not detect the 
>> change,
>>  nor did comparing with the latest on the head.  Showing history on the
>>  changed file did, however, list the new revision and I could access the
>>  contents from that view.  Compare with latest on the changed file
>>  actually replaces the current contents with the repository version.
>>
>>  Bill Burdick
>>
>
>
> -- 
> -----------------------------------------------------------------------
> Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
> WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
> OFFICE: +64(4)916-7224                              MOB: +64(21)364-017
>       Make things as simple as possible, but no simpler - Einstein
> -----------------------------------------------------------------------



--------------080307080808050004060902
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


--------------080307080808050004060902--
