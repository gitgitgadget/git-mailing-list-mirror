From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH] Git doc: GPL2 does not apply to repo data
Date: Mon, 1 Feb 2016 10:53:51 -0000
Organization: OPDS
Message-ID: <82BCD59FE1254625963FF9A6CB98DC51@PhilipOakley>
References: <alpine.DEB.2.20.1601280913450.2964@virtualbox><1454274011-4880-1-git-send-email-philipoakley@iee.org> <xmqq8u35xv00.fsf@gitster.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"Jonathan Smith" <Jonathan.Smith@fphcare.co.nz>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 11:53:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQC7I-00025a-ME
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 11:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbcBAKxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 05:53:53 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:30515 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753252AbcBAKxw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Feb 2016 05:53:52 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DTWgDuN69WPN7OYAJdGQEBAQELAQIBAQEBAYMKUm2HTYELr0ZsgxgkhWEEBAKBM00BAQEBAQEHAQEBAUEkG0EBBAkBg2wFAQEBAQIBCAEBLh4BASEFBgIDBQIBAxUMJRQBBBoGBwMUBhMIAQEBAgMBiAIMCrQciCABAQgCHoYPhDeEFoNHgQ8Fh1OGCokSAYE5jWyHZ4UuimyDUoJkGYFRPC4BAQGDVoIugnYBAQE
X-IPAS-Result: A2DTWgDuN69WPN7OYAJdGQEBAQELAQIBAQEBAYMKUm2HTYELr0ZsgxgkhWEEBAKBM00BAQEBAQEHAQEBAUEkG0EBBAkBg2wFAQEBAQIBCAEBLh4BASEFBgIDBQIBAxUMJRQBBBoGBwMUBhMIAQEBAgMBiAIMCrQciCABAQgCHoYPhDeEFoNHgQ8Fh1OGCokSAYE5jWyHZ4UuimyDUoJkGYFRPC4BAQGDVoIugnYBAQE
X-IronPort-AV: E=Sophos;i="5.22,379,1449532800"; 
   d="scan'208";a="860503030"
Received: from host-2-96-206-222.as13285.net (HELO PhilipOakley) ([2.96.206.222])
  by out1.ip01ir2.opaltelecom.net with SMTP; 01 Feb 2016 10:53:49 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285196>

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> diff --git a/Documentation/git.txt b/Documentation/git.txt
>> index bff6302..137c89c 100644
>> --- a/Documentation/git.txt
>> +++ b/Documentation/git.txt
>> @@ -1132,6 +1132,17 @@ of clones and fetches.
>>    - any external helpers are named by their protocol (e.g., use
>>      `hg` to allow the `git-remote-hg` helper)
>>
>> +Licencing: Your data, and the Git tool[[Licencing]]
>> +---------------------------------------------------
>> +
>> +Git is an open source tool provided under GPL2.
>> +Git was designed to be, and is, the version control system
>> +for the Linux codebase.
>> +Your respository data created by Git is not subject to Git's GNU2
>> +licence, see GPL FAQs
>> +http://www.gnu.org/licenses/old-licenses/gpl-2.0-faq.en.html#TOCGPLOutput).
>> +
>> +User should apply a licence of their own choice to their repository 
>> data.
>>
>>  Discussion[[Discussion]]
>>  ------------------------
>
> While I know you mean well, and I do understand the sentiment behind
> this addition,
It was an RFC for that very sentiment.

>             there are at least two reasons why I do not want to
> (and why we should not) add any "clarification" or "interpretation"
> like this.
>
> One is because such a statement is pointless.  Because we do not do
> copyright assignment to the project, you are not the sole copyright
> owner of Git.  Individual contributors hold copyright to the part
> they wrote.  The above statement you made, even with an endorsement
> by me as the project lead, does not have any power to assure that
> the users will not get sued by one copyright holder, who is not you
> or me, and at that point it is up to the court to interpret GPLv2.
> We can call such a copyright holder crazy or call such a suit
> frivolous, but that does not change the fact that the court is what
> decides the matter, so having that statement does not help the user.
>
> Another is because we are amateurs.  Philip, you may or may not be a
> lawyer yourself,

Correct, but as an Engineer I do get to review terms & conditions and 
specifications quite often..

>    but I know you are not _our_ lawyer.  An amateurish
> "interpretation" or "clarification" does not necessarily clarify the
> text but it muddies it, especially when done carelessly.  Imagine a
> case where a user creates a derived work of Git itself and stored it
> in a Git repository.

>      "Your respository data created by Git is not
> subject to Git's GNU2"--really?  At least the phrasing must say that
> the act of storing something in Git alone would not *MAKE* that
> something governed under GPLv2.

I can see the potential double meaning now you highlight it - I was thinking 
of the 'if it's _your_ data, you can choose'; however if it's not your data, 
the originator's restrictions would apply - that wasn't said.

>     What the user puts in Git may
> already be covered under GPLv2 for other reasons, and a statement
> carelessly written like the above can be twisted to read as if we
> are endorsing use of our code outside GPLv2 as long as they store it
> in Git repository, which is not what you meant to say, but "that is
> not what the copyright holder meant" is another thing the lawyer
> need to argue in court to convince the judge, when we need to go
> after a real copyright violator.
>
> We should leave the lawyering to real lawyers and we should not add
> unnecessary work of interpreting our amateurish loose statement to
> our laywers.

Given Jonathan's question, and your earlier feedback, it did feel that a bit 
of clear blue water would be useful between Git (the DVCS), and /.git/ (the 
repo contents), even if it were only to clarify the issues...

>
> Thanks.
>
--
Philip 
