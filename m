From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [BUG] t9801 and t9803 broken on next
Date: Sat, 14 May 2016 10:04:40 +0200
Message-ID: <4830D469-3885-4010-9A04-D809F0C6159D@gmail.com>
References: <3A110437-F778-42E2-A987-86B4EAB3D963@gmail.com> <20160513103621.GA12329@dcvr.yhbt.net> <xmqqpospap8g.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Eric Wong <e@80x24.org>, Git Users <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 14 10:05:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1UZF-0005Jf-8Q
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 10:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbcENIEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 04:04:50 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36389 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbcENIEo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2016 04:04:44 -0400
Received: by mail-wm0-f49.google.com with SMTP id n129so46314388wmn.1
        for <git@vger.kernel.org>; Sat, 14 May 2016 01:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BDdnjG/6TrVydY3QZ/E+A8boJXxiNiUZys2Wc6D/B7A=;
        b=eM+I9ctKVixWe7hF1Qd5ChQFW6VKDYyfn5l0eAHwTmD/EOhnb8+7G8m+JY1QbZDjo9
         DZHjpF5pfjm9wAdRXIQIzuzNY5FaDoLDlfUOdsmehL468OfPTq0d8Yv7BZkxMVPRTWkP
         vArTYTq3aCmXgBw9Fbr3qAt8C6oJUH3P7RGEdlDd+BCl7OjaHUMNekYcNwBUNIoMmW+S
         7gGzNjxyo26iO+kVi/F8P0Mmp1bZiYZ6wFENcqDZGwYaquXVy8TV/nT5zDWN6yHpz3qY
         t7W5EzxTNaBfqCsk1zASYvC1r+/g9C13iH8kQF4wYq/nCm7h+LiijFp3i7cEqxv0bi+O
         2yPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BDdnjG/6TrVydY3QZ/E+A8boJXxiNiUZys2Wc6D/B7A=;
        b=FTR7uUAflUhcf50c3Xb2g0NqvILXBklWTEhrPptIj45GlbLkIEytx/uBsHPXGTcb1X
         1Kd2aYKJ/el6B+dEh5vS3YCChb2Kj6E8woSWViQCGk+8cXzqoLyyKUwJd5iiP9VFxu1D
         HKjNLdVJXGXSKFTNXucNOUYo4ctPugOm7+Tl5CNSwhB4GLaAqhVdZ/nm0WmFBBEhAZlF
         YiL/ZSsH33NHtKuFHW91vJGg6zgim6D5rL5/dgd3VhyTphDZowfhUtCgoL4aHQPFTh+I
         2RulfdKAOUR6YBhwCkxO83lPWyNoc9rAwntQtyWvzVUodYIF7NRkn3IuVVze/fNb+DlV
         OSkw==
X-Gm-Message-State: AOPr4FXu5gdEin+RTu0kC4dqeeMTDCoNEBz4Se4pOEkmAL/qGEM0x6FBgYPrdmmimhwYcw==
X-Received: by 10.194.163.229 with SMTP id yl5mr19601628wjb.6.1463213082713;
        Sat, 14 May 2016 01:04:42 -0700 (PDT)
Received: from [192.168.0.185] (HSI-KBW-085-216-063-210.hsi.kabelbw.de. [85.216.63.210])
        by smtp.gmail.com with ESMTPSA id jr8sm22399784wjb.15.2016.05.14.01.04.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 May 2016 01:04:41 -0700 (PDT)
In-Reply-To: <xmqqpospap8g.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294604>


