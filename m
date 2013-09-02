From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3 07/11] Documentation/replace: tell that -f option bypasses the type check
Date: Mon, 2 Sep 2013 23:13:49 +0100
Organization: OPDS
Message-ID: <857C171CD0E84268B296C9F3FCDFB277@PhilipOakley>
References: <70F5C527E29F43A9BE85694F560E01A9@PhilipOakley> <20130901.134900.829124962244710553.chriscool@tuxfamily.org> <29D8721CD44F4C3180D6F1BA5CDCF38E@PhilipOakley> <20130902.081157.986549849748779440.chriscool@tuxfamily.org> <66A16BF0137D40568A34C316DDA6D32E@PhilipOakley> <20130902215545.GA2668@elie.Belkin>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Christian Couder" <chriscool@tuxfamily.org>, <gitster@pobox.com>,
	<git@vger.kernel.org>, <trast@inf.ethz.ch>, <j6t@kdbg.org>
To: "Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 00:13:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGcNU-0005NH-7A
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 00:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757028Ab3IBWNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 18:13:40 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:23287 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752221Ab3IBWNj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Sep 2013 18:13:39 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AiQMAFAMJVJOl3GZ/2dsb2JhbABagweJa7gCBAQBgSsXdGgBAYEfAQEUAQQBAQUIAQEuHgEBIQsCAwUCAQMOBwMJJRQBBAgSBgcXBhMIAgECAwGFOAcBghINAxOvRQ2JRo0Jgm2DJIEAA4h9hhKGfY4ghS+BOimBPjs
X-IPAS-Result: AiQMAFAMJVJOl3GZ/2dsb2JhbABagweJa7gCBAQBgSsXdGgBAYEfAQEUAQQBAQUIAQEuHgEBIQsCAwUCAQMOBwMJJRQBBAgSBgcXBhMIAgECAwGFOAcBghINAxOvRQ2JRo0Jgm2DJIEAA4h9hhKGfY4ghS+BOimBPjs
X-IronPort-AV: E=Sophos;i="4.89,1009,1367967600"; 
   d="scan'208";a="84066520"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip07ir2.opaltelecom.net with SMTP; 02 Sep 2013 23:13:38 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233663>

From: "Jonathan Nieder" <jrnieder@gmail.com>
> Hi,
>
> Philip Oakley wrote:
>
>> Does `hash-object` do the inverese of `cat-file commit`?
>>
>> I didn't find the hash-object(1) man page very informative on that 
>> matter
>
> Hm.  The manpage says:
>
> Computes the object ID value for an object with specified type
> with the contents of the named file [...], and optionally writes
> the resulting object into the object database.
>
> And then:
>
> -w
> Actually write the object into the object database.
>
> Any ideas for making this clearer?

The problem is the file format, in the sense that the earlier `git 
cat-file commit $orig` has a human readable output which is a 
description of the commit header, rather than the specific binary 
content. I couldn't tell if the command would cope with such a human 
readable file.

In Christian's quick untested script he'd matched the two commands as 
opposites, which doesn't appear to be the case, and I'm somewhat 
ignorant of what hash-object is doing - I'd expect that it simply hashed 
the already constructed data, but my ignorance starts showing at this 
point ;-)

regards

Philip 
