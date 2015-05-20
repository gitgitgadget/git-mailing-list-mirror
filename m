From: Christian Couder <christian.couder@gmail.com>
Subject: Re: identical hashes on two branches, but holes in git log
Date: Wed, 20 May 2015 09:39:14 +0200
Message-ID: <CAP8UFD2jvJy9VBp_YKnnQ4z-uM4kVqJmxTQq=FAEe=RpS5-_tg@mail.gmail.com>
References: <20150519132958.GA21130@frolo.macqel>
	<xmqq617oa75l.fsf@gitster.dls.corp.google.com>
	<20150519214719.GA12732@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Philippe De Muyter <phdm@macq.eu>
X-From: git-owner@vger.kernel.org Wed May 20 09:39:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuyb2-0002D9-EA
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 09:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbbETHjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 03:39:16 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34505 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbbETHjP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 03:39:15 -0400
Received: by wicmc15 with SMTP id mc15so140633738wic.1
        for <git@vger.kernel.org>; Wed, 20 May 2015 00:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=I8ZIxTYZSIh7dpJaoI1gxdNa8KlGVmBADF/av0dPyUk=;
        b=Wwk1NNma4jWbTu2T279oADzAVGQZvm7gi5b5prblUGBg9FYwi0VlQBRMV5QijZs32g
         DfgeVJ/zr1S0ShY6np+oGSaPqf2AM7TMRE40RjaMqd/DfNu2DLzuveuwYlkyH23G3IYy
         Vrup4KMSsTee6lfS/4ak+SaC6Ez0oJwFMPa7Ai78ZsAB8yCfvxyr8ZoBPWGLUUVDBYZt
         xRKN58Blxu7v+yy0+JEAOvW1rxmZU74B1Nw279pNrHvFHD14uUsonO8qpn4lbNaYyrhc
         tbHgIrIS2xcPGQb3YxmDMuwCPvt/yS4/d//Gf3H+OjLEeiH3ijltwUFQUWD+DsfpmEvI
         d1lg==
X-Received: by 10.194.178.227 with SMTP id db3mr61073080wjc.82.1432107554428;
 Wed, 20 May 2015 00:39:14 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Wed, 20 May 2015 00:39:14 -0700 (PDT)
In-Reply-To: <20150519214719.GA12732@frolo.macqel>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269446>

On Tue, May 19, 2015 at 11:47 PM, Philippe De Muyter <phdm@macq.eu> wrote:
> On Tue, May 19, 2015 at 09:01:10AM -0700, Junio C Hamano wrote:
>> Philippe De Muyter <phdm@macq.eu> writes:
>>
>> > Trying to understand, I have eventually done "git log" on my branch and
>> > on v3.15 with the following commands :
>> >
>> > git log v3.15 --full-history --decorate=short | grep '^commit' > /tmp/3.15.commits
>> > git log --full-history --decorate=short | grep '^commit' > /tmp/mybranch.commits
>>
>> Either
>>
>>     git log --oneline v3.15..HEAD ;# show what I have not in theirs
>>
>> or
>>
>>     gitk v3.15...HEAD ;# show our differences graphically
>
> This shows the commits in my branch starting from the most recent common point,
> thus my commits, but I see differences in the files not explained by my commits,
> but by the fact that many older commits (between v3.13 and v3.14) are missing on
> my branch, but still in both branches I have a commit called v3.14 with the
> same hash.  Is that normal ?

As this is the linux kernel, maybe everything you are working on is
open source and you can push it to a public git hosting service (like
GitHub, BitBucket, ...), so people can have a look there or clone it
from there?

(And if you do that it would help when talking about differences in
some files, if you could tell which files and which commits, and maybe
also which git commands you used.)
