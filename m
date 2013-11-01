From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 03/16] pull: cleanup documentation
Date: Thu, 31 Oct 2013 19:56:03 -0600
Message-ID: <CAMP44s0rtJyJTW36iYX-RRu6NcQ1yF0NUUTXQoCUpMkWVg2Zmg@mail.gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-4-git-send-email-felipe.contreras@gmail.com>
	<xmqqiowd71kv.fsf@gitster.dls.corp.google.com>
	<CAMP44s3AKnZUJy0O0Hg+G=ER2bRn1nHMBeoJQ=ugCzO4d2WZ-g@mail.gmail.com>
	<xmqqob655kqi.fsf@gitster.dls.corp.google.com>
	<ADB546B4-992E-4B54-953E-B721BECD19B2@quendi.de>
	<xmqqzjpp447x.fsf@gitster.dls.corp.google.com>
	<xmqqfvrh41e0.fsf@gitster.dls.corp.google.com>
	<CAMP44s14_GbN0nEm4Eu2Jdb5cO+jVaTVOnDqzwv0GK4_jfD93w@mail.gmail.com>
	<20131031234048.GA41400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Max Horn <max@quendi.de>,
	git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 01 02:56:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vc3yK-0002v9-HN
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 02:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566Ab3KAB4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 21:56:10 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:54090 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab3KAB4I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 21:56:08 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so3035805lbh.35
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 18:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yZ1fyXD9Yx1/bMjepfkIae6S/V1+f1+iOiIpo+6u8ig=;
        b=0Sjvx/5JdqMzDEP8cy1twNgzlEm/RND5t3V3WSg30zjPMDTM27Ed/urZ7gn/3r1Suq
         D3Q/K5q6vXIyN8L4VJRYMlzBbTkT7HswePrLEl6ZoM2AIgk1NR1QmFIo3lWKcYeJaw3B
         TuB8mgIoSFm3qSjQLqD6w886MzZvnNB0BbY4ZOAtWfFd42myOty/L7jfJvlp0vVxUhzF
         nzY4uyVmrpjW8yaI+nwhzQWt4jjHOTxJh1bEISAJBsOFJut+nqVUyUF+D2vI+SwN6Kvw
         qsMiNQ61wZobJj0WsZM8VANAVePuxOUqolv8E1CmNiqb5eZStE1goAee5sQ6kv8P0NgH
         0s6g==
X-Received: by 10.152.28.194 with SMTP id d2mr344311lah.2.1383270963909; Thu,
 31 Oct 2013 18:56:03 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Thu, 31 Oct 2013 18:56:03 -0700 (PDT)
In-Reply-To: <20131031234048.GA41400@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237199>

On Thu, Oct 31, 2013 at 5:40 PM, David Aguilar <davvid@gmail.com> wrote:
> On Thu, Oct 31, 2013 at 03:16:57PM -0600, Felipe Contreras wrote:
>> On Thu, Oct 31, 2013 at 2:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > Junio C Hamano <gitster@pobox.com> writes:
>>
>> > The other reason the original did not say "origin/master" is because
>> > this holds true even if you do not have such a remote-tracking
>> > branch for the master at the origin, but the illustration that shows
>> > the history after "git pull" finishes spells remotes/origin/master
>> > out, so I think it would be an improvement to make the two pictures
>> > consistent by drawing where the origin/master is before this "git
>> > pull" is run.
>>
>> So you care about "reality" when it fits your argument, but not when
>> it doesn't. Got it.
>
> What exactly do these flippant remarks accomplish?
> Keep these to yourself.  No one deserves this treatment nor does
> anyone care to read it.

Nobody is forcing you to read them.

However, they happen to be true. Junio used as an argument that
'origin/master' is not better than 'master on origin' because the
"real" 'origin/master' might be pointing to something else, however,
when he himself realized that 'origin/master' might not exist at all,
then suddenly the "real" 'origin/master' is not so important.

If this was a rational discussion I would ask you to point out where
exactly the previous explanation is incorrect, but alas, if experience
serves, this is not one of those.

The facts are very simple, Junio's proposal:

------------
          A---B---C master on origin
         /
    D---E---F---G master
        ^
       origin/master in your repository
------------

Assumes that:

1) The user did 'git pull origin', not 'git pull $url', or any other remote
2) 'origin/master' points to E, which might not be true, the user
might have issued a 'git fetch', or a previous pull might have been
cancelled

Both issues are overridden by the comment "Assume the following
history exists", so one has to assume that origin/master points to E,
but if one assumes that, then my proposal is also correct:

------------
         A---B---C origin/master
        /
    D---E---F---G master
------------

Because one has to assume that 'origin/master' points to C, which is
entirely possible. But more importantly, for the purposes of
explaining 'git pull' it lightens the mental load needed by the user.

Either Junio's argument applies to both proposals, or none, but
selectively cherry-picking where the argument applies is akin to a
feminist that argues men and women are equal, but men should pick the
check in a restaurant.

-- 
Felipe Contreras
