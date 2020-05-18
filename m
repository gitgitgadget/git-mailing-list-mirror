Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BEEC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACE7820758
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgERPvo convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 18 May 2020 11:51:44 -0400
Received: from smtp-nf-201.his.com ([216.194.196.93]:53977 "EHLO
        smtp-nf-201.his.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgERPvo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 11:51:44 -0400
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 May 2020 11:51:43 EDT
Received: from cuda201.his.com (cuda201.his.com [216.194.196.22])
        by smtp-nf-201.his.com (Postfix) with ESMTPS id 6332A60439
        for <git@vger.kernel.org>; Mon, 18 May 2020 11:51:43 -0400 (EDT)
X-ASG-Debug-ID: 1589817102-061c4114ba62b40001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.196.20]) by cuda201.his.com with ESMTP id fPmLddjVCP6sOcBe for <git@vger.kernel.org>; Mon, 18 May 2020 11:51:42 -0400 (EDT)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.196.20
Received: from zproxy101.his.com (zproxy101.his.com [18.218.2.49])
        by smtp-nf-202.his.com (Postfix) with ESMTPS id E05746095B
        for <git@vger.kernel.org>; Mon, 18 May 2020 11:51:42 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id AB370177EE2;
        Mon, 18 May 2020 11:51:42 -0400 (EDT)
X-Barracuda-RBL-IP: 18.218.2.49
X-Barracuda-Effective-Source-IP: zproxy101.his.com[18.218.2.49]
X-Barracuda-Apparent-Source-IP: 18.218.2.49
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DU44ckox3FoD; Mon, 18 May 2020 11:51:42 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id 932FF177EE8;
        Mon, 18 May 2020 11:51:42 -0400 (EDT)
X-Virus-Scanned: amavisd-new at zproxy101.his.com
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yCTKvcGvnsOA; Mon, 18 May 2020 11:51:42 -0400 (EDT)
Received: from [192.168.1.168] (pool-74-96-209-77.washdc.fios.verizon.net [74.96.209.77])
        by zproxy101.his.com (Postfix) with ESMTPSA id 5F99C177EE2;
        Mon, 18 May 2020 11:51:42 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [RFC PATCH 3/6] Add namespace collision avoidance guidelines file
From:   Kenneth Lorber <keni@his.com>
X-ASG-Orig-Subj: Re: [RFC PATCH 3/6] Add namespace collision avoidance guidelines file
In-Reply-To: <20200517094513.GA947@Abhishek-Arch>
Date:   Mon, 18 May 2020 11:51:41 -0400
Cc:     Kenneth Lorber <keni@hers.com>, git@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E3FDDD1B-E0D9-4F20-8B4A-FCC5933F7093@his.com>
References: <1589681624-36969-1-git-send-email-keni@hers.com>
 <1589681624-36969-4-git-send-email-keni@hers.com>
 <20200517094513.GA947@Abhishek-Arch>
To:     1589681624-36969-4-git-send-email-keni@hers.com
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.196.20]
X-Barracuda-Start-Time: 1589817102
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at his.com
X-Barracuda-Scan-Msg-Size: 5838
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=BSF_SC0_MISMATCH_TO
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81937
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 BSF_SC0_MISMATCH_TO    Envelope rcpt doesn't match header
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On May 17, 2020, at 5:45 AM, Abhishek Kumar <abhishekkumar8222@gmail.com> wrote:
> 
> Hello Kenneth,
> 
> On Sat, May 16, 2020 at 10:13:41PM -0400, Kenneth Lorber wrote:
>> From: Kenneth Lorber <keni@his.com>
>> 
>> Add a file of guidelines to prevent the namespace collisions
>> mentioned in git help config without any guidance.
>> 
>> Signed-off-by: Kenneth Lorber <keni@his.com>
>> ---
> 
> Since most users (including me) have never faced a namespace collision
> with Git before, you might have to make a stronger case for why this
> adding namespace collisions to documentation is important.

(This will be addressed in a followup email to a reply later in my inbox.)

> 
> I honestly don't have enough knowledge of Git internals to talk about
> any changes to the guidelines itself.

Fair enough.

