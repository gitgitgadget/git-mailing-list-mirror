From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH 0/3] pretty: format aliases
Date: Mon, 26 Apr 2010 22:14:21 +0100
Message-ID: <1272316461.5368.4.camel@walleee>
References: <1272210175-20484-1-git-send-email-wmpalmer@gmail.com>
	 <20100425194800.GB14736@coredump.intra.peff.net>
	 <20100425220955.GA25620@progeny.tock>
	 <20100426172235.GA626@coredump.intra.peff.net>
	 <20100426175707.GB11022@progeny.tock>
	 <20100426180731.GB4012@coredump.intra.peff.net>
	 <20100426183755.GC11378@progeny.tock>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com,
	Cheng Renquan <crquan@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 23:14:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6VdZ-0003oV-8U
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 23:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855Ab0DZVOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 17:14:33 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:50887 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816Ab0DZVOc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 17:14:32 -0400
Received: by wwb22 with SMTP id 22so793045wwb.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 14:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=C0/9cXgnEtRBsgu6JOG5J2xtStMmrvoXIr6x4omuu3A=;
        b=T0/sIIq2eAD6RDAGZcq+oC4/Hqqlu2ax2Pcrql/HtOCdGNVPwxcew4E1ERFRM32C5V
         xNgDxZXCZwXl3va2c/eUwQy7KmqIh8tsjjru3jDi7A72NjJ6bY5+vOZZuKXF3AvhhVO0
         NJ5uEoN05ljI3gQo2IsuAAEBb9oj3tOIAaBw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=cl1NrKg2Rr3j1IvN45VDnl1C0mZCgtasL2XdiCmzCyFplVcnbkaCNUcdvFzUdvZLCS
         xXQ9QDByyb3AKTsQMDWBX/oV7QLGJCATT9TtgM8DIEbXW+CjcC/vxLMCL5GArQGvHcqX
         dRN+qkECKzVw2h7AWIDqF7lBigiaOSslv8gpg=
Received: by 10.216.90.21 with SMTP id d21mr695614wef.159.1272316471196;
        Mon, 26 Apr 2010 14:14:31 -0700 (PDT)
Received: from [192.168.0.4] (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id z3sm1319959wbs.22.2010.04.26.14.14.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 14:14:30 -0700 (PDT)
In-Reply-To: <20100426183755.GC11378@progeny.tock>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145855>

On Mon, 2010-04-26 at 13:37 -0500, Jonathan Nieder wrote:
> Alternatively, we could use
> 
>  [logformat]
> 	changelog = ...
> 
> which is arguably just as clear and may be closer to existing
> practice.  But really, I am happy as long as the configuration exists.
> 
> Jonathan

I like the one-level-of-hierarchy thing ([format "pretty"] is ugly for a
number of reasons), but two problems with that specific name:
 - it says "log", while this effects more than the "log" command
 - it says "format", while this doesn't effect --format.

[pretty]
    changelog = ...

is not taken, and my only hesitation there is that some other config
option may want to be there. Still, it's what I'll call it in the next
version of the patch, unless there are specific objections. (which I
certainly may have already missed, as I've just switched mail clients
twice today)

-- Will
