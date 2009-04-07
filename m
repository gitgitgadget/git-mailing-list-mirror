From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH RFC 6/6] send-email: Remove horrible mix of tabs and 
	spaces
Date: Tue, 7 Apr 2009 23:44:31 +0200
Message-ID: <9b18b3110904071444g2a8c4b66l9c22bd5ffabe3d6a@mail.gmail.com>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-2-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-3-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-4-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-5-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-6-git-send-email-mfwitten@gmail.com>
	 <9b18b3110904071435p320e5d1dh16061d04a3a8ab57@mail.gmail.com>
	 <b4087cc50904071442ka298564x52112c1eac9ac284@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 23:46:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrJ7T-00008S-Kj
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 23:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756622AbZDGVof convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 17:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbZDGVod
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 17:44:33 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:42071 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbZDGVod convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2009 17:44:33 -0400
Received: by qw-out-2122.google.com with SMTP id 8so3225079qwh.37
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 14:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kSFToWvsfg1R/Mj8NIGqqWAonXRlUZO54eNDSsdEiwg=;
        b=j6UPRidTX3bTSPcyjYDdpv6yJcExWtpIWNNYOnGXQUMWo9EZP6uvRFZg9hFunNE4XI
         yuSlM9jLuCMVWKdDLhPWpJATodgBc8Zn7AtPqgF71ATHLDt3IfcbG5ReGPOcERGTcVsx
         prv6JpTzL0kFGipzEyFF89oPbokC46wPDt5ng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XLyjeE77KXb1JvwzT/3bVRDo/qnK21/XS2J8YkJAzyTQL4aXsmDJ8HlbMSC7M+kpuB
         lg5X1FwJG2zb2q2+GBgHAb6BvlmCYIiq+/JRCvQjUfenq2aDR+uNGmjP0ndtEKu2iL69
         7M2X4BEGhsenIw1f7xQDtR6AO8EwQXz4irQgg=
Received: by 10.231.15.74 with SMTP id j10mr207176iba.10.1239140671377; Tue, 
	07 Apr 2009 14:44:31 -0700 (PDT)
In-Reply-To: <b4087cc50904071442ka298564x52112c1eac9ac284@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115997>

2009/4/7 Michael Witten <mfwitten@gmail.com>:
> On Tue, Apr 7, 2009 at 16:35, demerphq <demerphq@gmail.com> wrote:
>> 2009/4/7 Michael Witten <mfwitten@gmail.com>:
>>> +## WARNING! ACHTUNG! ATTENTION! ADVERTENCIA!
>>> +## =A0 Currently, this file uses tabs (like the rest of git source=
) to
>>> +## =A0 delineate code structure. Do NOT under any circumstances mi=
x tabs
>>> +## =A0 and spaces across lines that share a relationship in terms =
of layout.
>>> +## =A0 In fact, it would currently be best to use only tabs, so pl=
ease set
>>> +## =A0 your editor(s) accordingly. This code is already trashy eno=
ugh. Please
>>> +## =A0 don't make it worse.
>>
>> Perltidy the file?
>>
>> Yves
>
> Oooh, that's sexy!
>
> I'll have to give that a try. However, I've been entertaining the ide=
a
> of rewriting the whole thing anyway; it's in need of much more than
> reformatting.

Yes. I notice evilness in there. Not necessarily dire burn your house
down evilness, but evilness none the less.

> As a side note, Yves, I sent the patches to perl5-porters again about
> 1.6666666 hours ago, but nothing seems to have come through; I'll try
> again later.

You mean the 14 patches I just applied and pushed to blead?

:-)

cheers,
Yves



--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