> 
>> Documentation/gitrepository-layout.txt        |  1 +
>> .../technical/namespace-collisions.txt        | 86 +++++++++++++++++++
>> 2 files changed, 87 insertions(+)
>> create mode 100644 Documentation/technical/namespace-collisions.txt
>> 
>> diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
>> index 1a2ef4c150..a84a4df513 100644
>> --- a/Documentation/gitrepository-layout.txt
>> +++ b/Documentation/gitrepository-layout.txt
>> @@ -290,6 +290,7 @@ worktrees/<id>/locked::
>> worktrees/<id>/config.worktree::
>> 	Working directory specific configuration file.
>> 
>> +include::technical/namespace-collisions.txt[]
>> include::technical/repository-version.txt[]
>> 
>> SEE ALSO
>> diff --git a/Documentation/technical/namespace-collisions.txt b/Documentation/technical/namespace-collisions.txt
>> new file mode 100644
>> index 0000000000..fb79c82a73
>> --- /dev/null
>> +++ b/Documentation/technical/namespace-collisions.txt
>> @@ -0,0 +1,86 @@
>> +gitattributes
>> +
>> +
>> +NAMESPACE COLLISIONS
>> +--------------------
> 
> A convention I have noticed is that "========" is for the document
> header and "--------" is for section headers.

At the moment at least this is not a stand-alone document, it is included
as a section in gitrepository-layout.txt.  (See patch 4.)  It's a separate
file because I thought it likely someone would suggest putting the content
elsewhere or, as you seem to have assumed, it could be a stand-alone document.

> 
>> +Git uses identifiers in a number of different namespaces:
>> +
>> +* environment variables
>> +* files in $GIT_DIR
>> +* files in the working trees
>> +* config sections
>> +* hooks
>> +* attributes
>> +
>> +In order to reduce the chance of collisions between names Git uses
>> +and those used by other entities (users, groups, and extension authors),
>> +the following are recommended best practices.
>> +
>> +Names reserved to Git:
>> +
>> +* file or directory names ending with `.lock`
>> +* file or directory names starting with `.git`
>> +* filenames in $GIT_DIR
>> +* directory names in $GIT_DIR unless allowed by a rule below
>> +* environment variables starting with `GIT_`
>> +* configuration file sections unless allowed by a rule below
>> +* file or directory names in `$GIT_DIR/hooks` unless allowed by a rule below
>> +* attributes unless allowed by a rule below
>> +
>> +
>> +Names reserved for individual users:
>> +
>> +* The directory `$GIT_DIR/my`
>> +* Environment variables starting with `GIT_MY_`
>> +* Configuration section `my`
>> +* Files or directories in `$GIT_DIR/hooks` starting with `my_`
>> +* Attributes starting with `my_`
>> +
>> +Names reserved for individual repos:
>> +
>> +* The directory `$GIT_DIR/this`
>> +* Environment variables starting with `GIT_THIS_`
>> +* Configuration section `this`
>> +* Files or directories in `$GIT_DIR/hooks` starting with `this_`
>> +* Attributes starting with `this_`
>> +
>> +Names reserved for the lowest level group of people:
>> +
>> +* The directory `$GIT_DIR/our`
>> +* Environment variables starting with `GIT_OUR_`
>> +* Configuration section `our`
>> +* Files or directories in `$GIT_DIR/hooks` starting with `our_`
>> +* Attributes starting with `our_`
>> +
>> +Names reserved for larger groups of people, for companies,
>> +or for extensions that are distributed outside of the originating group:
>> +
>> +$ID is defined as a reverse DNS-style name, with dots replaced by
>> +underscores (preferably) or by hyphens (if necessary).  The $ID
>> +can have as many sections as possible, thus `com.example.sitename.projectid`
>> +is perfectly reasonable.  Use of a name based on a domain you control is
>> +highly recommended; if you do not control a domain, constructing the base of $ID
>> +from your email address is a reasonable alternative, but use double delimiters
>> +in place of the @ sign; for example: `com.example--root.project`
>> +
>> +* The directory $GIT_DIR/$ID
>> +* Environment variables starting with `GIT__$ID_` (note two underscores)
>> +* Configuration section `GIT--$ID`
>> +* Files or directories in `$GIT_DIR/hooks` starting with $ID
>> +* Attributes starting with `git__` (note two underscores)
>> +
>> +Aliases
>> +~~~~~~~
>> +Aliases are a special case.  Users need to type them so they should be
>> +short, but there is no way to prevent such short names from colliding.
>> +So the documentation or installer should construct something like:
>> +
>> +  [alias]
>> +     test = !git my-test
>> +     my-test = !echo made it
>> +
>> +while detecting collisions for the short name.  Then users or local
>> +policy can deal with collisions on the short name.
>> +
>> +This is not meant to cover every possible use case - a policy that
>> +detailed would be ignored and thus of no use.  Please play nicely.
>> -- 
>> 2.17.1
>> 
> 
> Regards
> Abhishek

Thanks,
Keni

