From: Junio C Hamano <gitster@pobox.com>
Subject: Re: check-ref-format: include refs/ in the argument or to strip it?
Date: Fri, 22 Aug 2014 22:50:52 -0700
Message-ID: <CAPc5daVnPbP3rseEaZPug21phaF1FozqTFvBnK2EMkNMxkhATw@mail.gmail.com>
References: <gerrit.1408574889668.Iac983fc86f7edd2a0543779d85973c57bf068ca4@code-review.googlesource.com>
 <047d7b624d36142d46050131f336@google.com> <20140822154151.GK20185@google.com>
 <xmqqmwawnzfk.fsf@gitster.dls.corp.google.com> <20140822184515.GL20185@google.com>
 <20140823054646.GA18256@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 23 07:51:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XL4EP-0004Hv-VC
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 07:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbaHWFvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2014 01:51:14 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:60621 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbaHWFvN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 01:51:13 -0400
Received: by mail-la0-f45.google.com with SMTP id ty20so10851801lab.32
        for <git@vger.kernel.org>; Fri, 22 Aug 2014 22:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=lnwrp4UgaNRzurWPqZB9kRPAQq2N7Qjbqmv3ZnPwW4A=;
        b=Qe8lvu7mIszmV3kw1koExHzZYzh3oEzCu+eBtUmzTu1PlSkV39zLfcj8wUjFa0t1Ms
         1+JJhuq5TBYZGCb4X04twa4EXwGuHH538mtEDTfN2ZBgRCjtlKXh2uQeHf1T8F5LmGla
         ZCij4ZuMt73mjGvVL414EMzCNDuagShg+Oi3FFWpnMwVQW6cgKn6Xpwy/BKP4drm/czO
         j/qOkBDuuuhgshRA2DQknusOoiRVs8wn9bOWDBAhuxNy8k5qOiUTjsQI91NQ7jmuu8uj
         IGMOG0fD3rCmlp22/o2xKM5ywbfhOwZ8dLlq9dCcX7ucxyn89gSZjEX6wwuJy5QXf0qA
         XGTg==
X-Received: by 10.152.20.168 with SMTP id o8mr8857364lae.4.1408773072168; Fri,
 22 Aug 2014 22:51:12 -0700 (PDT)
Received: by 10.112.97.177 with HTTP; Fri, 22 Aug 2014 22:50:52 -0700 (PDT)
In-Reply-To: <20140823054646.GA18256@peff.net>
X-Google-Sender-Auth: m5fsQ3vtFc2KzZaw09vBVh9SfZk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255735>

On Fri, Aug 22, 2014 at 10:46 PM, Jeff King <peff@peff.net> wrote:
>
> After much head scratching over the years, I am of the opinion that
> nobody every really _meant_ to prevent "refs/foo"...

Yup, that matches my understanding.
