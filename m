From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] format-patch: print format-patch usage if there are no arguments
Date: Tue, 13 Jan 2015 14:48:15 -0800
Message-ID: <CAGZ79kZ87ZKT5-OMTEHAMEAmZVOfku_D4vZ9jcWJ4cHrA06cSw@mail.gmail.com>
References: <1421171662-12164-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq387eed30.fsf@gitster.dls.corp.google.com>
	<CANCZXo7UtCXF_bJe9exT1pUwwsgUuYs5mvHHGtDORoJew_UXnQ@mail.gmail.com>
	<xmqqppaicwww.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYJ+XNktc7_C81xz=BfCP4_hrE=pWW5QGJ1kdXKMf4Jjw@mail.gmail.com>
	<xmqqiogaco3m.fsf@gitster.dls.corp.google.com>
	<20150113224531.GB3144@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Alexander Kuleshov <kuleshovmail@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 13 23:48:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBAG8-0001Ma-E8
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 23:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbbAMWsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 17:48:19 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33926 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbbAMWsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 17:48:16 -0500
Received: by mail-ig0-f176.google.com with SMTP id b16so4012014igk.3
        for <git@vger.kernel.org>; Tue, 13 Jan 2015 14:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yGj4pLjeNIp5QErC9B9GxK5Qy1TGF801kIznbqsk/kk=;
        b=iT5iADAiHSFDZNvb1Ems2vl0GLTD9SzTbOrBq7Q6layhq8j4IEWacvQMJJe2O1OKps
         HO/dSpzhNb2Z1A8J1T/bp1pebjKMe6D856BynPp9i68jCOHVhGk4Wslx/9jwYPIBCl/c
         KMJtusF1tNdBS2rMkY6PKX9Qq3aOFQk6k67D9Pyjodv1aHyxahjD7LgE7cMXfE53fl0h
         E/Q+MLzJtEIbtRWVsAJnQUHLt/K7ikGxg3009CH0kaxhJEvQc8F/Imif/c8FzpmaLwes
         Nfk00gI8PQQMZsKos7bE4ksXN+f20TfEbfeL7kP8ZXCDMv+FSwmG7qLND1C7fexYNSpD
         wsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=yGj4pLjeNIp5QErC9B9GxK5Qy1TGF801kIznbqsk/kk=;
        b=XPAhD9AlQNmiiP0q0dfUQ3X5phxD87V0qD6dnusqWJrkrN1pwl8yIADs/ysg5v8wRs
         SCFr31t0iB6y/+b/DRPUPOtueOUlYM4YSjVJ9mKzNLAXRvXv8TXZO5CXMPev2SDmfCUu
         dZqEm81zAeTKl+horVZf2cTsDgm272sBs0+UvNkCXu4zGcb08ZP9I4gycI9MFvBsfqMU
         a8kL1WCo2msxgz/XbWXVgYsSnJFa1e7XIsThBapZ+lkfeUP7jfq36gByFqcR7VHYJTxP
         StD4ts7G3gBuPjqG09ZpIYE5irjkZABP9ut0XDyOTRzGh7TLf3oNqqI8HoOM5CVS+NQ4
         kGYA==
X-Gm-Message-State: ALoCoQlQHkCUb+11AEyqWfh+u5TnCYjYq7TbS3wlg7IPQqRU52GkBe5oSkP15WaklXzMmgO14xzC
X-Received: by 10.107.25.74 with SMTP id 71mr952174ioz.70.1421189295893; Tue,
 13 Jan 2015 14:48:15 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Tue, 13 Jan 2015 14:48:15 -0800 (PST)
In-Reply-To: <20150113224531.GB3144@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262360>

On Tue, Jan 13, 2015 at 2:45 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jan 13, 2015 at 02:28:13PM -0800, Junio C Hamano wrote:
>
>> On the other hand, "I am forked from building on this one" done with
>> "checkout -t" is an explicit mark the user leaves, so it would serve
>> as a better hint to base the default heuristics on, I think.
>>
>> But nobody is asking for such a feature ;-)
>
> So that is perhaps not asking for the feature (I am already happy with
> my homegrown wrapper), but is maybe an endorsement of it. :)
>

Would you mind to share (parts of) the wrapper script? We could see if that
makes sense to incorporate into format-patch as well.

Thanks,
Stefan