> On 13 May 2016, at 18:37, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Eric Wong <e@80x24.org> writes:
> 
>> Lars Schneider <larsxschneider@gmail.com> wrote:
>>> Hi,
>>> 
>>> t9801 and t9803 seem to be broken on next. A quick bisect indicates that d9545c7 
>>> "fast-import: implement unpack limit" might be the reason. (@gmane/292562).
>>> 
>>> Did anyone look into that already?
>> 
>> Just took a look (no p4, so couldn't run tests) and I guess it's
>> because the default changed and it doesn't generate tiny packs.
> 
> I looked at t9801 but I couldn't spot where it cares if the objects
> are in a (tiny) pack or stored as individual loose objects.  All the
> counting I saw was about rev-list/log output and they shouldn't care.
> 
> Are you saying that "git p4" itself breaks unless fast-import always
> writes a new (tiny) packfile?  That sounds quite broken, and setting
> unpacklimit to 0 does not sound like a sensible "fix".  Of course,
> if the test script is somehow looking at the number of packs or
> loose objects and declaring a failure, even when the resulting
> history in p4 and git are correct, then that is a different issue,
> and forcing to explode a tiny pack is a reasonable workaround.  I
> couldn't quite tell which the case is.
> 
> Puzzled.  Please help.

t9801 "import depot, branch detection" is the first test that fails
with a fast import error:
https://github.com/git/git/blob/78b384c29366e199741393e56030a8384110760d/t/t9801-git-p4-branch.sh#L110

fast-import crash report:
    fast-import process: 77079
    parent process     : 77077
    at 2016-05-14 07:48:40 +0000

fatal: offset beyond end of packfile (truncated pack?)

Most Recent Commands Before Crash
---------------------------------
  commit refs/remotes/p4/master
  mark :1
  committer Dr. author <author@example.com> 1463212118 +0000
  data <<EOT
  M 100644 inline f1
  data 3
  
  commit refs/remotes/p4/master
  mark :2
  committer Dr. author <author@example.com> 1463212118 +0000
  data <<EOT
  M 100644 inline f2
  data 3
  
  commit refs/remotes/p4/master
  mark :4
  committer Dr. author <author@example.com> 1463212118 +0000
  data <<EOT
  M 100644 inline f4
  data 3
  
  checkpoint
  commit git-p4-tmp/6
  mark :6
  committer Dr. author <author@example.com> 1463212118 +0000
  data <<EOT
  M 100644 inline f1
  data 3
  M 100644 inline f2
  data 3
  M 100644 inline f4
  data 3
  
  checkpoint
  progress checkpoint
  commit refs/remotes/p4/depot/branch2
  mark :6
  committer Dr. author <author@example.com> 1463212118 +0000
  data <<EOT
  from 1ab0d5b43b6070682f8bd6f3fd674d4fcddd9345
* M 100644 inline f1

Active Branch LRU
-----------------
    active_branches = 2 cur, 5 max

  pos  clock name
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1)      4 git-p4-tmp/6
   2)      3 refs/remotes/p4/master

Inactive Branches
-----------------
git-p4-tmp/6:
  status      : active loaded
  tip commit  : 3aef1b3e7d821051780a89262f2e2fae33ed8af3
  old tree    : 30a8495449245cdb9626ef48902ba672cf76576f
  cur tree    : 30a8495449245cdb9626ef48902ba672cf76576f
  commit clock: 4
  last pack   : 0

refs/remotes/p4/master:
  status      : active loaded
  tip commit  : 1ab0d5b43b6070682f8bd6f3fd674d4fcddd9345
  old tree    : 30a8495449245cdb9626ef48902ba672cf76576f
  cur tree    : 30a8495449245cdb9626ef48902ba672cf76576f
  commit clock: 3
  last pack   : 0

refs/remotes/p4/depot/branch2:
  status      : loaded
  tip commit  : 1ab0d5b43b6070682f8bd6f3fd674d4fcddd9345
  old tree    : 30a8495449245cdb9626ef48902ba672cf76576f
  cur tree    : 30a8495449245cdb9626ef48902ba672cf76576f
  commit clock: 0
  last pack   : 


Marks
-----
:1 47474c2e749d579c63b375231c018289aa00cd0f
:2 9c6b957c0b4d4991b8bbd17858aa2a271d2c76c3
:4 1ab0d5b43b6070682f8bd6f3fd674d4fcddd9345
:6 3aef1b3e7d821051780a89262f2e2fae33ed8af3

-------------------
END OF CRASH REPORT


> 
>> The easiest change is probably to call:
>> 
>> 	git config fastimport.unpackLimit 0
>> 
>> during setup like t9300 now does.
Unfortunately that seems not to help.

The problem seems to be related to the git-p4 branch import.
I don't have time this weekend to look further into it, but
I will try next week.

Cheers,
Lars