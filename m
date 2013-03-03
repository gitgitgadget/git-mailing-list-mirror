From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 2/5] Help.c use OPT_COUNTUP
Date: Sun, 3 Mar 2013 23:54:11 -0000
Organization: OPDS
Message-ID: <EE36F065A5DA4769989FC7345DF7BCE6@PhilipOakley>
References: <1362342072-1412-1-git-send-email-philipoakley@iee.org> <1362342072-1412-3-git-send-email-philipoakley@iee.org> <7vwqtoyryp.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 04 00:53:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCIj2-00055n-IC
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 00:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786Ab3CCXx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 18:53:27 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:28569 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753834Ab3CCXx0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Mar 2013 18:53:26 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgMFAMLhM1FZ8rke/2dsb2JhbABFjAy2PnsXc4IaBQEBBAEIAQEuHgEBIQUGAgMFAgEDEQQBAQolFAEEGgYHDwgGEwgCAQIDAYd8CscwjUp0Xw2CWWEDiDaFZJIQhwiDCIFp
X-IronPort-AV: E=Sophos;i="4.84,776,1355097600"; 
   d="scan'208";a="416143619"
Received: from host-89-242-185-30.as13285.net (HELO PhilipOakley) ([89.242.185.30])
  by out1.ip03ir2.opaltelecom.net with SMTP; 03 Mar 2013 23:53:24 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217379>

[Sorry if the resend with Cc: crossed over]
From: "Junio C Hamano" <gitster@pobox.com>
Sent: Sunday, March 03, 2013 11:38 PM
Subject: Re: [PATCH v2 2/5] Help.c use OPT_COUNTUP


> Philip Oakley <philipoakley@iee.org> writes:
>
>> rename deprecated option in preparation for 'git help --guides'.
>
> s/rename/Rename/;

OK.
>
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>
> Hrm, I do not recall anybody ever declared that "--all" is deprecated.

No, it was the use OPT_COUNTUP rather than OPT_BOOLEAN that the 
'deprecated' was refering to.
Maybe be I should have extended what option was being refered to.

>
> I do not think we want --all and --all --all to be different, and we
> certainly do not want --all --no-all to be not-all, so I cannot tell
> what you want to achieve with this change at all, either from the
> patch or the proposed log message.
>
>>  builtin/help.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/help.c b/builtin/help.c
>> index d1d7181..d10cbed 100644
>> --- a/builtin/help.c
>> +++ b/builtin/help.c
>> @@ -39,7 +39,7 @@ static int show_all = 0;
>>  static unsigned int colopts;
>>  static enum help_format help_format = HELP_FORMAT_NONE;
>>  static struct option builtin_help_options[] = {
>> - OPT_BOOLEAN('a', "all", &show_all, N_("print all available 
>> commands")),
>> + OPT_COUNTUP('a', "all", &show_all, N_("print all available 
>> commands")),
>>  OPT_SET_INT('m', "man", &help_format, N_("show man page"), 
>> HELP_FORMAT_MAN),
>>  OPT_SET_INT('w', "web", &help_format, N_("show manual in web 
>> browser"),
>>  HELP_FORMAT_WEB),
