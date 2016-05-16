From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 0/4] pathspec labels [WAS: submodule groups]
Date: Mon, 16 May 2016 15:09:53 -0700
Message-ID: <CAGZ79kaP7rPu64ORXrGcONyoM2jA+gfPpy3LFkbp0Axff9dsHg@mail.gmail.com>
References: <20160513001936.7623-1-sbeller@google.com>
	<CACsJy8BK-u2VV3kkq3ANHCanYqMwphqgxZmooQfewA_J7e8MPw@mail.gmail.com>
	<CAGZ79kacKnBjzVFSShRido4rKa3-Zg465d2320M6w1qXEkOZqw@mail.gmail.com>
	<xmqqh9dx3nsf.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZyPvAFG1TjSm76LuDLpch=7iuL_-8LYqysSESFQj-YjQ@mail.gmail.com>
	<xmqqlh391z2v.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZuMdWdw2kcfs_P-_Ax1zXpKNHqMjNL80hBj3=SSp2zSQ@mail.gmail.com>
	<xmqqh9dx1xku.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbJxf6qnj1vqkbFzXBU+6Cfh6RMvs2NqqeASZAPLFXu8Q@mail.gmail.com>
	<xmqq8tz91x1b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 00:09:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Qi7-0002lp-1h
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 00:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbcEPWJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 18:09:55 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:32843 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbcEPWJy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 18:09:54 -0400
Received: by mail-io0-f174.google.com with SMTP id f89so949314ioi.0
        for <git@vger.kernel.org>; Mon, 16 May 2016 15:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=4onsR0hCOv85Mrtd7VdZyE7VKbTnSBN7FkevSXLDsPQ=;
        b=ZLJArCwjC3BchhX9t4onfCOFYaC2aV+aA15omz7LQDQvhbXHmoyluXfQPZRSrE2BkA
         W7+/G9YW4t4glKvkLFTZwGWYRxbiG8YdnsNDh3X6HWc18suucbjENt2l1NWLOlnk+Zd8
         26OXBrNnAAVOFlavCWYzOn/3k/aeLVsZG/G9Ohxr4AsmnVqyINNh3silg4Kopcdm9h/6
         OCZEMx0e/u5clkMsa4V56EuLmmSrLyAMFKXEfKFBDDPaXVu0bqHQ9ZwOEiA2cpjWYRUs
         yysSX2W3bxwh1TmBEgmnE2p0O5VAw/6F418R+rFSaFPv+CNtmjr318v3yIj24i3BxCFV
         kiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=4onsR0hCOv85Mrtd7VdZyE7VKbTnSBN7FkevSXLDsPQ=;
        b=mrAQEMr0FKNaJPQu7wSHEqdA4ArypCXw50K2hQiY2D6YhVN3Wg0nS55Wk2oTcX+CVd
         6PxjySs0/WxIMORW/DAob8CgqCnNcKpj3QS9RZOef68OHqlUDNNdfHNaCJsGfap27cO/
         VGttFFGeTH5NGYtCgxna/tnK0pt4PfaGP3rtnUGTQs3e3hCEg3tkrcxucqO3C+NsTGFk
         o71qjIdSAqDx0qG/zNGtFcezHveOsTc9xnJLUHhYj1qXIynfuvTvF+d1ezu4crSrM1h/
         5TVAaDgam8qX/HiN8QSpfVcqI2/wi80SUh7QcSgbmU52bZ/pqChKY+xG0TkY94wV9j3v
         ZAOw==
X-Gm-Message-State: AOPr4FXJ9Bx9b5P/9aT4LyZzP1MhT5IKIw8TvlK/hqFIW71zzkCQGriY42GYsxD+GJ9eaHg7I8pjC3CoKb9dkTiR
X-Received: by 10.36.14.71 with SMTP id 68mr10601218ite.98.1463436593392; Mon,
 16 May 2016 15:09:53 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 16 May 2016 15:09:53 -0700 (PDT)
In-Reply-To: <xmqq8tz91x1b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294805>

On Mon, May 16, 2016 at 3:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> Hmph, why not?
>>
>> We need a namespace for which
>> * we can guarantee that it is for labeling purposes only (even in the future)
>> * is obvious to the user to be a labeling name space
>>
>> Starting with "label" offers both?
>
> Ah, of course.  I thought that you were trying to limit ":(attr:<attribute>)"
> magic only to attributes that begin with "label-", which is where my
> "why not?" comes from.

And going by the logic you presented before, we would
need to error out for the given pathspec ":(<string>)" if

* either the string is not well known (e.g. diif, eol )
* or is outside of the labeling namespace.

So we don't want to see users complaining about
"bug attr:foo worked as a label, now it is a feature; you broke my code"

We would need to ignore data from .gitattributes as it may be crafted from
a newer version of Git, but the command line argument still needs to die
for unknown arguments?

So asking for :(foo) would yield a

    fatal: attr 'foo' is not known to Git, nor is it in the labeling name space

I guess what I am asking is if there is a nice way to query "do we know
this attribute?"

Stefan
