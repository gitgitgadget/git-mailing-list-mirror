From: Jagan Teki <jteki@openedev.com>
Subject: Re: Show total commit count of two authors or more authors into first author
Date: Mon, 7 Dec 2015 11:31:57 +0530
Message-ID: <CAD6G_RRi=UBh9KbmKpALnYQYWwa2BYFxiPCMKEtZpr_dwdeWdw@mail.gmail.com>
References: <CAD6G_RQ2Ub8HasupNbUFK2LJfir25tNFTqrqU2ELoEJHOibzHA@mail.gmail.com>
	<87wpsrz843.fsf@igel.home>
	<CAD6G_RRtH5yBqwrgMxhrSXb++n6CNA2qXcNn+Z2ALSyV8b9ZuA@mail.gmail.com>
	<20151206212016.GA585454@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jagan Teki <jteki@openedev.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 07 07:02:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5ose-0005ug-2S
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 07:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbbLGGCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 01:02:01 -0500
Received: from s159.web-hosting.com ([68.65.121.203]:48806 "EHLO
	s159.web-hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbbLGGCA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 01:02:00 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35831)
	by server159.web-hosting.com with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.85)
	(envelope-from <jteki@openedev.com>)
	id 1a5os2-001mSm-VI
	for git@vger.kernel.org; Mon, 07 Dec 2015 01:01:59 -0500
Received: by lbpu9 with SMTP id u9so11221262lbp.2
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 22:01:57 -0800 (PST)
X-Received: by 10.112.138.135 with SMTP id qq7mr12891528lbb.21.1449468117357;
 Sun, 06 Dec 2015 22:01:57 -0800 (PST)
Received: by 10.25.209.206 with HTTP; Sun, 6 Dec 2015 22:01:57 -0800 (PST)
In-Reply-To: <20151206212016.GA585454@vauxhall.crustytoothpaste.net>
X-Gmail-Original-Message-ID: <CAD6G_RRi=UBh9KbmKpALnYQYWwa2BYFxiPCMKEtZpr_dwdeWdw@mail.gmail.com>
X-OutGoing-Spam-Status: No, score=-2.9
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server159.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - openedev.com
X-Get-Message-Sender-Via: server159.web-hosting.com: authenticated_id: jteki@openedev.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282083>

On 7 December 2015 at 02:50, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, Dec 07, 2015 at 01:45:19AM +0530, Jagan Teki wrote:
>> Thanks for the info, I'm able to map two author with e-mail but it's
>> not working when I group 3
>>
>> $ .mailmap
>> Jagan Teki <a@abc.com> Jagannadha Teki <x@xynz.com>
>>
>> The above worked but how about 3 names mapping
>>
>> $ .mailmap
>> Jagan Teki <a@abc.com> Jagannadha Teki <x@xynz.com> Jagannadha
>> Sutradharudu Teki<p@pqr.com>
>>
>> Finally I need to map all 3 into Jagan Teki <a@abc.com>
>
> You probably want to map two at a time.  So something like this:
>
>   Jagan Teki <a@abc.com> Jagannadha Teki <x@xynz.com>
>   Jagan Teki <a@abc.com> Jagannadha Sutradharudu Teki <p@pqr.com>

I tried this before seems like some more hidden name's with same
author. anyway I found all and mapped the same. Thanks you very much.

-- 
Jagan.
