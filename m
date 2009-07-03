From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: what's the current wisdom on git over NFS/CIFS?
Date: Fri, 3 Jul 2009 12:07:47 +0530
Message-ID: <2e24e5b90907022337k55b9c984rf3b5a985283e18e4@mail.gmail.com>
References: <slrnh4pcf8.484.sitaramc@sitaramc.homelinux.net>
	 <alpine.LFD.2.01.0907021345440.3210@localhost.localdomain>
	 <2e24e5b90907021752t10243468sc07be88cd88ac5c1@mail.gmail.com>
	 <4A4DA1D6.40301@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 03 08:37:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMcPE-0007bt-Nr
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 08:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbZGCGhr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jul 2009 02:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbZGCGhq
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 02:37:46 -0400
Received: from mail-gx0-f226.google.com ([209.85.217.226]:59919 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbZGCGhq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jul 2009 02:37:46 -0400
Received: by gxk26 with SMTP id 26so3434382gxk.13
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 23:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kZcUAvnnB+FLLg8l8jk5CxAI/UmeYxwwH/duAdd0rUo=;
        b=eZCLnuGnxdgC2eSK7yaJRFjz4iOosFK9NNE5hc1/9W8am47tAWE0FHSockXYCUyCEB
         f67a/YgxPghxPZbU51UzesS3wbCSF9oTsRhVYfPzxv/NAtmZkRMQLyyi4wEsvVW0h9el
         mA0ExrvfqyvULR3czer0lO/FiRTZp8rlC6iZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QSKSQ2mK8ImEnS4UQOIq6CiqTJ4jhSo1SK1N+cyb+Yn/JEEAine37oDPv+fX4usLcE
         cAfrZPwSKVo/W2i9NsSTtRaSx2QKJFHMLAt+sM8UmICc2w47avdZuk5BeUN6ZtcgMXLH
         fSbxjmeDxqrwnVpitC8uSNz4IgE700v8EG4JM=
Received: by 10.231.34.3 with SMTP id j3mr984411ibd.43.1246603069159; Thu, 02 
	Jul 2009 23:37:49 -0700 (PDT)
In-Reply-To: <4A4DA1D6.40301@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122685>

On Fri, Jul 3, 2009 at 11:44 AM, Johannes Sixt<j.sixt@viscovery.net> wr=
ote:
> Sitaram Chamarty schrieb:
>> On Fri, Jul 3, 2009 at 2:28 AM, Linus
>> Torvalds<torvalds@linux-foundation.org> wrote:

[snipped all of Linus' email]

>> Though I asked this following from a debate on IRC, it now looks as =
if
>> this will solve another of my problems too.

[snipped my "Windows story" ;-)]

> I don't exactly understand why your reply with this Windows story to =
the
> fsyncobjectfiles paragraph. But if you think that fsyncobjectfiles+ms=
ysgit

Not at all.  Since I was adding Gitte to the CC, I kept _all_ of
Linus' email quoted to provide him the full context.  My Windows story
pertains in general to the whole email, really.

>> Sounds like we can just do it with traditional Windows fileshares, a=
s
>> long as we make sure no one does a "git gc" on the bare repo that is
>> being shared. =A0That's a very small price to pay!
>
> It will work with the caveat you mention. I have such a setup myself.

And _that_ is what I was hoping to hear!  Thank you!  I can use it and
test it all I like, but hearing the guys who know say "it will work"
makes a big difference.
