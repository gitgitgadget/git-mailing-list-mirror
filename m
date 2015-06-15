From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/11] Create ref-filter from for-each-ref
Date: Mon, 15 Jun 2015 11:49:24 -0700
Message-ID: <xmqqmw00958r.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZR6hRFZjXmSPh+rUS6EROdjP8d3tgP0+Yh5VDBdngCOkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 20:49:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4ZRu-0008QY-3G
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 20:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315AbbFOSt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 14:49:28 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:34564 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbbFOSt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 14:49:27 -0400
Received: by iebmu5 with SMTP id mu5so68741465ieb.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 11:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=AKQpugGPTEf9yvR3AH+/yxACloC/pXmxWYg0PGhTl8c=;
        b=NHz9MQiJrjS3/pZmrrIE1VEHUVBAp+Er/OFYvucNgktiHQwPQ2hVznmhbgfVvg5xVn
         YzSYXfwsyndSEllFDM0ZvY/bSIJ0HGAIMzHUwJl9zqaoW2UEWrSpp6icIstC+yS06QwH
         NVO3iHvXqFQpORKIFhjXacZExUSIEly2YhhLlng1wEw/IpllTY7AqzYaQWDLBvexz16p
         QzbXGcT/6e89rbP+BusRboxVBSmLMagK3C6g8f8++5+WhkWyQG8EBnSh/cyeoh0GvOgK
         mgsGdRfJBQmAxJwhaWZq3MsLNxexX+MH8OKYiQxU+NGX46LFBfZWkaDPH4EollGJR4AP
         uQMQ==
X-Received: by 10.107.166.203 with SMTP id p194mr36509167ioe.30.1434394167115;
        Mon, 15 Jun 2015 11:49:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id qs10sm8151718igb.14.2015.06.15.11.49.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 11:49:25 -0700 (PDT)
In-Reply-To: <CAOLa=ZR6hRFZjXmSPh+rUS6EROdjP8d3tgP0+Yh5VDBdngCOkA@mail.gmail.com>
	(karthik nayak's message of "Sun, 14 Jun 2015 01:04:22 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271706>

karthik nayak <karthik.188@gmail.com> writes:

> The previous version of the patch can be found at :
> http://thread.gmane.org/gmane.comp.version-control.git/271423
>
> Changes :
> * Removed an unnecessary commit (v7 3/12)
> * Change a comment in 01/11 (v8)
>
> Total changes :
>
>  Makefile               |    1 +
>  builtin/for-each-ref.c | 1108
> +++-------------------------------------------------------------------------------------------------------------------
>  ref-filter.c           | 1101
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  ref-filter.h           |   74 ++++++++
>  4 files changed, 1195 insertions(+), 1089 deletions(-)

This round looks good enough to build on top by merging more
interesting bits from tags and branches ;-)  Let's conclude
this series at this round and then incrementally fix if there
is any remaining nits discovered later.

Thanks all.
