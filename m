From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: GSOC remote-svn: branch detection
Date: Sat, 4 Aug 2012 23:53:58 +0530
Message-ID: <CALkWK0mu1=NEUZzB1VPAf0DU_nguuq_nJ-9Rn7Pj6zeNfoZGtA@mail.gmail.com>
References: <12682331.q6WHVv9EKU@flomedio> <20120803181728.GA21745@copier>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	David Michael Barr <davidbarr@google.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sam Vilain <sam@vilain.net>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 20:24:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sxj1V-0005rU-9w
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 20:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026Ab2HDSYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 14:24:20 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:63905 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823Ab2HDSYT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 14:24:19 -0400
Received: by qcro28 with SMTP id o28so1051723qcr.19
        for <git@vger.kernel.org>; Sat, 04 Aug 2012 11:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oxdusc2sP0ylHJAv/4tTxd3hcCrTlzKDYjVnWZYVsiY=;
        b=LtJzbcSTBwF3OUjZgjcTUNtZOLG/X/jlmrABqj7ABWz/wDQj5UZfuFBpBwhX6DeGNh
         KPeUKjfiebQMXdDWoUCb8VLYz9zWizliNAylicU0H+xThISC0/MuqRQ5V243AcMFgDb9
         x6ahDMzZm/b/kNrrY/KfgQqKMAeXA3Tx61RibyafPe2XkNkp+3KwL4HC9S41tb8CSbgo
         /jsg7vBn4UT6XEfiM+3P5zynbJERVzrtp36zRiUfPRvTYhWBRMvQaoZS4VxLwZV8I8vz
         4Pjk4+73rCUJo7LSjIJZ8qKufuL5jioHEQQSnVULC0i9wu7bbNj0SCi2wjJzl/RoGUyN
         lMzQ==
Received: by 10.224.52.205 with SMTP id j13mr9242156qag.62.1344104658643; Sat,
 04 Aug 2012 11:24:18 -0700 (PDT)
Received: by 10.49.13.10 with HTTP; Sat, 4 Aug 2012 11:23:58 -0700 (PDT)
In-Reply-To: <20120803181728.GA21745@copier>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202890>

Hi,

Florian Achleitner wrote:
> 1. Import linearly and split later:

I think this approach will be a lot less messy if you can cleanly
separate the fetching component from the mapper.  Currently, svndump
re-creates the layout of the SVN repository.  And the series you
posted last week contains a patch that attaches a note with SVN
metadata to each commit.  Do you have thoughts on how the mapping will
take place?

Ram
