From: Eli Collins <eli@cloudera.com>
Subject: Re: [PATCH] config.txt: fix placement of diff.noprefix
Date: Fri, 10 Sep 2010 09:46:44 -0700
Message-ID: <AANLkTimpSPkA+=CHw2QqA17HkAdjB1Zd3tsGAWQ3-HiY@mail.gmail.com>
References: <1284082777-18826-1-git-send-email-lodatom@gmail.com>
	<7vvd6dh83o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 18:46:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou6kX-0001wS-U6
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 18:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755622Ab0IJQqq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 12:46:46 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:39453 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643Ab0IJQqq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 12:46:46 -0400
Received: by qyk36 with SMTP id 36so7490026qyk.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 09:46:45 -0700 (PDT)
Received: by 10.224.80.203 with SMTP id u11mr500289qak.355.1284137204827; Fri,
 10 Sep 2010 09:46:44 -0700 (PDT)
Received: by 10.229.1.165 with HTTP; Fri, 10 Sep 2010 09:46:44 -0700 (PDT)
In-Reply-To: <7vvd6dh83o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155946>

Good find. Apologies, looks like that was an issue with the original pa=
tch.

On Fri, Sep 10, 2010 at 9:32 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Mark Lodato <lodatom@gmail.com> writes:
>
>> In git-config(1), diff.noprefix was placed in between
>> diff.mnemonicprefix and the list of mnemonic prefixes, which is
>> obviously incorrect and very confusing to readers. =A0Now, it is loc=
ated
>> after the end of the explanation of mnemonicprefix, which makes much
>> more sense.
>>
>> Signed-off-by: Mark Lodato <lodatom@gmail.com>
>> ---
>> =A0Documentation/config.txt | =A0 =A05 +++--
>> =A01 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index d294dd6..d82c0da 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -813,8 +813,6 @@ diff.mnemonicprefix::
>> =A0 =A0 =A0 standard "a/" and "b/" depending on what is being compar=
ed. =A0When
>> =A0 =A0 =A0 this configuration is in effect, reverse diff output als=
o swaps
>> =A0 =A0 =A0 the order of the prefixes:
>> -diff.noprefix::
>> - =A0 =A0 If set, 'git diff' does not show any source or destination=
 prefix.
>> =A0`git diff`;;
>> =A0 =A0 =A0 compares the (i)ndex and the (w)ork tree;
>> =A0`git diff HEAD`;;
>> @@ -826,6 +824,9 @@ diff.noprefix::
>> =A0`git diff --no-index a b`;;
>> =A0 =A0 =A0 compares two non-git things (1) and (2).
>>
>> +diff.noprefix::
>> + =A0 =A0 If set, 'git diff' does not show any source or destination=
 prefix.
>> +
>> =A0diff.renameLimit::
>> =A0 =A0 =A0 The number of files to consider when performing the copy=
/rename
>> =A0 =A0 =A0 detection; equivalent to the 'git diff' option '-l'.
>
> Good eyes, thanks. =A0How did that happen I wonder...
>
