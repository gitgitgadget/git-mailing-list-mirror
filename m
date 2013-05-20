From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH 1/2] Doc rebase: Describe rebase as excluding merge commits
Date: Mon, 20 May 2013 22:55:21 +0100
Organization: OPDS
Message-ID: <2F59222ECBA14673815BF42E6A7CE5A5@PhilipOakley>
References: <1368964329-1600-1-git-send-email-philipoakley@iee.org><1368964329-1600-2-git-send-email-philipoakley@iee.org><20130519180804.GE3362@elie.Belkin> <7v1u92xnuw.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 20 23:55:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeY3D-0006Pp-Vw
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 23:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758249Ab3ETVzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 17:55:20 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:8193 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757019Ab3ETVzT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 May 2013 17:55:19 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArkNAJWamlFOl3mN/2dsb2JhbABagwiJKrhLBAEDAYECF3SCGgUBAQQBCAEBLh4BASELAgMFAgEDFQECCSUUAQQIEgYHFwYBEggCAQIDAYdqAwkKs1cNiFmMSoFtaoJ6YQOIZ4YBhmqOA4UjgxA7
X-IronPort-AV: E=Sophos;i="4.87,709,1363132800"; 
   d="scan'208";a="410307068"
Received: from host-78-151-121-141.as13285.net (HELO PhilipOakley) ([78.151.121.141])
  by out1.ip04ir2.opaltelecom.net with SMTP; 20 May 2013 22:55:17 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224985>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Monday, May 20, 2013 5:43 AM
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Philip Oakley wrote:
>>
>>> Describe rebase in the description section.
>>
>> It already does that. :)  I think you mean "start with a summary",
>> which is a valuable improvement.
>
> It indeed is a good idea to give the "high-level introduction" at
> the very beginning, but I do not think it should describe only one
> of the three major modes of "git rebase" (i.e. no -m, no -i), like
> the proposed patch text does.  We should instead say what it is used
> for and why the user would want to use it that is common across
> these modes at a very high level.

That would repeat the NAME issue (of trying too hard to be exact & 
precise). This introductory text is that "summary". The patch 2/2 should 
be the one for the extra detail of the various whys and wherefores - at 
least that was my intent.

>
>> DESCRIPTION
>> -----------
>> <brief description of the purpose of the command, including some 
>> token
>> mention of *why* a user would want to use it (e.g., "so that the 
>> patches
>> apply cleanly to their new base").>
>
> Exactly.
> --
