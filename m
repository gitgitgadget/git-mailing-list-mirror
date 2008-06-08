From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [PATCH] A simple script to parse the results from the testcases
Date: Sun, 8 Jun 2008 19:30:25 +0200
Message-ID: <bd6139dc0806081030i32266a2n633f7679f4a02bb@mail.gmail.com>
References: <1210584832-16402-3-git-send-email-srabbelier@gmail.com>
	 <1212884291-13847-1-git-send-email-vmiklos@frugalware.org>
	 <bd6139dc0806071734h16aa4218md051fbbe9f025f43@mail.gmail.com>
	 <20080608004928.GG29404@genesis.frugalware.org>
	 <bd6139dc0806071756k331c9b29obc5f1cb525ef47d8@mail.gmail.com>
	 <20080608022656.GH29404@genesis.frugalware.org>
	 <bd6139dc0806080443g64403fa4o855809b70e367f0@mail.gmail.com>
	 <alpine.DEB.1.00.0806081826570.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org,
	dsymonds@gmail.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 08 19:31:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Oji-00025Y-64
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 19:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbYFHRa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 13:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753579AbYFHRa3
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 13:30:29 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:24756 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbYFHRa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 13:30:28 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1751937wfd.4
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=Jxlp3PPRALtJXefUzbPaRRboSRN07k20PWdr4hiBvdI=;
        b=m21o4gseAdrtn2mTE5wUx2X+2SsRnrTr+0SycCTOD983JKGMO6k1KYhZ4vV1NWxX2J
         0RgNlQ19+unedkLeC+CCyAhytD8Ey54BhB7YIgXZCr54Af+sSPm1tVoLW/BWUu3gqLPe
         IbmRMuwl6tI/2jdDwD6HsYEvMf21AchdbfS1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=VvPv0padojP8LECb6HlPjDuUUoCa+yIYRGdO9nd0p1x4fMqqgWrfdqvrvaHX7SfLbl
         ALk2mFlistc+P6XpUnpwG+fMvv4gY3tYjtb2J3lNu5fAWXbKxjLxwMLSHZmoPkrEBGub
         cj6+LLyV/yEW5Ei8Xm93a6ogdu2mlT8f8jE98=
Received: by 10.142.214.5 with SMTP id m5mr1020730wfg.279.1212946225962;
        Sun, 08 Jun 2008 10:30:25 -0700 (PDT)
Received: by 10.143.41.7 with HTTP; Sun, 8 Jun 2008 10:30:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806081826570.1783@racer>
Content-Disposition: inline
X-Google-Sender-Auth: f2c57ecbb7984817
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84299>

On Sun, Jun 8, 2008 at 7:27 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 8 Jun 2008, Sverre Rabbelier wrote:
>
>> I used the 'show original message' feature, so that I could edit it
>> before applying.
>
> FWIW that's what "commit --amend" and "rebase --interactive" are for.

Hmmm, yeah, but can you change the filename easily with commit
--ammend / rebase --interactive?

-- 
Cheers,

Sverre Rabbelier
