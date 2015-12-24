From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 10/11] config: add core.untrackedCache
Date: Thu, 24 Dec 2015 22:10:29 +0100
Message-ID: <CAP8UFD0penKjBBUW-9aPJ=T8x7WfhZGDtH1-jBsuJ4CTb2mrXw@mail.gmail.com>
References: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
	<1450904639-25592-11-git-send-email-chriscool@tuxfamily.org>
	<CACsJy8C0CwbFy+Ghk3EWTyhqPYcr6xE5jczumWW98cAAHdfmPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 24 22:10:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aCD9l-00037s-8i
	for gcvg-git-2@plane.gmane.org; Thu, 24 Dec 2015 22:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbbLXVKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2015 16:10:34 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34926 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245AbbLXVKb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2015 16:10:31 -0500
Received: by mail-lf0-f47.google.com with SMTP id l133so166452111lfd.2
        for <git@vger.kernel.org>; Thu, 24 Dec 2015 13:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vB1//eKSj2K10qjWzF6+1o78EeMvhZePLhY9YcClqT0=;
        b=AF0Ttbxa0+g0a4btkkIAf/MVwN07EI6IfSrqekE6jZQAjPgFzqdkw3XKweO9X89tGM
         sywk4HU3L4/qlQ412wSVt9U7XdMDfZXeKN0hyNwzawGih5KQbNwdHX1+MYg5g81Fjt6z
         EKymGYn8sM9X/iSbBtzvquZEdlOZAej2jDaRG4TAHx2yyUpOliEPuXgytxy82VIHvsSl
         5KE8Y6X4AuIaHjLy54amaETTdXSGZr7MekLE85jzzZoRw0IMg8a370IFFg7F+qnKp4tg
         Hc8DVoBLjOAfD1ZjlzMYFmQFxQwPBlO2HyMHAHWHyFnDCfl3kfbxTSVzlbi8U7YOO4/f
         il9g==
X-Received: by 10.25.39.200 with SMTP id n191mr12906078lfn.7.1450991429497;
 Thu, 24 Dec 2015 13:10:29 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Thu, 24 Dec 2015 13:10:29 -0800 (PST)
In-Reply-To: <CACsJy8C0CwbFy+Ghk3EWTyhqPYcr6xE5jczumWW98cAAHdfmPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282983>

On Thu, Dec 24, 2015 at 11:13 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Dec 24, 2015 at 4:03 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>>  --force-untracked-cache::
>> -       For safety, `--untracked-cache` performs tests on the working
>> -       directory to make sure untracked cache can be used. These
>> -       tests can take a few seconds. `--force-untracked-cache` can be
>> -       used to skip the tests.
>> +       Same as `--untracked-cache`. Provided for backwards
>> +       compatibility with older versions of Git where
>> +       `--untracked-cache` used to imply `--test-untracked-cache` but
>> +       this option would enable the extension unconditionally.
>
> Nit. The reason --force-untracked-cache remains can probably stay in
> the commit message. Here we can simply say "synonym of
> --untracked-cache, deprecated" or something like that (or even ".. to
> be deleted in version N.M").

Yeah, I think "deprecated" should be enough and clearer, but I will
see with AEvar who helped me on this.

Thanks,
Christian.
