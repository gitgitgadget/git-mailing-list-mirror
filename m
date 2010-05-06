From: Adam Brewster <adambrewster@gmail.com>
Subject: Re: [PATCH v2] An alias that starts with "!!" runs in the current 
	directory.
Date: Wed, 5 May 2010 20:05:40 -0400
Message-ID: <n2qc376da901005051705t821b073do178d0261c4e4b2c0@mail.gmail.com>
References: <1273019122.16093.6.camel@ubuntu.ubuntu-domain>
	 <20100505005153.GC25390@coredump.intra.peff.net>
	 <4BE115EF.8010306@viscovery.net>
	 <20100505070131.GA11265@coredump.intra.peff.net>
	 <19425.9169.537598.876589@winooski.ccs.neu.edu>
	 <7v1vdql4c9.fsf@alter.siamese.dyndns.org>
	 <19425.54504.163875.379151@winooski.ccs.neu.edu>
	 <19425.58290.42871.986460@winooski.ccs.neu.edu>
	 <1273098179.723.10.camel@dreddbeard>
	 <7vpr19j4ng.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: wmpalmer@gmail.com, Eli Barzilay <eli@barzilay.org>,
	Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jared Hance <jaredhance@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 06 02:05:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9ob7-000542-GM
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 02:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227Ab0EFAFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 20:05:44 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:35932 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133Ab0EFAFn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 20:05:43 -0400
Received: by bwz19 with SMTP id 19so205581bwz.21
        for <git@vger.kernel.org>; Wed, 05 May 2010 17:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=sKo1YOosJRlozM9+8Ubizm9/z0/Z2WOFvF8kCuWSUYs=;
        b=AdebuHicDAI3WVyEfHZpJJbQ0hlO6Zg3QmdAN3TCCqHW9u/HS6fvsMoRtSczYQWvO7
         TgYpzV7+GSL6XA1IlMKGjeLfNTlvSdRgAv6BpoFNF6rWFSUByf63MRV7F/8GpUeHbfYG
         nlWyZte0s7n6VeiQ3oDlopNHBLcaZGPRgCSNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=whdfCGXkzkH+tl4uhnTiIq3f05hQpm4ljzAE6b1FUqBRIdo6z0x7No6BFG5yJTGi61
         ESoDS7hZtuRTQ3jxhc6PevrFnJwHlsdix+7ufOHuB8ZXDnTBLBfg9vlkAzdON58batBG
         j1RwZyEQDt47kv0n1LpX/lPvzToZNoRTXBfXQ=
Received: by 10.204.32.201 with SMTP id e9mr310865bkd.47.1273104340770; Wed, 
	05 May 2010 17:05:40 -0700 (PDT)
Received: by 10.204.71.20 with HTTP; Wed, 5 May 2010 17:05:40 -0700 (PDT)
In-Reply-To: <7vpr19j4ng.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146430>

On 5/5/10, Junio C Hamano <gitster@pobox.com> wrote:
>
> It probably is a good idea to switch aliases to start at the $cwd in 1.8.0
> (or perhaps one major release after it), and using a notation that is more
> descriptive, something like "!(cwd)" vs "!(root)", may give us a better
> transtion strategy than casting cryptic "!!" in the stone.
>

For what it's worth, I like "!cmd".

Would it be good enough to set some environment variables?

    [alias]
    command_in_cwd = "!cd $GIT_CWD; ..."

Adam
