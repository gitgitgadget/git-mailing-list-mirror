From: demerphq <demerphq@gmail.com>
Subject: Re: Gnome chose Git
Date: Thu, 19 Mar 2009 22:51:01 +0100
Message-ID: <9b18b3110903191451u56bbee7biac3a1fee4a36b71d@mail.gmail.com>
References: <877i2lbvt7.fsf@iki.fi>
	 <1cd1989b0903190643p19a40718yc4fd2730aab0a9a0@mail.gmail.com>
	 <49C24D9B.1060301@drmicha.warpmail.net>
	 <1cd1989b0903190701uac4602dl1d2c3cace45a9938@mail.gmail.com>
	 <20090319151610.GO23521@spearce.org>
	 <1cd1989b0903190850p1a08991y754904e7799c7879@mail.gmail.com>
	 <20090319201405.GD17028@coredump.intra.peff.net>
	 <9b18b3110903191440w20ca9801pfb218cc4b10ea769@mail.gmail.com>
	 <20090319214317.GU23521@spearce.org>
	 <20090319214432.GV23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:52:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkQAH-0007U1-KJ
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 22:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757371AbZCSVvJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 17:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756874AbZCSVvH
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 17:51:07 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:38985 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756504AbZCSVvE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 17:51:04 -0400
Received: by yx-out-2324.google.com with SMTP id 31so725502yxl.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 14:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Z6YBBpwmgOi96s/1HZU5QKqmPAmZzyiqCdRHx8282O4=;
        b=i6sxUg0q6f4fcHH0Q3JUygwmj90xUe0hk9pz7Sjy+pKc3nmMV5irgavokQDZzCYv1R
         DxPGw7bZ5KXQmnkO8UjZ5FndhbARz9RLstfpvdnW9OodZYAPWqiKOLhWZBuUenxfcioZ
         e7caeHrhuPKeoVzPk0fRH1pKANJOszBynHE0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=i4SO/V47jVfrxtVlglpYvXmIaa3EzjiG2QZn0iRg0GoY2BEj6osFa+l8rc2dr2Cp8o
         T0SI5Qesrgg2xyy+TfyMLIBNmPlGBsGB2N3i3++MNonql1aL8dcR5YTjZeJMDHqKZsuu
         VnAhFthU76LBcdwHs4sUAgaIO+/f8TXOoT1As=
Received: by 10.231.15.130 with SMTP id k2mr962730iba.31.1237499461968; Thu, 
	19 Mar 2009 14:51:01 -0700 (PDT)
In-Reply-To: <20090319214432.GV23521@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113839>

2009/3/19 Shawn O. Pearce <spearce@spearce.org>:
> "Shawn O. Pearce" <spearce@spearce.org> wrote:
>> demerphq <demerphq@gmail.com> wrote:
>> > Outside of parsing the reflog directly, (which feels wrong and dir=
ty
>> > to me), how does one find out the times that a reflog entry was
>> > created?
>> >
>> > The closest thing i could find was git log -g, but that shows the =
time
>>
>> =A0 git reflog -g branch@{now}
>
> Arrgh, I of course actually meant
>
> =A0 =A0git log -g branch@{now}
>
>> the @{now} suffix is the magic to make it show the time.

Ah! Much nicer! Thanks.

Is there by any chance any way to set the date format it uses to
something more suitable for machine processing?

Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
