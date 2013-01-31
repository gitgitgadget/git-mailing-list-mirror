From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 2/7] Undocument deprecated alias 'push.default=tracking'
Date: Thu, 31 Jan 2013 20:41:42 -0000
Organization: OPDS
Message-ID: <C3D8C713BDBF41CDA0BC3469316FF119@PhilipOakley>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr> <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr> <1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr> <CACBZZX552fnD+u9Zp-BhqDyYWN+OiyvCyub-xjMZ-_GXCG-vQA@mail.gmail.com> <7vvcadgss0.fsf@alter.siamese.dyndns.org> <20130131190747.GE27340@google.com> <7vip6dgmx2.fsf@alter.siamese.dyndns.org> <20130131200434.GI27340@google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>, <git@vger.kernel.org>,
	"Jeff King" <peff@peff.net>,
	"Michael Haggerty" <mhagger@alum.mit.edu>
To: "Jonathan Nieder" <jrnieder@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 21:41:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U10xE-0007x0-SH
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 21:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977Ab3AaUl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 15:41:28 -0500
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:30613 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751523Ab3AaUl1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jan 2013 15:41:27 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlYJAKTVClFcHmfN/2dsb2JhbABFjAWyHwR/F3OCGQUBAQUIAQEuHgEBIQsCAwUCAQMOBwECCSUUAQQIEgYHFwYBEggCAQIDAYduAxO4VA2JVowUgSKCdWEDiC+FU4Y5jRGFEoJ7
X-IronPort-AV: E=Sophos;i="4.84,579,1355097600"; 
   d="scan'208";a="61296072"
Received: from host-92-30-103-205.as13285.net (HELO PhilipOakley) ([92.30.103.205])
  by out1.ip07ir2.opaltelecom.net with SMTP; 31 Jan 2013 20:41:25 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215167>

From: "Jonathan Nieder" <jrnieder@gmail.com>
Sent: Thursday, January 31, 2013 8:04 PM
> Junio C Hamano wrote:
>
>>                                                      For those who
>> want to _learn_ what possibilities are available to them (i.e. they
>> are not going from `tracking` to what it means, but going in the
>> opposite direction), it should be unmistakingly clear that
>> `tracking` is not a part of the choices they should make.
>
> Until pre-1.7.4 versions of git fall out of use, I don't agree that
> the above is true. :(
>
>
>>                                                            I do not
>> think the following list created by a simple "revert" makes it clear.
>>
>>     * `nothing` - do not push anything.
>>     * `matching` - push all branches having the same name in both 
>> ends.
>>     * `upstream` - push the current branch to ...
>>     * `simple` - like `upstream`, but refuses to ...
>>     * `tracking` - deprecated synonym for `upstream`.

>From a simple user perspective, I'd simply place it, in brackets and at 
the end of the list.

e.g.     [* `tracking` - deprecated synonym for `upstream`.]

The leading bracket makes it obvious that it's different, and that the 
description needs to be read, rather than folk simply re-using a half 
remembered option, gleaned from an old blog.

However formatting the leading bracket may not be as easy as the plain 
text version.

>>     * `current` - push the current branch to a branch of the same 
>> name.
>
> How about the following?
>
>    * `nothing` - ...
>    * `matching` - ...
>    * `upstream` - ...
>    * `simple` - ...
>    * `current` - ...
>
>  For compatibility with ancient config files, the following synonym
>  is also supported.  Don't use it.
>
>    * `tracking` - old name for `upstream`

? s/old/deprecated/  or  s/old/outdated/  for those who don't understand 
the jargon. 
