From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: fix unmatched code fences
Date: Tue, 12 May 2015 21:32:45 -0700
Message-ID: <xmqq8uctcd1u.fsf@gitster.dls.corp.google.com>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
	<xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
	<20150513021556.GA4160@peff.net>
	<xmqqk2wdcfbb.fsf@gitster.dls.corp.google.com>
	<20150513034553.GA25025@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 13 06:32:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsOLl-0008La-8N
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 06:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbbEMEcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 00:32:48 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33818 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbbEMEcr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 00:32:47 -0400
Received: by iget9 with SMTP id t9so108592148ige.1
        for <git@vger.kernel.org>; Tue, 12 May 2015 21:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=UV/dcfp82gxB3BZSOmBVPdsrB8ny6HWzlUTikCURJhM=;
        b=e9FYWF5ngBUwfyfx+AMo9qrlo86fGjm0l5U4iSEt+s44oDaHrk5UMMtl4BVdqtNpVI
         G1+tk8kMrjdrOzdx9au1HkWbXf7GuNQc8+lMMpu1+tpeXEZSuGD0jbvG9ymgfDrsZ33o
         WPjkf9+2EwkDD0fFcxC9F7+ERcrNf5dx4lT5VRrLTzORTPxoLPFen4EbtSUMfBdl6/5b
         uhp9iKT0aDoKcFvIskTIpZP0cJAZVUy0/7p6UTaGzCWlq6e5Vert2WPfoLP2B6MMiqjW
         91R4IFRajughBCwdGWJHBmtl/UHcHUw8Nnit3XvrNkvfJH/S9rEXHvHVRechnIXOcaqI
         cZOg==
X-Received: by 10.50.79.130 with SMTP id j2mr14403139igx.44.1431491567138;
        Tue, 12 May 2015 21:32:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3cfa:54ee:8e48:89ad])
        by mx.google.com with ESMTPSA id f126sm13460270ioe.21.2015.05.12.21.32.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 21:32:46 -0700 (PDT)
In-Reply-To: <20150513034553.GA25025@peff.net> (Jeff King's message of "Tue,
	12 May 2015 23:45:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268923>

Jeff King <peff@peff.net> writes:

>> It obviously is not a title underline as the lengths are vastly
>> different.
>
> Yes, but Python Asciidoc allows the lengths to differ.

Hmmm, I thought the title underline was a bit more strict. I do
recall having to fix manual pages for many commands, but we do not
add new commands these days anymore, so perhaps things have changed
since then.

> So clearly it
> uses some kind of heuristic, or this is some context in the parser that
> disambiguates the case.

Perhaps.

Thanks.
