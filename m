From: Ben Tebulin <tebulin@googlemail.com>
Subject: Re: Reproducible, corrupt packfile after fresh git-svn checkout message
Date: Thu, 08 Aug 2013 18:36:51 +0200
Message-ID: <5203C923.8060905@gmail.com>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de> <f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost> <877gfw4byx.fsf@linux-k42r.v.cablecom.net> <262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost> <87fvuk2wl0.fsf@linux-k42r.v.cablecom.net> <9aa1672d5c04994f416dccd84b5983c960c0fdf9@localhost> <vpqli4cfhhe.fsf@anie.imag.fr> <813506281f7a4d3a8af650c5f8ee33dd7224f193@localhost> <vpqfvukfgr5.fsf@anie.imag.fr> <edc9f41b4ffca9ce36dc50e749de7a86e4618a0e@localhost> <87fvuk1cyl.fsf@linux-k42r.v.cablecom.net> <5203B100.30008@gmail.com> <87txj0i4mc.fsf@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Ben Tebulin <tebulin@googlemail.com>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <stefanbeller@googlemail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Aug 08 18:37:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7TDH-0005l7-25
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 18:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758011Ab3HHQg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 12:36:56 -0400
Received: from mail-wg0-f54.google.com ([74.125.82.54]:53104 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757990Ab3HHQgz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 12:36:55 -0400
Received: by mail-wg0-f54.google.com with SMTP id e12so2729362wgh.21
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 09:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=LkvTYRcRCmC6TzFxDGTZK6ynr1eN3/J3GawEyoJcO1k=;
        b=r4SGLaVXWaOFsUR0IZt4qGT48O3usb2qQTVnslTbiBULY2Y8TNjTXxlazu3c/ugPwb
         1degqg1oEdZ5H1fH8w1nU/8RP2vDjIGzTJlICAKtake/6YSheqa3goooOKnfHFchFhF8
         00/d1GNy/EWiWSQ5rKHC3vE8abgP0/NbY2g/lls7cHy4Zw9It3aUnF9UdA6h2O35NnOf
         mNVzXqPjRFacpbPdCv8AUz4GP5oWL1emogNWUet9v9xkby4h2aNFUQJmG0NM6Tkgah14
         LYTmHIUGvS2Koat62ehHKate9AToF3FUiZJcRirysz1kYOiCtNzrEsIcEQGptASrd6TQ
         MoIA==
X-Received: by 10.194.201.202 with SMTP id kc10mr3990143wjc.1.1375979814061;
        Thu, 08 Aug 2013 09:36:54 -0700 (PDT)
Received: from [127.0.0.1] (ulmg-5d845c5c.pool.mediaWays.net. [93.132.92.92])
        by mx.google.com with ESMTPSA id nb12sm18880976wic.7.2013.08.08.09.36.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 09:36:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <87txj0i4mc.fsf@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231900>

I was unable to reproduce the error with the same repo and same Git
version on a different machine (Debian Squeeze x64 on a AMD Phenom x6
1045T).


> I'm running out of ideas.
Me, too. Based on out current observations I'd assume one of:

a) a rare, timing-sensitive bug in Git
b) a compiler/distribution/environment sensitive issue
c) or defect/buggy Hardware (CPU, Memory)

> Hrmm.  I wonder about the significance of those 39MB.  What is your
> core.packedGitWindowSize?  (Judging from the pastes you seem to be on
> 64bit, so the default would be 1GB.)
The default. I have 12GB RAM.

So I'll try to rule out b) and c) as far as I can and report in if I
have any new findings.

Nevertheless thank you very much for your extensive assistance!

- Ben
