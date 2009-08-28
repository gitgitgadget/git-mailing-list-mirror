From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 19:00:59 +0200
Message-ID: <81b0412b0908281000l41c862f9ye52da7251014c4f7@mail.gmail.com>
References: <4A97193A.8090502@facebook.com>
	 <20090828060538.GA22416@coredump.intra.peff.net>
	 <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
	 <20090828150212.GA6013@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 19:01:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh4p1-0005lz-7f
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 19:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbZH1RA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 13:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbZH1RA6
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 13:00:58 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:58282 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbZH1RA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 13:00:58 -0400
Received: by bwz19 with SMTP id 19so1721022bwz.37
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=SFZnyv8bL1Kynk5BWG4ClKeihpTN2z9tDttMxoCmmAQ=;
        b=tPCbgitbTkvP6+uhhbQPAxUzDC09ARMfPfeQMMGg6TclPkJ4XlkrX6wS5ZwqLvpe1u
         Z4achEWhPNSBO3vVCMTEUFOSCvfaXSGmY5wFxwwibsobQw2ZC6C/6pbyW4aqUK3WAW2h
         cm3AiDbvCTEPlSIrzi8pXNVa5oeOfbOgB3TqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VEzEWWV7huTv09BfgCQog7Q9hGHFXTOtQT2n5/o93ZAdKeF7np6peSfb1AZhcqPcpg
         lh2jzlGoVSB+7m91O9vXwA7ra4SvThhKGZXfOHIt1sjH8NJ6FrJNRbtTFGP9usqVrq0X
         DEwBl4YB101L/zOS2ywUmMbK6esXno27oEh58=
Received: by 10.204.152.204 with SMTP id h12mr1119801bkw.97.1251478859230; 
	Fri, 28 Aug 2009 10:00:59 -0700 (PDT)
In-Reply-To: <20090828150212.GA6013@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127314>

On Fri, Aug 28, 2009 at 17:02, Jeff King<peff@peff.net> wrote:
> But that's the point: you can't do that without a race condition. Your
> test gets a sense of the current time, then runs git, which checks the
> current time again. How many seconds elapsed between the two checks?

How _many_ do you need?
