From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] doc git: multivar configuration parameters append to existing values
Date: Mon, 16 Jun 2014 20:42:42 +0100
Organization: OPDS
Message-ID: <3757CE4412D345B6BE1E515F8764747D@PhilipOakley>
References: <1402922952-172-1-git-send-email-philipoakley@iee.org> <539F38DF.3090004@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	"Robert Clausecker" <fuz@fuz.su>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
To: "Tanay Abhra" <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 21:42:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwcnl-0008P5-BJ
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 21:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755333AbaFPTml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 15:42:41 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:33205 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752199AbaFPTml (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2014 15:42:41 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: An8XAHASn1NZ8Y0l/2dsb2JhbABagw2JU7puBQECAQGBERd1g34FAQEFCAEBLh4BASELAgMFAgEDFQMJJRQBBAgSBgcXBhMIAgECAwGIHQMVuCyREQ2FYReMU4IjgzSBFgSKBYZah2uPUYYAg0E8
X-IPAS-Result: An8XAHASn1NZ8Y0l/2dsb2JhbABagw2JU7puBQECAQGBERd1g34FAQEFCAEBLh4BASELAgMFAgEDFQMJJRQBBAgSBgcXBhMIAgECAwGIHQMVuCyREQ2FYReMU4IjgzSBFgSKBYZah2uPUYYAg0E8
X-IronPort-AV: E=Sophos;i="5.01,489,1400022000"; 
   d="scan'208";a="462760301"
Received: from host-89-241-141-37.as13285.net (HELO PhilipOakley) ([89.241.141.37])
  by out1.ip04ir2.opaltelecom.net with SMTP; 16 Jun 2014 20:42:39 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251807>

From: "Tanay Abhra" <tanayabh@gmail.com>
> On 06/16/2014 05:49 AM, Philip Oakley wrote:
>
>>  Pass a configuration parameter to the command. The value
>> - given will override values from configuration files.
>> + given will override single valued variables from configuration
>> + files, and append to multivar variables. Previous multivar values
>
> Nit: Forgive me if I am wrong, but `, and` is used for joining two 
> independent
> clauses. It would be better to drop the comma.
I just wrote it in my local style ;-)  I was sort of treating them as 
independent, but see Junio's comments in a similar vein.

>
>> + remain in effect. Use "insteadOf" style config variables when an
>> + over-ride is needed.
>>  The <name> is expected in the same format as listed by
>>  'git config' (subkeys separated by dots).
>>
>>
>
> 'insteadOf' is a very specific approach for a general suggestion 
> because it is only
> used in url.*.insteadof in the whole codebase. Also, it has a 
> variation described in
> urls.txt as "pushinsteadof". So, if a problem such as mentioned above 
> arises in
> a different scenario 'insteadOf' cannot be used in it.
I was using it as a suggestion for the user's 'go look for an 
alternative' step (i.e. that there may be an alternative!)

--
Philip 
