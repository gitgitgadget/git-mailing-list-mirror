From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 1/1] po/README: split out the different contribution types
Date: Mon, 3 Aug 2015 14:49:37 +0100
Organization: OPDS
Message-ID: <66FDED7A4D18442A8DF6A35A22B256CC@PhilipOakley>
References: <1438522955-6076-1-git-send-email-philipoakley@iee.org><1438522955-6076-2-git-send-email-philipoakley@iee.org> <CANYiYbFvackgJnqR4yahUPT2zE-kTAhQJnvzeUp-FsC-U24-dw@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Jiang Xin" <worldhello.net@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jiang Xin" <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 15:48:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMG6Z-0003AK-1V
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 15:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbbHCNse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 09:48:34 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:41077 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751288AbbHCNsd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Aug 2015 09:48:33 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2A6CAC2cL9VPLQhBlxbGQEBAYJ+VGmDI4QbtxyFcwQEAoErTQEBAQEBAQcBAQEBQSQbhB4GAQEECAEBGRUeAQEhCwIDBQIBAw4HBQIFIQICFAEECBIGBwMUBhMIAgECAwGICAMWCbRMhliJTQ2FMQELHASBIootgk+COYJwL4EUBYcZjWABgQ6DbIVmgzKEIItAcoNLg2SEJD0xgkwBAQE
X-IPAS-Result: A2A6CAC2cL9VPLQhBlxbGQEBAYJ+VGmDI4QbtxyFcwQEAoErTQEBAQEBAQcBAQEBQSQbhB4GAQEECAEBGRUeAQEhCwIDBQIBAw4HBQIFIQICFAEECBIGBwMUBhMIAgECAwGICAMWCbRMhliJTQ2FMQELHASBIootgk+COYJwL4EUBYcZjWABgQ6DbIVmgzKEIItAcoNLg2SEJD0xgkwBAQE
X-IronPort-AV: E=Sophos;i="5.15,601,1432594800"; 
   d="scan'208";a="795243132"
Received: from host-92-6-33-180.as43234.net (HELO PhilipOakley) ([92.6.33.180])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 03 Aug 2015 14:48:30 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275167>

From: "Jiang Xin" <worldhello.net@gmail.com>
> 2015-08-02 21:42 GMT+08:00 Philip Oakley <philipoakley@iee.org>:
>> Separate out the three different contribution styles for existing, 
>> new,
>> and wider mis-translation contributions, with suitable headings for 
>> easy
>> reference.
>>
>> In particular highlight the appropriate action should a Git
>> mis-translation be from a different distribution. i.e. initially 
>> report
>> to that usptream, but also consider if it could be coordinated here.
>>
>> While here, add surrounding headings, and reference the lanaguage 
>> codes.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>  po/README | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/po/README b/po/README
>> index d8c9111..b54b3c6 100644
>> --- a/po/README
>> +++ b/po/README
>> @@ -10,19 +10,43 @@ coordinates our localization effort in the l10 
>> coordinator repository:
>>
>>          https://github.com/git-l10n/git-po/
>>
>> +The two character language translation codes are defined by 
>> ISO_639-1, as
>> +stated in the gettext(1) full manual, appendix A.1, Usual Language 
>> Codes.
>> +
>> +
>> +Contributing to an existing translation
>> +---------------------------------------
>>  As a contributor for a language XX, you should first check TEAMS 
>> file in
>>  this directory to see whether a dedicated repository for your 
>> language XX
>>  exists. Fork the dedicated repository and start to work if it 
>> exists.
>>
>> +
>> +Creating a new language translation
>> +-----------------------------------
>>  If you are the first contributor for the language XX, please fork 
>> this
>>  repository, prepare and/or update the translated message file 
>> po/XX.po
>>  (described later), and ask the l10n coordinator to pull your work.
>>
>> +
>> +Reporting mis-translations
>> +--------------------------
>> +First, confirm that your language translation is managed by this 
>> group.
>> +Initially any translation mistake should be reported to the 
>> appropriate
>> +upstream team. If not managed by this group, and the translation has 
>> a
>> +suitable licence, consider suggesting that the translation could be
>> +included here (see 'new language translation' above).
>> +
> First, find the right place to report.  If there is a YourLanguage.po 
> here,
> and you can find the bug in it, then here is the right place for you 
> to
> report.  But if not, maybe your Git distribution (such as from Ubuntu)
> may have its own l10n workflow, and not work well with our git
> upstream. For this case, you should report bug to them...
>
> (I'm not a native English speaker, so correct me)
>

Thanks. I'll work up your comments and try sending a formal V2 patch
 to the list. I'll also include about other workflows for other 
distributions.

Would I be right that there were no issues with the splitting into the 
separate headings?

>> +
>> +Forming a Team
>> +--------------
>>  If there are multiple contributors for the same language, please 
>> first
>>  coordinate among yourselves and nominate the team leader for your
>>  language, so that the l10n coordinator only needs to interact with 
>> one
>>  person per language.
>>
>> +
>> +Translation Process Flow
>> +------------------------
>>  The overall data-flow looks like this:
>>
>>      +-------------------+            +------------------+
>> --
>> 2.3.1
>>
>
> -- 
> Jiang Xin
>
--
Philip 
