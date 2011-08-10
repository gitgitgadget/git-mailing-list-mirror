From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] Sequencer: Thoughts on future work
Date: Wed, 10 Aug 2011 06:54:32 +0530
Message-ID: <CALkWK0knHdnioFs7CmeM0VvwqQB6T-tOK7Nb0zrr3bbhLs+gGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 10 03:25:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqxXY-0005Nv-If
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 03:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563Ab1HJBYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 21:24:54 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35889 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab1HJBYx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 21:24:53 -0400
Received: by wyg24 with SMTP id 24so381068wyg.19
        for <git@vger.kernel.org>; Tue, 09 Aug 2011 18:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=RU1PGOwjEx7GT0SGEj70TVOXrhzkJunOe4RBnVIIuzE=;
        b=KOie48kOvPAfezthH6k23q01ZlfyEb+9B6PGGIvv4Copw7BXlgsH7Tl1hkNdpldx+z
         p4fQYkOC7DDQYtv2tFrmFBFE29OzB0bjBPnrauxIoubm+U8GDhxf1rKfzUNdbnzKz7yv
         0A9wS19CktXuf98TC7wAULaabHTWftGV0xM2Y=
Received: by 10.216.188.207 with SMTP id a57mr5772528wen.94.1312939492077;
 Tue, 09 Aug 2011 18:24:52 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Tue, 9 Aug 2011 18:24:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179052>

Hi,

It looks like rr/revert-cherry-pick-continue (also referred to as
sequencer-stable in other places) is doing well, but there's just
another week before the end of the SoC.  From my experience of working
on the new series, sequencer-stable lays a good foundation to make
future work really easy; it especially makes it easy to split up work
into tiny bits, so that a huge tangled-up series won't be required.
However, even in the best case, I can only get a few reviews and
iterate over my new series a few times before the end of the SoC.
I'll post a mini-series asking for comments soon.

Also, I suspect that academic pressure will be significantly lower
since this is my final year in college.  I hope to write a few more
features into the sequencer, and pursue lots of new problems this
year.

Thanks for reading.

-- Ram
