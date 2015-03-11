From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Promoting Git developers
Date: Wed, 11 Mar 2015 00:38:21 -0700
Message-ID: <CAPc5daUVVk+SYgwCj9JftzXgV7=9kPprdBPCWHS5XQOa5uF69Q@mail.gmail.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
 <54FDA6B5.8050505@drmicha.warpmail.net> <CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
 <xmqqk2yo22ce.fsf@gitster.dls.corp.google.com> <CAEjxke-6DuTW0-ZyDtUUdCWhEtuw6x3X6LuM_Fj22QztUvFfjQ@mail.gmail.com>
 <xmqqmw3kuuod.fsf@gitster.dls.corp.google.com> <20150311073129.GA5947@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Jason St. John" <jstjohn@purdue.edu>,
	Christian Couder <christian.couder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 11 08:38:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVbE7-0005xH-Nf
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 08:38:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbbCKHim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 03:38:42 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36530 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbbCKHim (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 03:38:42 -0400
Received: by obcva2 with SMTP id va2so7104601obc.3
        for <git@vger.kernel.org>; Wed, 11 Mar 2015 00:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=gtSYypp0wI5Q2zYGRMsOTe5o4aMGzNLNBkhxcKBAc9Y=;
        b=TRReqGJii6vTphGWHy2r96ZxAO+TaEnitpRGU42y+7rO+D3ibpIQCoR1UzckUCbLcT
         PIoyo5PtNZj0wE/WqwDtqltbG7oqIq7gK/czNZVS9dLrPpJr6jy56jsiGcSvQJWnIzFg
         MA+5HbE/bKDo8X+PEcJx8oIfqRNVIAEb+JVa9F8ZgCbJ4qZXLGMWPE3RHRG3AU9zXcX8
         sRqHjZw24vQkhxzkXCgY0w06ikXtQYRIkjrPUcb56PGjTi+kDa5b9BIPqHigZFcJ1112
         5RFp/BX+IWKkoKuccYJFS/huEC2X9sfT5R14YGG4nsoDZOkFgQHp37/2Vx33iO+dt0lS
         7eTQ==
X-Received: by 10.60.145.137 with SMTP id su9mr15781121oeb.40.1426059521655;
 Wed, 11 Mar 2015 00:38:41 -0700 (PDT)
Received: by 10.202.48.143 with HTTP; Wed, 11 Mar 2015 00:38:21 -0700 (PDT)
In-Reply-To: <20150311073129.GA5947@peff.net>
X-Google-Sender-Auth: _cHoGUUjg3nbf8lCUenxHtio9Uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265311>

On Wed, Mar 11, 2015 at 12:31 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 10, 2015 at 07:36:34PM -0700, Junio C Hamano wrote:
>
>> > Or if that would make the release notes too cumbersome to review, what
>> > about using systemd's method? systemd's release notes include a
>> > "contributions from" section at the very end that lists everyone with
>> > a patch included in the release.
>>
>> I can add "shortlog --no-merges -s -n v2.3.0..v2.4.0" at the end of
>> the e-mail when the release notes is sent out. That might be a good
>> enough balance between the usefulness of the release notes to its
>> customers and giving credits to individuals in a way a bit more
>> visible than "if you are interested, run shortlog yourself" [*4*].
>
> I somehow thought you already did this, but it looks like you just do
> shortlog (without the "-ns") for the "maint" release announcement.

That is because (a) it is scripted in Meta/Announce, and (b) I strip it
out for feature releases, as the plain shortlog output with full feature
list is usually ends up being just too long for the announce message.

Perhaps I'll add "shortlog -s | pr -3" or something at the end for both
maintenance track and feature releases. Names only, unordered and
hopefully not overly long.
