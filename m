From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: In-depth git blame?
Date: Mon, 7 Mar 2011 18:20:56 -0500
Message-ID: <AANLkTimLf1gS03j4p7G3CKQWJC-b+_+T=ktaZ5xcJtZc@mail.gmail.com>
References: <AANLkTi=694NiUMzcHkNZ09sotcoN+=wPMnxnom5_ex+f@mail.gmail.com>
 <20110302211545.GD20400@sigill.intra.peff.net> <20110302212951.GB24660@m62s10.vlinux.de>
 <20110302213437.GG20400@sigill.intra.peff.net> <20110302214445.GC24660@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jez <jezreel@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>, git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 08 00:21:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwjjv-0007bB-UM
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 00:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756612Ab1CGXVS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Mar 2011 18:21:18 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51362 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756498Ab1CGXVS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Mar 2011 18:21:18 -0500
Received: by fxm17 with SMTP id 17so4617012fxm.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 15:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=26h5cwBzX6aUmuj1Ab3YcmhpqmsPhONtcFaarboa0zY=;
        b=D+uyForsICCmo0ka0SuAb7lVRyEumD6WxsET+ohbRDcEdJQrfPm0Jw6w46oxp85u+U
         eE3MeG0SJcmMcYj2jVrrxlYPJKqMmAO0TrUygdHCSfRhD8oa8iYSaPsQsbq5Ci+7z8c3
         QI511nbIc31MKNxHy196iW4DlcjrnJM10BJPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=J4N8V8F4BYP8zEcxPJAZNp4FJfX+tJWnolZkHovPAEsMxhDPZPwwHKHN9W84SCOl0J
         iohehvXR9nEX7FiXlW60/EuGYridscJY7cIT0zC/+vYP4vlrem1TeyOUmSvoLutW5so3
         lSsMYtZGB1OHhJXYkMSlgrJtRQh8IqbkfZi6k=
Received: by 10.223.112.131 with SMTP id w3mr3230743fap.43.1299540076938; Mon,
 07 Mar 2011 15:21:16 -0800 (PST)
Received: by 10.223.98.199 with HTTP; Mon, 7 Mar 2011 15:20:56 -0800 (PST)
In-Reply-To: <20110302214445.GC24660@m62s10.vlinux.de>
X-Google-Sender-Auth: T1rYtMHMYFoP2zW6kpigwNsUBGk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168619>

On Wed, Mar 2, 2011 at 16:44, Peter Baumann <waste.manager@gmx.de> wrot=
e:
> [ Cc Jonas, because he might know more about that ]

=2E.. although he arrives late in the discussion.

> On Wed, Mar 02, 2011 at 04:34:37PM -0500, Jeff King wrote:
>> On Wed, Mar 02, 2011 at 10:29:51PM +0100, Peter Baumann wrote:
>>
>> > Hm. I guess pressing 'B' will blame the parent commit in tig. =C2=A0=
But I
>> > can't figure out how to navigate back to the old commit (before
>> > pressing 'B')? =C2=A0Any hints appreciated!
>>
>> No, it is "," (comma) from the blame viewer in tig to blame starting
>> from the parent of the blamed commit of the highlighted line.
>>
> Thx, I didn't know that. Your help is really appreciated!

Pressing 'B' in the blame view reloads the blame view based on the
line/commit, which is currently selected. And as Jeff points out ','
reloads based on the parent of the current commit.

Tig is very poor in terms of history (search, blame, commit) so
there's is no 'back' button.

--=20
Jonas Fonseca
