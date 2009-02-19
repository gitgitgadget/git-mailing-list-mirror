From: John Tapsell <johnflux@gmail.com>
Subject: Re: git rebase -i
Date: Thu, 19 Feb 2009 09:55:27 +0000
Message-ID: <43d8ce650902190155m4de23643r8a9d3c35686ea4e9@mail.gmail.com>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>
	 <A3E3A7A0-F03F-4C8B-B3F8-756B0E89798C@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 10:57:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La5eM-0004i6-KA
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 10:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755AbZBSJzb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Feb 2009 04:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753562AbZBSJza
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 04:55:30 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:65471 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbZBSJza convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2009 04:55:30 -0500
Received: by gxk22 with SMTP id 22so821883gxk.13
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 01:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=xw7gjvC+OsNHqZj3WVA1LXmBM2aj3n8QKoa9N9BoHWE=;
        b=C3SRYxrTPJ1ICfGwaXPCU+YL9tqHjqHxT0R/C4B4QSB71VI4X4Lxey7AvgomSKHmpu
         vp79WJx2BL0NwgE0Yt3nE2zF2XcmIlhQ7mkrRhLWDmvTe1Zuk89bMzhHa9CcnY9wuVio
         meDAy5SbMSik15AbwutI8thqqmyxGWAqRKMeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=Ki59ki63bqKr3fQuTUFKcSqcl1T+EcNWejH7YV4+FYqzBxSnneLMpv2OjltGrfXWaP
         bMZo4pSD5pWl2gcf0wPoYQ8KRZNdl4QaZMtt+lRLm/9QycVJfK8wlGreeNpp2aqswmb5
         FetEt6eFY4YxDxviG/mMiIj9QLwISvQ9OHW2I=
Received: by 10.151.106.4 with SMTP id i4mr818877ybm.99.1235037327913; Thu, 19 
	Feb 2009 01:55:27 -0800 (PST)
In-Reply-To: <A3E3A7A0-F03F-4C8B-B3F8-756B0E89798C@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110655>

2009/2/19 Wincent Colaiuta <win@wincent.com>:
> El 19/2/2009, a las 10:21, John Tapsell escribi=C3=B3:
>
>> Hi,
>>
>>  I often do   'git rebase -i HEAD~10'  to rebase.  Since afaics it
>> doesn't matter if you go back 'too far' I just always use HEAD~10 ev=
en
>> if it's just for the last or so commit.
>>
>>  Would there be any objections to making  'git rebase -i' default to
>> HEAD~10  or maybe 16 or 20.
>
> Sounds awfully arbitrary and counter-intuitive to me.
>
> Take a sample of Git users who know what "git rebase" does and ask th=
em what
> they intuitively think "git rebase -i" without any additional argumen=
ts
> should do; I'd be _extremely_ surprised if they answered that it shou=
ld
> default to HEAD~10, HEAD~16, HEAD~20, or HEAD~N for any N.
>
> (I could tell you what my intuition tells me, but I don't think it's =
very
> interesting.)

It doesn't really matter if the user manages to guess what the number
N is, just that it's "recent commits".

If a sample of git users would expect "git rebase -i" to let you
rebase the last few commits, then it doesn't really matter all that
much what N is.  10 seems a reasonable default as any.

John
