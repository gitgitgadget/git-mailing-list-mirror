From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 2/2] Don't close pack fd when free'ing pack windows
Date: Wed, 31 Jul 2013 14:31:34 -0700
Message-ID: <CA+sFfMfzHh5kbyv673e6V=Md14DZBqDaLFwspfcZNBGomZBV9g@mail.gmail.com>
References: <CA+sFfMe1GTDqtgGs3NXoB0OBYTtyHxLDYgy0TmOe+3r=tMXS0A@mail.gmail.com>
	<1375300297-6744-1-git-send-email-bcasey@nvidia.com>
	<1375300297-6744-2-git-send-email-bcasey@nvidia.com>
	<CALWbr2wR2cN8dcOtW2bV3p7FC3ymdXgfp61A4pNKvOWhP6WU_Q@mail.gmail.com>
	<20130731212114.GG19369@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 23:31:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4dzg-0000Gb-Ja
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 23:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757482Ab3GaVbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 17:31:36 -0400
Received: from mail-we0-f178.google.com ([74.125.82.178]:61263 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830Ab3GaVbg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 17:31:36 -0400
Received: by mail-we0-f178.google.com with SMTP id u57so1069924wes.37
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 14:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nOr3EMBSDtVtWpdtFdzRKy0Jg4hVKClKkNDMrRWgHlw=;
        b=uFBeSG1w75KU1q1ghWuoRbX2W79WU1xf1VnyCTuSFGVyKUuBJwKv+T7VPVM9MuGgat
         2lJTyohonRboIkv63wqBjbwZzJ3lVc+RIsZF/PRfwLNQaLfYEDQY/5CIFY6klZJ3tnRO
         3iZKUHo66wO1ZS6T8rs3AyIvN3g9PBc212UEIOs8PxjGBj6n81Z7hkXU+wfAzWEVLYdi
         S43nYd2Ov1yXMAHGAIbmpb67XG/57ea6n4zTz77xj29cJ5bt7wNeGP11ZTtgLVUaQDBK
         YDXMmSbrGioTTlS/iO93rJv9kEJBLAYf25MsjjO/tbpzatQxHlxbG846yJwLd2UhBq4r
         qerA==
X-Received: by 10.194.60.5 with SMTP id d5mr38428782wjr.26.1375306294974; Wed,
 31 Jul 2013 14:31:34 -0700 (PDT)
Received: by 10.194.81.102 with HTTP; Wed, 31 Jul 2013 14:31:34 -0700 (PDT)
In-Reply-To: <20130731212114.GG19369@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231466>

On Wed, Jul 31, 2013 at 2:21 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Wed, Jul 31, 2013 at 11:08:21PM +0200, Antoine Pelisse wrote:
>> On Wed, Jul 31, 2013 at 9:51 PM, Brandon Casey <bcasey@nvidia.com> wrote:
>> > -----------------------------------------------------------------------------------
>> > This email message is for the sole use of the intended recipient(s) and may contain
>> > confidential information.  Any unauthorized review, use, disclosure or distribution
>> > is prohibited.  If you are not the intended recipient, please contact the sender by
>> > reply email and destroy all copies of the original message.
>> > -----------------------------------------------------------------------------------
>>
>> I'm certainly not a lawyer, and I'm sorry for not reviewing the
>> content of the patch instead, but is that not a problem from a legal
>> point of view ?
>
> Talking about legal, is it a problem if a commit isn't signed-off by
> it's committer or author e-mail? Like in this case where the sign-off is
> from gmail.com and the committer from nvidia.com?

It never has been.  My commits should have the author and committer
set to my gmail address actually.

Others have sometimes used the two fields to distinguish between a
corporate identity (i.e. me@somecompany.com) that represents the
funder of the work and a canonical identity (me@personalemail.com)
that identifies the person that performed the work.

-Brandon
