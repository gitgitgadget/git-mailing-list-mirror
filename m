From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] Documentation: Add target to build PDF manpages
Date: Tue, 24 Mar 2015 23:28:27 -0000
Organization: OPDS
Message-ID: <DA8ADE6265034B1186A4D63318C6EF3C@PhilipOakley>
References: <1426850584-9951-1-git-send-email-thosch97@gmail.com>	<CAGZ79ka7tPA17Y-vPPp5W_4-0UMnHMfM9+eQ8jc4eu23FpM2ug@mail.gmail.com>	<xmqq4mpfe7xm.fsf@gitster.dls.corp.google.com>	<CAGZ79kaDnRiUQ6=3gVvsPrkSzkNbACRvgQBSo8gmpRZ8bka84g@mail.gmail.com> <xmqqmw37cn18.fsf@gitster.dls.corp.google.com> <55103565.9040000@drmicha.warpmail.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-15";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Thomas Schneider" <thosch97@gmail.com>, <git@vger.kernel.org>
To: "Michael J Gruber" <git@drmicha.warpmail.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Stefan Beller" <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 00:27:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaYEb-000613-Km
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 00:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbbCXX1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 19:27:41 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:35958 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751899AbbCXX1k (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2015 19:27:40 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DeGQAj8hFVPHgvBlxcgwZSWocsvyOFbQEDAQGBTE0BAQEBAQEGAQEBATggG0EBg00GAQUIAQEuHgEBDxILAgMFAgEDFQwlFAEEGgYHAxQGARIIAgECAwGICgMVCbVCjXIhhTABAQgCIIshhHaDHoEWBZBQYYMOhxs6hU+NCIQQPjEBAQGCQAEBAQ
X-IPAS-Result: A2DeGQAj8hFVPHgvBlxcgwZSWocsvyOFbQEDAQGBTE0BAQEBAQEGAQEBATggG0EBg00GAQUIAQEuHgEBDxILAgMFAgEDFQwlFAEEGgYHAxQGARIIAgECAwGICgMVCbVCjXIhhTABAQgCIIshhHaDHoEWBZBQYYMOhxs6hU+NCIQQPjEBAQGCQAEBAQ
X-IronPort-AV: E=Sophos;i="5.11,461,1422921600"; 
   d="scan'208";a="673136739"
Received: from host-92-6-47-120.as43234.net (HELO PhilipOakley) ([92.6.47.120])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 24 Mar 2015 23:27:38 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266237>

From: "Michael J Gruber" <git@drmicha.warpmail.net>
> Junio C Hamano venit, vidit, dixit 20.03.2015 23:38:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> Thomas referencing reading the man page offline, made me wonder
>>> why you wouldn't read the man pages itself as they can also be
>>> carried around offline. But the striking point is "on an iPad", 
>>> which
>>> doesn't offer you the convenience of a shell etc, but pdf is fine to 
>>> read
>>> there. Also you can add comments to pdfs more easily that html pages
>>> I'd guess.
>>>
>>> So the patch makes sense to me now. It's just a use case I'm 
>>> personally
>>> not interested in for now, but I don't oppose it as is.
>>
>> Well, my comment was not about opposing to it, but was about
>> questioning the usefulness of it, iow, who would
>> benefit from having this patch in my tree?
>>
>> I didn't see (and I still do not quite see) why people would want to
>> have separate pdf files for all the subcommands (instead of say an
>> .epub or .pdf that binds all the man pages and perhaps user-manual,
>> just like we do for .texi/.info).
>
> Exactly. For PDF, a combined document is more natural and will 
> hopefully
> make crosslinks work as crossrefs within one document, rather than 
> links
> to external documents. I'd say that would make a valuable target.

As per the original request, it is useful to some, and the usefulness of 
a very large pdf containing all the documentation shouldn't be a reason 
to not have such a 'one at a time' target available (though personally I 
would suggest that it is the users responsibility to 'make' such a 
target, not the maintainers!).

The single large pdf has also been discussed 
(http://thread.gmane.org/gmane.comp.version-control.git/207151/focus=207165) 
but didn't get into the code base either.

The user-manual is available as a pdf target.

Philip 
