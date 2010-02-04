From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: rebase vs rebase -i
Date: Thu, 4 Feb 2010 13:10:58 -0500
Message-ID: <76718491002041010k84ad55ct5c3e80529e8f8428@mail.gmail.com>
References: <76718491002032019i5f8ea947paa527988ddb7a378@mail.gmail.com>
	 <alpine.DEB.1.00.1002041414530.4505@intel-tinevez-2-302>
	 <76718491002040914t12956bb2gbe21ae89f31cbc7f@mail.gmail.com>
	 <alpine.DEB.1.00.1002041859000.4505@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 04 19:11:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd6AZ-0007Jt-BO
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 19:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168Ab0BDSLF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2010 13:11:05 -0500
Received: from mail-iw0-f189.google.com ([209.85.223.189]:60925 "EHLO
	mail-iw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab0BDSLD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2010 13:11:03 -0500
Received: by iwn27 with SMTP id 27so1908768iwn.5
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 10:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=s5vFR8II5ZeTTGav7HXggZDnIrzErZH/lKDHql0xHW8=;
        b=sakxWG8N+VIDlKN2tTkTZ7LVXY/tdsMG15H1d8pGXpyaqDI1T/6skOH68XLjbNqwy+
         iyPGGQL1P5Witst9WMheIJ5E7CnI00aiDf94qeQhbcrHlsYEW1KCEQxFz8m2M0FL9pvV
         TIl6hkr/+tGdJ4V2PkeBaxlI+HSV2rIceq1RM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VP5iPTQRUk/t7kgfS6q5i8Hnukp9b22gVy7Ai2Qaabp8yO7wiW+dVNmO4Z2MUPp9SB
         ZGTTGx4K6ZXCf597JHTpzBX3fsmKdZFDUa7ff/OxFX1wZ6VlfJR+Vv1F2VTUzLYp2F2L
         62y/KDyB+S5m9xMwMBoJzR1fqte5PmZorGX54=
Received: by 10.231.148.83 with SMTP id o19mr64873ibv.39.1265307058486; Thu, 
	04 Feb 2010 10:10:58 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002041859000.4505@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138995>

On Thu, Feb 4, 2010 at 1:00 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 4 Feb 2010, Jay Soffian wrote:
>
>> On Thu, Feb 4, 2010 at 8:27 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >> (Here I'm setting GIT_EDITOR=3Dtrue just to demonstrate that I di=
dn't
>> >> change the list of commits in the latter case.)
>> >
>> > You can get _exactly_ the same behavior if you use -m.
>>
>> Or rather, -p. ;-)
>
> No. =C2=A0-p tries to preserve merges, and it will use
> git-rebase--interactive.sh for hysterical raisins.
>
> I meant -m.

I don't understand what you mean by "_exactly_ the same behavior" then.

"GIT_EDITOR=3Dtrue git rebase -i" and "git rebase -p" both use
git-rebase--interactive.sh, and so are exactly the same behavior.

-m still uses git-rebase.sh, but calls merge instead of format-patch +
am. Perhaps the end-result is the same, but the behavior is different.

I guess I'm being a bit pedantic here, but I'm really just trying to
understand what you mean.

Thanks,

j.
