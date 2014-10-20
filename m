From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] doc: fix 'git status --help' character quoting
Date: Mon, 20 Oct 2014 11:46:30 +0100
Organization: OPDS
Message-ID: <8D139BC1FB1E4335B4375FB0F056BB0B@PhilipOakley>
References: <1413728235-1504-1-git-send-email-philipoakley@iee.org> <xmqqwq7vr91j.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 12:46:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgATk-0006Nh-Au
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 12:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671AbaJTKqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 06:46:18 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:8742 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753656AbaJTKqP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Oct 2014 06:46:15 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtaPAHvnRFROl3LyPGdsb2JhbABcgw5TiRnDZ4dDBAEDAQGBERUCAQEFAQEBATggG4N9BQEBAQECAQgBAR0RHgEBIQUGAgMFAgEDFQwlFAEEGgYHAxQGEwgCAQIDAYgmDAm1CY0VDCCOOoIXgzSBHgWLJIZcXYNpoS08LwGCSgEBAQ
X-IPAS-Result: AtaPAHvnRFROl3LyPGdsb2JhbABcgw5TiRnDZ4dDBAEDAQGBERUCAQEFAQEBATggG4N9BQEBAQECAQgBAR0RHgEBIQUGAgMFAgEDFQwlFAEEGgYHAxQGEwgCAQIDAYgmDAm1CY0VDCCOOoIXgzSBHgWLJIZcXYNpoS08LwGCSgEBAQ
X-Header: TalkTalk
X-IronPort-AV: E=Sophos;i="5.04,755,1406588400"; 
   d="scan'208";a="648833412"
Received: from host-78-151-114-242.as13285.net (HELO PhilipOakley) ([78.151.114.242])
  by out1.ip06ir2.opaltelecom.net with SMTP; 20 Oct 2014 11:46:11 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> Correct backtick quoting for some of the modification states to give
>> consistent web rendering.
>
> This is to match the way how "XY PATH1 -> PATH2" is typeset, I
> presume.  Some in the body text are already `XY` to match, but some
> others are not,
> and you are fixing them, all of which look good.

Do you need me to add this to the commit message?

>
>> While at it, use 00 for ASCII NUL to avoid any confusion with the 
>> letter O.
>
> I do not think this is particularly a good change.  We try to follow
> the convention of spelling ASCII value in decimal (e.g. "ASCII
> double quote (34)"), and "00" is not the way how you usually spell a
> number in decimal.  Existing description is perfectly fine;

> there is
> no risk for anybody to mistake "O" (oh) as part of digits, whether
> you use decimal or hexadecimal.

The reason I proposed the change is because on the web view, on my 
machine, I questioned whether the specially formatted character 
(remember its quotation is consumed by ascidoc) looked too much like an 
Oh, so I specially checked on the original .txt to see if it was correct 
there, which led me to the proposal for '00' in this case.

I'd be just as happy with a single zero, as long as it's distinct from O 
(as you probably know, in the depths of hsitory typewriters didn't even 
have 0 and 1 keys - the O and l were used interchangably and many fonts 
keep too much to that pattern of undifferetiability!)

Note the more recent http://git-scm.com/docs/git-status has the 
formatted round o and 
https://www.kernel.org/pub/software/scm/git/docs/git-status.html (which 
IIUC is out of date) has an unformatted 0.

Looking around some more, it's as if "0)" is special cased in some 
conversion to HTML.

>
> If you have an aversion to mentioning ASCII when clarifying which
> character we talk about, you could of course do s/ASCII 0/'\0'/ but
> I do not know if that is an improvement.
>
--
Philip 
