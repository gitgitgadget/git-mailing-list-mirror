From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] gitk: add support for -G'regex' pickaxe variant
Date: Tue, 7 May 2013 15:30:27 -0500
Message-ID: <CAMP44s3d6dY8F-z8EA2jn+BrA0rMCGzGcm9a=41UTWsq=PwUGw@mail.gmail.com>
References: <7vipezaaig.fsf@alter.siamese.dyndns.org>
	<1339698851-15428-1-git-send-email-zbyszek@in.waw.pl>
	<CACPiFCKev9uibTa8GSH94ZaH-NaVBAWVempg4xfTdFTThE85Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>,
	Paul Mackerras <paulus@samba.org>,
	Martin Langhoff <martin@laptop.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 07 22:30:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZoWx-0005UO-0Q
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 22:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759287Ab3EGUaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 16:30:30 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:56318 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759272Ab3EGUa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 16:30:29 -0400
Received: by mail-la0-f49.google.com with SMTP id eh20so1001195lab.8
        for <git@vger.kernel.org>; Tue, 07 May 2013 13:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=kI4FCSqr+7CazsZkBbe99xXEH6JW5uv4c6J/upoPMnA=;
        b=cUF6AWJOEOJhpH12p4tvbKOuCmbOTp4uplD8CeTyGbzpclpxmklh71d2sCxHctN1Pq
         mOVrOWgfZbJh2zPGhnxnfsiXrpkgAryhMmLSqtKPq+eLuKsE7DmLhduSQrQBg/mrD/+B
         f9vazP5sJIXfCcXPezKU139H9Lg33b9a8yc+2UA/3YaxMyDhbx9XH3bUpKt8XvE3MCpM
         wd5SZiQsmVRLgAGweoVWxi3ozshnifxrTZ8SlkRM5PS0oy9D/Lb0VcTEYCaEuLBkwyiP
         PdTsGfEIhZiUQGjA74aZ4e1bd5+ZZu2qqqQax33co5R0IWXL/z3smK87omVOXOaeD/df
         9ghQ==
X-Received: by 10.112.125.130 with SMTP id mq2mr1701934lbb.103.1367958627935;
 Tue, 07 May 2013 13:30:27 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 7 May 2013 13:30:27 -0700 (PDT)
In-Reply-To: <CACPiFCKev9uibTa8GSH94ZaH-NaVBAWVempg4xfTdFTThE85Zw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223598>

On Tue, May 7, 2013 at 12:17 PM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> I just did git rebase origin/master for the umpteenth time, which
> reminded me this nice patch is still pending.
>
> ping?

For some reason getting patches into gitk takes a long long looong time.

-- 
Felipe Contreras
