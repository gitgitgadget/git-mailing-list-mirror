From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 01/10] refs: add "for_each_bisect_ref" function
Date: Thu, 26 Mar 2009 13:37:14 +0100
Message-ID: <fabb9a1e0903260537r61647d82t4ffb6b8b67d5c2f1@mail.gmail.com>
References: <20090326055509.1bc16b28.chriscool@tuxfamily.org> 
	<fabb9a1e0903252320j2edf4a8ct39f784c4319c3cb0@mail.gmail.com> 
	<200903260848.42104.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 26 13:39:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmorP-000762-4B
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 13:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034AbZCZMhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 08:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753610AbZCZMhd
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 08:37:33 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:38061 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbZCZMhc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 08:37:32 -0400
Received: by mu-out-0910.google.com with SMTP id g7so234072muf.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 05:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8U6zAiFHaCPsKiDbD0f6QHs1TH0lpWZAkh192PRTOM8=;
        b=pPA9wJAyfxyNB54hy64ZIufDieaA+4PPPwp7sM8N/susNa6SKypXzX3jQMb3b6ILGF
         rUXNFudeAM86m7pZElq86hgtYo7f6NPQFX/D1aCMeULFFeSb856VByjhbQchwIoPVsvj
         wSR7B83npXEYNbmSHGyIPY1ry8GGA6vjjY1vc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nylxDDIQnvNPJIH+qGsrAMDCdyuRHsFbhBNepPPVuAsjC9tKXR36GyzxYyoTwDeflw
         9qhKOkAs+o8R1gSRSB2ncaz/AeeLAYSy5iXeFSwuCKMF01KMmCmGA+zRWGJ6o9f0Hv+q
         jOO+ctHLtIl5hlT7D5ht+14SgrKiLZM2p1DNw=
In-Reply-To: <200903260848.42104.chriscool@tuxfamily.org>
Received: by 10.103.173.15 with SMTP id a15mr379070mup.59.1238071049227; Thu, 
	26 Mar 2009 05:37:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114772>

Heya,

On Thu, Mar 26, 2009 at 08:48, Christian Couder <chriscool@tuxfamily.org> wrote:
> I am not a big fan of cover letters. Usually I prefer adding comments in the
> patches.

The downside of that is that it makes it harder to quickly scan the
series; now I have to go through each patch (which involves trying
finding which patch is next, as my MUA is retarded and doesn't
understand proper threading).

>> And no description of the
>> individual patches either!
>
> There is a commit message in each patch. And many of the patches are very
> small.

Hehe, my bad; the first one didn't have a commit message, which is the
one I looked at first.

> If some commit messages are not clear enough, please tell me and I will try
> to improve them ;)

The rest of the series is nicely readable, I guess I shouldn't send
whine mails before reading the entire series next time :).

-- 
Cheers,

Sverre Rabbelier
