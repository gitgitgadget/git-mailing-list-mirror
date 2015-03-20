From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] Documentation: Add target to build PDF manpages
Date: Fri, 20 Mar 2015 22:15:06 -0000
Organization: OPDS
Message-ID: <3037A3ADECA54FB2B56348E4F6F04A95@PhilipOakley>
References: <1426850584-9951-1-git-send-email-thosch97@gmail.com><CAGZ79ka7tPA17Y-vPPp5W_4-0UMnHMfM9+eQ8jc4eu23FpM2ug@mail.gmail.com> <xmqq4mpfe7xm.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Thomas Schneider" <thosch97@gmail.com>, <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Stefan Beller" <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 23:14:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ5BU-0002GN-OD
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 23:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbbCTWOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 18:14:24 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:55487 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751174AbbCTWOX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 18:14:23 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DlCgBSmgxVPAu8BlxcgwSBLIY7bcUpBAKBNU0BAQEBAQEGAQEBATggG4QPBQEBAQECAQgBAS4eAQEhBQYCAwUCAQMVDCUUAQQaBgcDFAYBEggCAQIDAYgWDLg9k3csiyGEdYMegRYFimKFbWGKJ4YJjQWEED4xgkMBAQE
X-IPAS-Result: A2DlCgBSmgxVPAu8BlxcgwSBLIY7bcUpBAKBNU0BAQEBAQEGAQEBATggG4QPBQEBAQECAQgBAS4eAQEhBQYCAwUCAQMVDCUUAQQaBgcDFAYBEggCAQIDAYgWDLg9k3csiyGEdYMegRYFimKFbWGKJ4YJjQWEED4xgkMBAQE
X-IronPort-AV: E=Sophos;i="5.11,439,1422921600"; 
   d="scan'208";a="672625610"
Received: from host-92-6-188-11.as43234.net (HELO PhilipOakley) ([92.6.188.11])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 20 Mar 2015 22:14:21 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265974>

From: "Junio C Hamano" <gitster@pobox.com>
> Stefan Beller <sbeller@google.com> writes:
>
>> ... though how would I read man pages in pdf
>> format? I tried searching the web and all I can find is how
>> to convert the a man page to pdf. So is there a conveniant
>> way to tell `man` to prefer opening pdfs when available?
>
> I presume that "man -Tpdf git.1" is not what you are looking for, as
> that would literally be how you get the manpages in PDF format?
>
I'd expect 'git help --pdf git' to simply feed the path of git.pdf 
(probably in the same directory as the .html versions) to the web 
browser and let it determine the users prefered reader.

> Personally, I honestly am not quite sure why anybody wants to
> generate manpages in the PDF format like this patch does, unless
> they are planning to print them on paper, in which case the existing
> manpages (git.1 and friends) or html pages (git.html and friends)
> should be an already available source format.
> --
Despite the scare stories and problems that pdf format can bring it is 
quite popular as a way of 'freezing' what is displayed (I use it a lot 
to capture web confirmations;-), so I don't see it as being too 
outlandish, though I wouldn't expect the project to automatically 
generate the pdfs in the same way the man and web pages are.

--
Philip 
