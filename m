From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH 1/5] gitweb: Add a comment explaining the meaning of $/
Date: Wed, 4 Dec 2013 11:19:02 -0500
Message-ID: <CACPiFCJON33dz64qSZDnrCo8hbVpbxk7k65xmW1oBiZ4Muzcbg@mail.gmail.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
 <1386164583-14109-2-git-send-email-krzesimir@endocode.com>
 <CANQwDwdiNHFCChVdkKxkEa+HOKzzhgfzy4d6iZB6ejSfva3Z3A@mail.gmail.com> <1386171977.2173.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 17:19:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoFAg-0000u8-1f
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 17:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830Ab3LDQTY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Dec 2013 11:19:24 -0500
Received: from mail-ve0-f181.google.com ([209.85.128.181]:36863 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755824Ab3LDQTX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 11:19:23 -0500
Received: by mail-ve0-f181.google.com with SMTP id oy12so12029468veb.26
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 08:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=1yRprgRlfXPLhWN13h6YNkukA8MZMxX6sK2lihj4K0s=;
        b=js5/sjhxtoZxGQzuZ5yJhaX+3iGPd1ZmeiFoJ7vbBcot30EICnJ7U92YKCB2L3HWCO
         zKkGcALds/+EHtJLGNLk5s0/HnV66buZ151i8fSc4cGaGSmeAa4HvDRSgmwgv105g/8z
         7siUeZ/adrEDHbGAxsw+AjwbF6RcmIPOCs7sIkTTlO29OcRZ+JZdgbwDrdttmHZcMGRq
         zbm/jTRKZ40nTIefD7tAMCDiCezc0rcF6FnqhB7ign24z8bVaCXISqF+5ABVguE7Jtm7
         JFYfPSrJsTaGYeghgE9nRzsNohZ6Pg6LhkbDUrt/80mmMH7MRuxQvfjd9EkpF0+/9qI1
         nh6A==
X-Received: by 10.52.28.78 with SMTP id z14mr887463vdg.54.1386173962452; Wed,
 04 Dec 2013 08:19:22 -0800 (PST)
Received: by 10.220.74.133 with HTTP; Wed, 4 Dec 2013 08:19:02 -0800 (PST)
In-Reply-To: <1386171977.2173.23.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238789>

On Wed, Dec 4, 2013 at 10:46 AM, Krzesimir Nowak <krzesimir@endocode.co=
m> wrote:
> On Wed, 2013-12-04 at 16:11 +0100, Jakub Nar=C4=99bski wrote:
>> On Wed, Dec 4, 2013 at 2:42 PM, Krzesimir Nowak <krzesimir@endocode.=
com> wrote:
>>
>> > So future reader will know what does it mean without running "perl=
doc
>> > perlvar".
>>
>> Hmmm... shouldn't future reader know it anyway?  It is not that cryp=
tic.
>> I'd say it is idiomatic Perl.
>
> It's plainly obscure. And I think it is not that often used -

It's classic Perl.

Perhaps you'd want to "use English;" and call it
$INPUT_RECORD_SEPARATOR in a patch titled "Make things readable to
non-Perl natives".

cheers,



m
--=20
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
