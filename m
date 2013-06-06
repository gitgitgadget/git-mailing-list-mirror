From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Thu, 6 Jun 2013 02:46:59 -0500
Message-ID: <CAMP44s3zuDPTApPvnaC0bzqmAUkRRwePZDRL4syB=tM3d6eiBA@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<CAMP44s012ccmaArrTbfy_xNrqbnOjVGTnY+po9cE8JGh_U72Gg@mail.gmail.com>
	<CANgJU+W1BLOB_TuMa_zRHtCW-8Ge8nu_kK=5qu2xDY=Km_kk4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 09:47:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkUuZ-0007HD-6M
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 09:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757889Ab3FFHrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 03:47:03 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:51103 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499Ab3FFHrB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 03:47:01 -0400
Received: by mail-lb0-f182.google.com with SMTP id r11so1712079lbv.13
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 00:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UE56fZ0KN/sAbkplnY8+/msTUil9vLIi5y3TeEk3bCA=;
        b=wNTpv+74426wZrMcGnaC+0gJiChqm9bpz11grK6e62TnoMTXjrYv94Z8NlVg5FRVA+
         3k2aCNBASiW12DOwHoBINVGumo2Ka+OaDUiOm+K7uvod3BbB5oMKCTfJSIOtNRfAIgs1
         YGlXTGvFYMuTVcgi37MlHX7UayMMup3efZo/KRcyjPKR8ZN4tlxnWil1/j6/dgDyN6Mm
         xstosGRJfGVcFehKrQotaa/h5z4yzJ6DG4zV9nTFBG5CMMD5dyfgSzW/dPyn3RMiWt+6
         C7ElPp8bEDBteSJq9NJItbLHvoW3++FYCVq9YC1URXgESF+ray9kpBPk+zw+I5Jphfrt
         70Uw==
X-Received: by 10.112.132.66 with SMTP id os2mr10745177lbb.118.1370504819824;
 Thu, 06 Jun 2013 00:46:59 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Thu, 6 Jun 2013 00:46:59 -0700 (PDT)
In-Reply-To: <CANgJU+W1BLOB_TuMa_zRHtCW-8Ge8nu_kK=5qu2xDY=Km_kk4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226485>

On Thu, Jun 6, 2013 at 2:26 AM, demerphq <demerphq@gmail.com> wrote:
> On 5 June 2013 16:45, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> On Tue, Jun 4, 2013 at 7:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> That might make sense for the shorter term, but in longer term I see
>> Perl as declining in favor of other languages. It's only a matter of
>> time before Ruby surpasses Perl in popularity, and soon enough new
>> contributors to the Git project will have problems trying to improve
>> Git because parts of it are written in a language they are not
>> familiar with, and have trouble learning (isn't that already
>> happening?).
>>
>> The Ruby vs. Python is another question altogether, I could go into
>> detail about why I think Ruby is a better choice, but my point right
>> now is that Perl is not a good choice for the future.
>
> Good thing you are being objective and leaving out the Python 3.0
> mess, the long legacy of backwards compatibility in the Perl
> community, the active community behind it, its extensive portability
> support, and fail to mention the lack of an equivalent to CPAN. We
> wouldn't want facts to get in the way of a personal bias would we?

None of that has anything to do with Perl's popularity.

> Just thought I'd push back on the FUD. People have been saying Perl is
> going away for decades...

Perl has been going away for the last decade [1], and will continue to
go away. Perl is going away, and that an undeniable fact, and if you
are not interested in discussing on the basis of reality, I'm not
interested in discussing with you.

[1] http://www.tiobe.com/content/paperinfo/tpci/images/tpci_trends.png

-- 
Felipe Contreras
