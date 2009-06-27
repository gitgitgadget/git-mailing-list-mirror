From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv7 4/9] gitweb: right-align date cell in shortlog
Date: Sun, 28 Jun 2009 00:27:50 +0200
Message-ID: <cb7bb73a0906271527g60a92daqd20e3c20e2d87842@mail.gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246104305-15191-4-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246104305-15191-5-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906272028.05239.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 00:27:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKgNK-0006Ad-Vk
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 00:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbZF0W1u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Jun 2009 18:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbZF0W1t
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 18:27:49 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:62035 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbZF0W1s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Jun 2009 18:27:48 -0400
Received: by fxm18 with SMTP id 18so325410fxm.37
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 15:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DJqQBH+g7mg9FlikOD8GXnaG3VgEq+27vMLtOEhfQgA=;
        b=OQPFWlQCPQoZzme/saCzA0E8JTBuev2XgepsTwWA07VO0j+41OI6fUKHmfL/g4qq9K
         C+17Zv+OxYEAhLqQ2GAbkmgjdMxtj8jMRE08sQ5SVTeWO+1JsVRSd539Vieya+CE3Hxg
         GiWf8urAIgT8mFeKAONlRXZ/ZYhQml/rVqXCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZzrfNkKL8ilzGmdVB8tH7CwyB5k0bokrw7TFxZrBy/XaMbqrg9T1TIxaB8YEdK/log
         Y2ax6bAd0lwAQJaVtpkDVMzUL8KZw9Yd0KANBgnB/eNMyyVt/cIvoLW2laRPXJCYrBcH
         Qbd/DONrQgoqizGWakalLqWIRP83e+ZOqL3yU=
Received: by 10.204.70.135 with SMTP id d7mr5284712bkj.87.1246141670193; Sat, 
	27 Jun 2009 15:27:50 -0700 (PDT)
In-Reply-To: <200906272028.05239.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122388>

2009/6/27 Jakub Narebski <jnareb@gmail.com>:
> On Sat, 27 June 2009, Giuseppe Bilotta wrote:
>
>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>
> I don't like it. =A0In my opinion it is less readable that way, espec=
ially
> if word wrapping gets involved:
>
> =A05 hours |
> =A0 =A0 =A0ago |
>
> =A05 hours |
> =A0 =A0 =A0ago |
>
> =A0 5 days |
> =A0 =A0 =A0ago |
>
> It is IMVHO a bit ugly.

You might have a point there.

> That aside this is *not complete*. =A0Take a look at 'summary' view.
> You have there 'date' column in 'shortlog' section aligned to the rig=
ht,
> while in 'heads' and 'tags' section it is aligned to the left. =A0Add=
 to
> that "Last Change" column in projects list view (which should probabl=
y
> be aligned to the left, even with this patch completed).
>
> NAK from me. =A0(Alternate stylesheet? =A0Just kidding...)

[...]
>
> On the other hand: it is short and simple.

And totally independent from the rest of the patchset. I'll move it to
the top of the stack, so that the rest of the next iteration can be
applied in batch as soon as it's ready.

--=20
Giuseppe "Oblomov" Bilotta
