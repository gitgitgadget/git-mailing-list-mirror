From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: fix unmatched code fences
Date: Tue, 12 May 2015 20:43:52 -0700
Message-ID: <xmqqk2wdcfbb.fsf@gitster.dls.corp.google.com>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
	<xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
	<20150513021556.GA4160@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 13 05:44:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsNaS-0002Cg-5v
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 05:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934307AbbEMDnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 23:43:55 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:32996 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933994AbbEMDnz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 23:43:55 -0400
Received: by igbpi8 with SMTP id pi8so107420187igb.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 20:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=jet6n1AXNdquI59wp7/4st8tH2bBnGRQtv59LOcpHEA=;
        b=UtOJo2eYwHbKgzr0drxi4sAYSgDzpsqYfJCB3+sv3HwOdq61+d2CY8+KGCGbB8YTrG
         R7fRLSnqrXVcLD3mIF5Ly0kgpTH7Y7cLVmIzTeRnLMiPyxlBG2Vv6yy5KLo0WULQZ1Zl
         q25lFaEsOX4RAF1txGh6cVbHMTj33aswSZ5Ni0T44oxIVax2B0Qaxo4OeN+s/a4SnRnG
         5VQrSeynE+7C5d44kIa4pZ/E5jYGT9YanOBxdBHX+jD7xvqRdi2GLIzWfnnGE4d50B2p
         vk3npLiJt9xaw9jFM2Sp+pea4PCZqD4puhz2QSLYdAWaczP6BqT+zkx7tesPr+0ClVJe
         9O0w==
X-Received: by 10.43.119.70 with SMTP id ft6mr6697389icc.15.1431488634550;
        Tue, 12 May 2015 20:43:54 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3cfa:54ee:8e48:89ad])
        by mx.google.com with ESMTPSA id x10sm314048igl.0.2015.05.12.20.43.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 20:43:53 -0700 (PDT)
In-Reply-To: <20150513021556.GA4160@peff.net> (Jeff King's message of "Tue, 12
	May 2015 22:15:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268919>

Jeff King <peff@peff.net> writes:

> With this patch and the one from Jean-Noel, the script above finds only
> one hit, which is a false positive. It's at git-commit.txt:233, and it
> looks like:
>
>     It is a rough equivalent for:
>     ------
>             $ git reset --soft HEAD^
>             $ ... do something else to come up with the right tree ...
>             $ git commit -c ORIG_HEAD
>
>     ------
>
> I have no idea how asciidoc knows that this is a code block and not a
> title called "It is a rough...".

It obviously is not a title underline as the lengths are vastly
different.  It would be an interesing exercise to make both of them
longer, but I suspect giving an extra blank line there may not hurt.

Thanks, will queue.
