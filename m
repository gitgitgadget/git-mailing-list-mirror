From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: [PATCH] Modified the default git help message to be grouped by topic
Date: Tue, 2 Dec 2008 15:39:43 -0800
Message-ID: <d411cc4a0812021539g34d3a94bn7e873f8cf04adc56@mail.gmail.com>
References: <20081201173037.GA41967@agadorsparticus>
	 <20081201183258.GB24443@coredump.intra.peff.net>
	 <7v7i6jqriv.fsf@gitster.siamese.dyndns.org>
	 <d411cc4a0812012210h4cb59974sbda71abd2c64f93b@mail.gmail.com>
	 <885649360812021211u3d547982i8e1c3070972363e8@mail.gmail.com>
	 <alpine.DEB.1.00.0812022353410.27091@racer>
	 <20081202233004.GA22379@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"James Pickens" <jepicken@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 00:41:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7erV-0007rC-Md
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 00:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbYLBXjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 18:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752798AbYLBXjp
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 18:39:45 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:62221 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbYLBXjo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 18:39:44 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1532971wah.21
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 15:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=h26/bPVDZZiyih9psajoAR54tRFTtEpnnvKBFVIM2C0=;
        b=Y3zoT9i8dx8K+g/PiCyvNbFZ5tDSg6bMrQdlUJi/5bvq9Tb4L6NurWPNKF15tMSuzL
         dMusyiK2PqrU2MfIFFWltWtuP+n4W77e7bMZR9/M6MwP3cCcbaycpoHRIQiPtU+twVOQ
         +fIsuT/iZh1RmaMHe8XNvMWhpn+k8yAcEnGpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=uaLqxEqESo9u4Awi7GWB4ICc87yaYuURo5GQENx0KBKdOYYJGW25XBII05K+c4dQHM
         4K1ql2I9ZKKmBiCXb26jCR080Bq+hm4q+ByCVfXRSUgUEZp9DAEAdPbn6gBz/K098NuR
         E6UuL71Q+pOoCjaX2/dHhAgP4GxVVSQsWsF+w=
Received: by 10.114.160.17 with SMTP id i17mr7688894wae.125.1228261183155;
        Tue, 02 Dec 2008 15:39:43 -0800 (PST)
Received: by 10.115.22.20 with HTTP; Tue, 2 Dec 2008 15:39:43 -0800 (PST)
In-Reply-To: <20081202233004.GA22379@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102189>

Hi,

On Tue, Dec 2, 2008 at 3:30 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Dec 02, 2008 at 11:55:03PM +0100, Johannes Schindelin wrote:
>
>> If the whole thing gets longer than 24 lines, we have to leave some things
>> out.  Personally, I consider rm and mv unimportant enough that they could
>> be shown in an extended list, but be left out of the summary page.
>
> For the record, the current output is 26 lines, plus you probably want
> to account for 1 line of the user's next shell prompt. So we are 3 lines
> over already.
>
> Scott's proposal is about grouping the commands more sensibly. Many of
> the complaints are about the length of the output. Maybe we should scrap
> having a list of commands altogether and just point at section-specific
> documentation, each of which could discuss basic commands related to it.

I've always felt it was helpful to newcomers to have that page there
with the couple dozen commands you might use - mostly in case you've
forgotten what the exact command name was.  Hg does something like 'hg
help' which gives you more commands, but I feel like just having the
quick cheat-sheet is generally really helpful.  If someone just wants
to remember what the command 'checkout' was, I wouldn't want them to
have to go to two places - one to look up what the task document was
and then another to view that.

My $0.02

> I think there has been mention of task-oriented documentation pointers
> before, and I think this is a place where we would want it.
>
> -Peff
>

Scott
