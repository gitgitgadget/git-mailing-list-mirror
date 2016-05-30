From: David Nicolson <david.nicolson@gmail.com>
Subject: Re: [PATCH] Documentation: GPG capitalization
Date: Mon, 30 May 2016 23:43:26 +0200
Message-ID: <CAKp3HaMvsJ58fvtC+rp13wigw75vVm3F7T2U+Gqnyqke71279Q@mail.gmail.com>
References: <01020154fd9dec3d-61772857-8b92-4505-ac0f-5058d490f7dc-000000@eu-west-1.amazonses.com>
	<xmqqvb1vo25i.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 30 23:43:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7UyK-0004xK-TQ
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 23:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422909AbcE3Vna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 17:43:30 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33788 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422796AbcE3Vn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 17:43:28 -0400
Received: by mail-lf0-f66.google.com with SMTP id w16so12912981lfd.0
        for <git@vger.kernel.org>; Mon, 30 May 2016 14:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=umk3rqjBF5LUsSExghvGmcr+6VBZIbZm8Nq2nbY2R3Q=;
        b=oHdIu1toYw+OAiJq2E6VazISpegw7r7PNr8KgcDZaczpXsjf9hDNBwCioMURMRO890
         bDP0Lyzm+Z3yBYV/TisnDuOiBBUemkzSl91M0bJATNnqgOUc545G+Y0pLrUyPIHU6o10
         7QGhfiYMN+zVXzGNmRXnwQBTjvL9hOvqhajZxhFms1rjBiAovuT2Sm6T70V+t7bpzrst
         0q/Z9wcbayFiudJq3rpUw3VJVJEvDgpx5jaY4YZ3HrcLxXBKW0VgXgurc8xY3o0igmrL
         WrMwQtAoTNDx3TH05X40Esa+LwZUnOeyjfBNRzTMZVktsjLSBXmjBy2MyvcaN7rp/lGB
         zJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=umk3rqjBF5LUsSExghvGmcr+6VBZIbZm8Nq2nbY2R3Q=;
        b=g67VbjYv6q8JG5013boPXK/doH75ZYJHSpEWCBT0BcRwSeREsj58vZVr4uA6fJ5Pwl
         05Hl+zd3VC6d7GsXZ/tgRLdnmel3jkbctFtoc7iWHUXQfov8pOSJuVdaMwQY5bbxXVMa
         vj5kn1C+TWOIdRE8Dzpfeaud/qxJFCcakxMOWPxPebikqa7sKkyAA3mFrpTjmAgfJDh/
         qIP/ZX4SlwCvjh1rVnbka5kzWmHyc95bmz367YgajETIR+mD0OjC+SkHxElFOLt39lE7
         NKzf0vD4h9jfTbWf9zis5SWNjF4vC/BpHToYLECjGv90V6dIzRdmZQDQFHSQbtHKy8pQ
         eqwQ==
X-Gm-Message-State: ALyK8tJD3NB4AFo4lXDO5sJtGwAxP0EqC4eIEvtj6T2UTGtw8MtQoZgVeftGVfV3/PnDiZUjlOG79+Njwe7bDg==
X-Received: by 10.25.168.197 with SMTP id r188mr9726962lfe.150.1464644606433;
 Mon, 30 May 2016 14:43:26 -0700 (PDT)
Received: by 10.114.27.197 with HTTP; Mon, 30 May 2016 14:43:26 -0700 (PDT)
In-Reply-To: <xmqqvb1vo25i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295932>

On Mon, May 30, 2016 at 8:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dave Nicolson <david.nicolson@gmail.com> writes:
>
>> When "GPG" is used in a sentence it is now consistently capitalized. When referring to the binary it is left as "gpg".
>>
>> Signed-off-by: David Nicolson <david.nicolson@gmail.com>
>> ---
>>  Documentation/git-mktag.txt         | 2 +-
>>  Documentation/git-tag.txt           | 2 +-
>>  Documentation/git-verify-commit.txt | 4 ++--
>>  3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
>> index fa6a756..724408d 100644
>> --- a/Documentation/git-mktag.txt
>> +++ b/Documentation/git-mktag.txt
>> @@ -32,7 +32,7 @@ followed by some 'optional' free-form message (some tags created
>>  by older Git may not have `tagger` line).  The message, when
>>  exists, is separated by a blank line from the header.  The
>>  message part may contain a signature that Git itself doesn't
>> -care about, but that can be verified with gpg.
>> +care about, but that can be verified with GPG.
>
> Isn't this a name of the program, though?  Other two hunks in your
> patch clearly refer to the concept and not to a particular program,
> and they are good changes, I think.

This one was not as clear as the other hunks. Git is referred to as
"Git" in the preceding line, which in itself could be referring to the
concept or the particular program I guess?
