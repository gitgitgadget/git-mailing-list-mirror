From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/3] pretty: format aliases
Date: Mon, 26 Apr 2010 17:00:49 -0500
Message-ID: <20100426220049.GA15903@progeny.tock>
References: <1272210175-20484-1-git-send-email-wmpalmer@gmail.com>
 <20100425194800.GB14736@coredump.intra.peff.net>
 <20100425220955.GA25620@progeny.tock>
 <20100426172235.GA626@coredump.intra.peff.net>
 <20100426175707.GB11022@progeny.tock>
 <20100426180731.GB4012@coredump.intra.peff.net>
 <20100426183755.GC11378@progeny.tock>
 <1272316461.5368.4.camel@walleee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com,
	Cheng Renquan <crquan@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 00:00:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6WLW-0001SL-8S
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 00:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635Ab0DZV75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 17:59:57 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41613 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab0DZV74 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 17:59:56 -0400
Received: by pvg2 with SMTP id 2so743886pvg.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 14:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7J2ivBpqK+SCAMz5dUxEalJ1OnXtDDSWO7suar0k+TE=;
        b=mjkoM1BKt454WKReP7wn0k4i4QRE3mZnEJwusB1BUr8/sFEtxXSGIGW/Iee91dENQu
         O3z+/a9rroBPbHj6gUWVe/CWEX+oyxVEV6aWCWydPMD0ZwKkpfWh4XiziPRx5VepVGcT
         smcHXmxFMHE3LxincbRoVGp5P425tO4Bp5OWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lS6THDmVDp+lSsKyu1WetlSvo46FMNZaplemK6V3eR09B8cUcE+WAFic/xkDDdvNA9
         6ICACQNcOlVIETGc0c/RNsvw8paJ362Ro96YcV9yj9HzSOtRcD4ou4hhlX9b60eLww5S
         7nLwgbINtPgxPHa+H8kLn+p1WCkXfy1k5hSuE=
Received: by 10.115.115.39 with SMTP id s39mr1347518wam.119.1272319195322;
        Mon, 26 Apr 2010 14:59:55 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm3396938iwn.3.2010.04.26.14.59.52
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 14:59:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1272316461.5368.4.camel@walleee>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145857>

Will Palmer wrote:

> [pretty]
>     changelog = ...

Fine by me. :)

> On Mon, 2010-04-26 at 13:37 -0500, Jonathan Nieder wrote:

>>  [logformat]
>> 	changelog = ...
[...]
> I like the one-level-of-hierarchy thing ([format "pretty"] is ugly for a
> number of reasons), but two problems with that specific name:
>  - it says "log", while this effects more than the "log" command
>  - it says "format", while this doesn't effect --format.

Ah, but it does affect --format.  When Nanako wrote commit 3a4c1a5
(Add --format that is a synonym to --pretty, 2009-02-24), the new
option made me very happy.  And since then it has remained a synonym.

Cheers,
Jonathan
