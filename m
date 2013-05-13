From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] gitk: add support for -G'regex' pickaxe variant
Date: Tue, 14 May 2013 02:34:20 +0530
Message-ID: <CALkWK0kVa-9-G8-2HtH1_cd1LY65abU8R4WKcjgkyTSh=xQamw@mail.gmail.com>
References: <7vipezaaig.fsf@alter.siamese.dyndns.org> <1339698851-15428-1-git-send-email-zbyszek@in.waw.pl>
 <CACPiFCKev9uibTa8GSH94ZaH-NaVBAWVempg4xfTdFTThE85Zw@mail.gmail.com>
 <20130511055647.GA3262@iris.ozlabs.ibm.com> <20130511061322.GB3394@elie>
 <20130511094119.GA6196@iris.ozlabs.ibm.com> <CACPiFCKkzSCaSfqExZggFHBAmcPBTYYhyauOa2h1dXiYqKZMxA@mail.gmail.com>
 <20130513185551.GB3657@google.com> <CAAhxitGFhVa6+8x_rgNz5dgyr6m4S11fVU2eJNnMuWimGiM8aQ@mail.gmail.com>
 <20130513193320.GC3657@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin Langhoff <martin@laptop.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 23:05:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubzvh-0006Rf-F6
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 23:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab3EMVFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 17:05:03 -0400
Received: from mail-ia0-f176.google.com ([209.85.210.176]:55974 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451Ab3EMVFB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 17:05:01 -0400
Received: by mail-ia0-f176.google.com with SMTP id j38so7889500iad.35
        for <git@vger.kernel.org>; Mon, 13 May 2013 14:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Y/bwCV/bvZR8hYfId3ObQeVRpV6+UHsBDUzOAXPuX7M=;
        b=T7EzfX4MMepquJA1Q1Up3IHCQumiq2LRMDBSOLQ5ou34L5u5we8GIZQvI2rlOWR8ph
         zg1eVJWAOyyNx0Axv5ztMje/R0ICXH0filY4BAugmBDgWMqc9yGcAextlj6RXP7RXX4P
         OmcUWaiLMofw0GUZQjdKmzOCXFjlJHhfO2MLq/kFlPwbKxJHvRLKux40LkYYw07L1Pjt
         v+jvj3OnNQQvYfI6Z1692LGcS6m3LX7GBjhccoiyEAtLP1P/cg4g9Me0XOkRPNLQ86h0
         9WKNtCTjdTJ/wEXtCY87DOJrxgLHIeBpETWP6k58xP/7cDliR+pgjWFSHg0BpeYFGCaK
         FAAw==
X-Received: by 10.50.131.137 with SMTP id om9mr74422igb.1.1368479100606; Mon,
 13 May 2013 14:05:00 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 13 May 2013 14:04:20 -0700 (PDT)
In-Reply-To: <20130513193320.GC3657@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224204>

Jonathan Nieder wrote:
> Martin Langhoff wrote:
>> On Mon, May 13, 2013 at 2:55 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
>>> My experience is the opposite.  I wonder "What did the author of this
>>> nonsense comment mean?" or "What is the purpose of this strange
>>> condition in this if () statement?".  Then "git log -S" finds the
>>> culprit
>>
>> Only if that if () statement looks that way from a single commit.
>> That's my point. If the line code bit you are looking at is the result
>> of several changes, your log -S will grind a while and find you
>> nothing.
>
> Well, no, it should find the final change that brought it into the
> current form.  Just like "git blame".

I still don't know exactly what -G and -S do.  The documentation can
be improved, no?  A nice example would definitely help.

Thanks.
