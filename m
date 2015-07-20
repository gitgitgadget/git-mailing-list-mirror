From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: How to use --cc-cmd in git-send-email?
Date: Mon, 20 Jul 2015 15:20:15 +0100
Organization: OPDS
Message-ID: <28D6CFA8D1964D34B1E7F28325AF94A8@PhilipOakley>
References: <CA64425B296E41328D6A1F29E227A24D@PhilipOakley><CAPig+cTQspD+0StY5tneqwekS3xCjdxcidoDA7Ztf26g-tMucg@mail.gmail.com><8684534127894F239338493A7D15F46D@PhilipOakley> <CAPig+cTsJQ+dK5M0S8LERkPWiipzxLYdbCK6-ghen1OkAX=NBg@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Eric Sunshine" <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 16:19:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHBuh-0002XZ-El
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 16:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754994AbbGTOTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 10:19:23 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:44891 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753047AbbGTOTX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2015 10:19:23 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BnCQAjA61VPHMBFlxcgxOBPYMjgy5tvBkEBAKBKU0BAQEBAQEHAQEBAUABP4QeBQEBAQEDCAEBGRUeAQEhCwIDBQIBAxUDAgIFIQICFAEEGgYHAxQGEwgCAQIDAYghsUqGV48rgSKKKoQjEQFRgm8vgRQFlFIBgQqMWZNjg2GBbwyCKD0xgQ2BPgEBAQ
X-IPAS-Result: A2BnCQAjA61VPHMBFlxcgxOBPYMjgy5tvBkEBAKBKU0BAQEBAQEHAQEBAUABP4QeBQEBAQEDCAEBGRUeAQEhCwIDBQIBAxUDAgIFIQICFAEEGgYHAxQGEwgCAQIDAYghsUqGV48rgSKKKoQjEQFRgm8vgRQFlFIBgQqMWZNjg2GBbwyCKD0xgQ2BPgEBAQ
X-IronPort-AV: E=Sophos;i="5.15,508,1432594800"; 
   d="scan'208";a="794428613"
Received: from host-92-22-1-115.as13285.net (HELO PhilipOakley) ([92.22.1.115])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 20 Jul 2015 15:19:19 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274322>

From: "Eric Sunshine" <sunshine@sunshineco.com>
> On Mon, Jul 20, 2015 at 2:01 AM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> From: "Eric Sunshine" <sunshine@sunshineco.com>
>>> git-send-email invokes the cc-cmd like this:
>>>
>>>    $cc-cmd $patchfilename
>>>
>>> so, when you used 'cat cc-cmd' as the value of --cc-cmd, your 
>>> invocation
>>> became:
>>>
>>>    cat cc-cmd $patchfilename
>>>
>>> and since 'cat' copies the concatenation of its input files to its
>>> output, that explains why you first saw the names from your 'cc-cmd'
>>> file followed by the content of the patch file.
>>
>> Many thanks, that seems to explain everything!
>>
>> I may try and do a small doc patch for the git-send-email.txt man 
>> page (I
>> have a few doc fixes backing up waiting to be done ;-)
>
> That would be welcome. I don't think it's mentioned at all in
> git-send-email.txt that the --to-cmd/--cc-cmd commands are handed the
> patch pathname as an argument, so that's certainly something worth
> documenting.
> --

The other issue I noted was wondering what "auto-cc" is?

It's only mentioned the once in:
    --suppress-cc=<category>

Specify an additional category of recipients to suppress the auto-cc of:

Is it a sort of double negative? Certainly I had no idea what an auto-cc 
was ;-)



Philip
