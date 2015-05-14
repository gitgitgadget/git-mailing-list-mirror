From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] asciidoc fixups
Date: Thu, 14 May 2015 14:10:53 -0700
Message-ID: <xmqqwq0aj25e.fsf@gitster.dls.corp.google.com>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
	<xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
	<20150513021556.GA4160@peff.net> <20150513045650.GA6070@peff.net>
	<20150513224131.GC425227@vauxhall.crustytoothpaste.net>
	<20150514042544.GA9351@peff.net>
	<9350a00074264bb847210410a6f6c340@www.dscho.org>
	<20150514173828.GA7966@peff.net>
	<c2fd3e038c821ec340c085a825baabc7@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org,
	David Turner <dturner@twitter.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 14 23:11:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt0PG-0005tB-Ni
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 23:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965295AbbENVK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 17:10:58 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33837 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965291AbbENVKz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 17:10:55 -0400
Received: by igblo3 with SMTP id lo3so19270084igb.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 14:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=BfYr6ND8bc84vPUw/84xbIgM2k2ejYs41bwd9CzVlIc=;
        b=xrOBSb9ZSlVheJZ7CsTCtBcZmoVOJxLHfWavsxox1BaaskCrD4C1qGa1/fAOS574d0
         BELWoeQjKTOWYpqBptdCtzPg0CNyx25nvQbG2lKE0kPsetCjQFD1soP363tyrjjsB6hD
         dnv8XQBnIhc9UhfYo+dtB/Ao8JJbm2iQYHSqdvIWwejkMRPtOW6h7g8NP/DC+iiJqOTw
         3XX+a75oHwjU8imWM13hjlPG2fZPLX1TzXWRW8BQ95vP/wvrrDIVQO/yOaDgfBBx7F08
         10Qo5n+myAGCiIVNFfK1RVA/y2xZjcOp8GQP3kAwV0sAb/Drs+RJAeRsVySMPDcs1hlr
         bswg==
X-Received: by 10.50.147.10 with SMTP id tg10mr38156531igb.36.1431637855055;
        Thu, 14 May 2015 14:10:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:74eb:19e4:cd06:a6b6])
        by mx.google.com with ESMTPSA id j3sm54746igx.21.2015.05.14.14.10.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 14:10:54 -0700 (PDT)
In-Reply-To: <c2fd3e038c821ec340c085a825baabc7@www.dscho.org> (Johannes
	Schindelin's message of "Thu, 14 May 2015 20:20:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269097>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>> My asciidoctor just comes from the Debian package. Looks like it's over
>> a year old at this point. I should probably be testing with something
>> more recent.
>
> We installed asciidoctor via `gem` and have version 1.5.2.

What I'll be pushing out today will have some "interesting" mark-up
in Documentation/git-cat-file.txt (on 'jch' or 'pu') from David's
'--follow-symlinks' topic.  I think AsciiDoc formatting looks OK,
but can you check it with both older (peff) and newer (dscho)
asciidoctor to see how well it shows?  Look for --follow-symlinks
in the output.

Thanks.
