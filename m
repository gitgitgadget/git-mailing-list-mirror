From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 5/5] help: respect new common command grouping
Date: Tue, 19 May 2015 09:09:35 -0700
Message-ID: <xmqq1tica6rk.fsf@gitster.dls.corp.google.com>
References: <1431976697-26288-1-git-send-email-sebastien.guimmara@gmail.com>
	<1431976697-26288-6-git-send-email-sebastien.guimmara@gmail.com>
	<xmqqr3qda7kx.fsf@gitster.dls.corp.google.com>
	<20150519004356.GA12854@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?S=C3=A9bastien?= Guimmara 
	<sebastien.guimmara@gmail.com>, git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 19 18:09:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuk5P-0000L7-BB
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 18:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756289AbbESQJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 12:09:38 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33273 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbbESQJi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 12:09:38 -0400
Received: by igbpi8 with SMTP id pi8so110409415igb.0
        for <git@vger.kernel.org>; Tue, 19 May 2015 09:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=O7SHvLwmf3SRzHwAR5xePRN3U3cwsuJmVLtIL5zgq90=;
        b=u+SXhPLsukS8qfXDygO9gifQcPWvG9EJX7zzUfyMlY7bGNh+B4JcqGq6OmnmWUhnbL
         iHUUQeFPPiAZDuphMEXb6Mz1TSjgr1fVnFlNwIuMCga8NWf1nMAG82ivxi6MPwpH5wqQ
         HKpGgqe+a3bJIsnzDCQ2JrJX0T8Kd0m9nD6Pns1wo9Ma4YDsHCTmqz6q92Gp3QHBzdaK
         7qeKCuN12K5OHFM29ZoB2CyVBJ6vfhzaDbrRSzAR1oU6K5vV79lapeBJwyWaqK5CgebS
         K76lYJnv7234+wvTSspbtzksMMT/C7OfWp6qUoeMNotcPyFZfXD3yOzIlUgRMQGAMWdp
         BqKQ==
X-Received: by 10.43.19.72 with SMTP id qj8mr30335582icb.68.1432051777540;
        Tue, 19 May 2015 09:09:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:799e:649b:b86b:7c03])
        by mx.google.com with ESMTPSA id rr5sm8150646igb.7.2015.05.19.09.09.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 09:09:36 -0700 (PDT)
In-Reply-To: <20150519004356.GA12854@flurp.local> (Eric Sunshine's message of
	"Mon, 18 May 2015 20:43:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269366>

Eric Sunshine <sunshine@sunshineco.com> writes:

> The awk script restricts itself to POSIX, and I did test it on Linux,
> Mac OS X, and FreeBSD, so it seems pretty portable.

I was worried more about some people only having gawk while others
with mawk and yet others nawk, etc., without having one of them
under the canonical name "awk".  It's nothing what

    $ make AWK=mawk

or its config.mak equivalent cannot fix, but still bothers me a bit.
