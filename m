From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: thoughts on a possible "pre-upload" hook
Date: Mon, 28 Sep 2009 08:32:17 +0530
Message-ID: <2e24e5b90909272002r53b0a82dw9cb52bdc7bbd477@mail.gmail.com>
References: <2e24e5b90909220320rbd5fd1l40c7898656445232@mail.gmail.com>
	 <c376da900909271901q1667ecacw730ba5180a558f3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 05:10:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ms6cq-00042W-Q5
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 05:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbZI1DJ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Sep 2009 23:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbZI1DJ6
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 23:09:58 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:51307 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbZI1DJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Sep 2009 23:09:57 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Sep 2009 23:09:57 EDT
Received: by iwn10 with SMTP id 10so2378941iwn.4
        for <git@vger.kernel.org>; Sun, 27 Sep 2009 20:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nGQwcflzFvLMSA3/LTiHYnU8e64XOsbHSVzdBBxzhJI=;
        b=buSIDgtKyOPPaI4f6DlIL2Waw3m+Y70etxsaWELSbEv15oOq2vHydl+CtLt+h3uhuk
         jZp+tbEKUdq4gELqxbpG9DPYj2+6VACj84onhCWtRXHqewMp+TL8kkBQ05uDQ6SqwY6s
         Lbf0P/WT5XqITtWEiyNtE5AXA3Yme7YzJcSg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sMAp2NFwsTof5vqSZbL3zbztjT73fiYTw0ix31oTpsP2PZuP7ESx8kAlWn4csIakAG
         gbHQEGTv8TM19simj5pGc1RDUSUc3gLyVleytbn1/iqY28IA0F58pZzAepdOBabf0441
         3vubjstQFtrp/E63+Td/c2uMqS7M/RxwhqDMM=
Received: by 10.231.121.69 with SMTP id g5mr5107565ibr.44.1254106937629; Sun, 
	27 Sep 2009 20:02:17 -0700 (PDT)
In-Reply-To: <c376da900909271901q1667ecacw730ba5180a558f3b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129225>

On Mon, Sep 28, 2009 at 7:31 AM, Adam Brewster <adambrewster@gmail.com>=
 wrote:
>> As git is used more and more in corporate-type environments, at some
>> point it becomes convenient to have *branches* (or more accurately,
>> refs) that are not readable. =A0The simplest way to do this (from gi=
t's
>> point of view) is to allow a "pre-upload" hook, rather like the
>> "pre-receive" hook or "update" hook.
>>
>
> What's the benefit of this over using multiple repositories?

Over a long pm chat over irc with Ilari, I have come to the same
conclusion.  I was hoping there would be some administrative
convenience or workflow convenience to doing this, but whether there
is or not is debatable, and even if there is, there are enough failure
modes to make this have a lot of caveats.

--=20
Sitaram
