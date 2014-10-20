From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] doc: fix 'git status --help' character quoting
Date: Mon, 20 Oct 2014 20:28:09 +0100
Organization: OPDS
Message-ID: <DB0FCB7CEC8C453D9237CA4FFA687EDC@PhilipOakley>
References: <1413728235-1504-1-git-send-email-philipoakley@iee.org><xmqqwq7vr91j.fsf@gitster.dls.corp.google.com><8D139BC1FB1E4335B4375FB0F056BB0B@PhilipOakley> <xmqqy4sa3bpk.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 21:28:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgIcd-0001xE-Pq
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 21:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbaJTT14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 15:27:56 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:6787 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751003AbaJTT1z (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Oct 2014 15:27:55 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AsjlANFhRVROl3LyPGdsb2JhbABcgw5TWIhBw3OHQwQBAwEBgRYVAgEBBQEBAQE4IBteAQWBJgEBAYFoAQEGAQEBAwEBBAgBAR0RHgEBIQsCAwUCAQMUAQwlFAEEGgYHAxQGEwgCAQIDAYU4AQEBBYIIAQFoCbdljT4BAQEHAgEfjjqCF4M0gR4FhRUChg2GXV2DaYJEnmk8LwGCSgEBAQ
X-IPAS-Result: AsjlANFhRVROl3LyPGdsb2JhbABcgw5TWIhBw3OHQwQBAwEBgRYVAgEBBQEBAQE4IBteAQWBJgEBAYFoAQEGAQEBAwEBBAgBAR0RHgEBIQsCAwUCAQMUAQwlFAEEGgYHAxQGEwgCAQIDAYU4AQEBBYIIAQFoCbdljT4BAQEHAgEfjjqCF4M0gR4FhRUChg2GXV2DaYJEnmk8LwGCSgEBAQ
X-Header: TalkTalk
X-IronPort-AV: E=Sophos;i="5.04,757,1406588400"; 
   d="scan'208";a="2741907"
Received: from host-78-151-114-242.as13285.net (HELO PhilipOakley) ([78.151.114.242])
  by out1.ip02ir2.opaltelecom.net with SMTP; 20 Oct 2014 20:27:51 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Junio C Hamano" <gitster@pobox.com>
>>> Philip Oakley <philipoakley@iee.org> writes:
>>>
...
> [ (ASCII 0) change]
>> The reason I proposed the change is because on the web view, on my
>> machine, I questioned whether the specially formatted character
>> (remember its quotation is consumed by ascidoc) looked too much like
>> an Oh, so I specially checked on the original .txt to see if it was
>> correct there, which led me to the proposal for '00' in this case.
>>
>> I'd be just as happy with a single zero, as long as it's distinct 
>> from
>> O (as you probably know, in the depths of hsitory typewriters didn't
>> even have 0 and 1 keys - the O and l were used interchangably and 
>> many
>> fonts keep too much to that pattern of undifferetiability!)
>
> Yes, and that is why I said
>
>>> there is
>>> no risk for anybody to mistake "O" (oh) as part of digits, whether
>>> you use decimal or hexadecimal.
>
> ;-)
>
>> Note the more recent http://git-scm.com/docs/git-status has the
>> formatted round o and
>
> I think it is just the font. I just opened the above page with
> Chrome and futzed the text from '0' to '0123456789' to see how it
> look.  That round thing is consistent with how other digits are
> rendered.
>
> https://plus.google.com/u/0/+JunioCHamano/posts/dzNXV2FwP6K
>
> (sorry for a URL to plus)
>
>> https://www.kernel.org/pub/software/scm/git/docs/git-status.html
>> (which IIUC is out of date) has an unformatted 0.
> --

I've just had a look at how it formats when the zero is back-tick quoted 
s /ASCII 0/ASCII `0`/ and it looks OK with both Chromium and Firefox on 
my hack Ubuntu laptop - the character is colourised and full sized, and 
the --man page output looks unchanged and clearly a zero.

my hacky attempt at an in-line patch (squash in?) below:
--
Philip
----->8----
commit 51ec35a196057eae60bb9285c38fb22e49aae1b0
Author: Philip Oakley <philipoakley@iee.org>
Date:   Mon Oct 20 20:21:56 2014 +0100

    doc: 'git status' quote the zero (NUL) character

    Newer web rendering of 'git status --help --web' shows the zero in
    "NUL (ASCII 0)" as if it is a small 'o' character. Back-tick quote 
the
    zero to ensure it is displayed as a full size mono-spaced font.

    Signed-off-by: Philip Oakley <philipoakley@iee.org>

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 4d8d530..379aa08 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -189,7 +189,7 @@ There is also an alternate -z format recommended for 
machine parsing. In
 that format, the status field is the same, but some other things
 change.  First, the '\->' is omitted from rename entries and the field
 order is reversed (e.g 'from \-> to' becomes 'to from'). Second, a NUL
-(ASCII 0) follows each filename, replacing space as a field separator
+(ASCII `0`) follows each filename, replacing space as a field separator
 and the terminating newline (but a space still separates the status
 field from the first filename).  Third, filenames containing special
 characters are not specially formatted; no quoting or 
