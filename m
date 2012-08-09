From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 2/4] check-docs: update non-command documentation list
Date: Thu, 9 Aug 2012 07:34:08 +0100
Organization: OPDS
Message-ID: <676126318BF8488DBB65458177CBAC46@PhilipOakley>
References: <20120808183132.GA24550@sigill.intra.peff.net> <20120808183433.GB24574@sigill.intra.peff.net> <7vwr19rxua.fsf@alter.siamese.dyndns.org> <20120808205456.GB29528@sigill.intra.peff.net> <C64F75694EC040349CFE91CD69EDB2DC@PhilipOakley> <7v1ujhq9om.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Matthieu Moy" <Matthieu.Moy@imag.fr>,
	<git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 08:34:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzMJz-0001SY-Dt
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 08:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391Ab2HIGeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 02:34:09 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:22517 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750986Ab2HIGeI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2012 02:34:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AsALAORYI1BcHIOP/2dsb2JhbABFi0CtHwQCAnaBCIIbBQEBBAEIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcXBhMIAgECAwGHdgq8LI0JGIN2YAOIGYVBl36CYA
X-IronPort-AV: E=Sophos;i="4.77,738,1336345200"; 
   d="scan'208";a="44272437"
Received: from host-92-28-131-143.as13285.net (HELO PhilipOakley) ([92.28.131.143])
  by out1.ip07ir2.opaltelecom.net with SMTP; 09 Aug 2012 07:34:05 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203149>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> One issue I notice a few weeks ago is that `git help --all` does not
>> list all of the available git help pages, rather it just limits 
>> itself
>> to the available command pages.
>>
>> This means that new users can't discover those additional help pages
>> in any easy manner.
>
> That would be a problem _only_ if these "additional help pages" are
> of importance for new users.  I do not think things that come from
> Documentation/technical and ARTICLES (in Documentation/Makefile)
> qualify as such.

I'd generally agree with that. I wasn't aware of ARTICLES (in 
Documentation/Makefile), so that's something to I'll need to look at.

>
> I'd be perfectly happy as long as all documents are reachable from
> git.html in html-fied documentation (the man pages have equivalent
> cross references, I think).
>

That is generally the tack I was looking of taking. Part of the task is 
making sure the 'right' pages are found from the 'right' places. So 
that, for the beginner needing help (git help --all),  even the 
'everyday  git in 20 commands' and 'User manual' would be listed in the 
available guides section.

>
> -----
