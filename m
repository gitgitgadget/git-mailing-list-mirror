From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: storing cover letter of a patch series?
Date: Thu, 10 Sep 2015 23:20:55 +0100
Organization: OPDS
Message-ID: <A29E37E55E524B9FACB67EC05486A178@PhilipOakley>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com> <74514591d4cd502eee06cde3e099e656@dscho.org> <CA+P7+xrH6v7AVaH_su2X3xx7qs_uws-r-DozzYELm_O8g+oN9A@mail.gmail.com> <5f1102c0fcdb3530148ae7a6a18bd0a7@dscho.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Johannes Schindelin" <johannes.schindelin@gmx.de>,
	"Jacob Keller" <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 00:20:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaACC-0005iY-4d
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 00:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbbIJWTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 18:19:51 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:42303 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750764AbbIJWTv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2015 18:19:51 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BDIwBlAfJVPDkqFlxdGQEBgwhUaYdCt3CFbQQEAoFUTQEBAQEBAQcBAQEBQAE/QQECAoNYBQEBAQEDCAEBLh4BASELAgMFAgEDFQMJJRQBBBoGBwMUBgESCAIBAgMBiAgDFgm+Wo0xAQEIAgEbBIZzhHuCT4FaEQFRgx+BFAWNMIgmAYEVg3SiaIRkPTOCdIMKgQyBPwEBAQ
X-IPAS-Result: A2BDIwBlAfJVPDkqFlxdGQEBgwhUaYdCt3CFbQQEAoFUTQEBAQEBAQcBAQEBQAE/QQECAoNYBQEBAQEDCAEBLh4BASELAgMFAgEDFQMJJRQBBBoGBwMUBgESCAIBAgMBiAgDFgm+Wo0xAQEIAgEbBIZzhHuCT4FaEQFRgx+BFAWNMIgmAYEVg3SiaIRkPTOCdIMKgQyBPwEBAQ
X-IronPort-AV: E=Sophos;i="5.17,507,1437433200"; 
   d="scan'208";a="798663224"
Received: from host-92-22-42-57.as13285.net (HELO PhilipOakley) ([92.22.42.57])
  by out1.ip01ir2.opaltelecom.net with SMTP; 10 Sep 2015 23:19:49 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277644>

From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> On 2015-09-10 23:00, Jacob Keller wrote:
>> On Thu, Sep 10, 2015 at 11:58 AM, Johannes Schindelin
>> <johannes.schindelin@gmx.de> wrote:
>>>
>>> On 2015-09-10 18:28, Jacob Keller wrote:
>>>
>>>> does anyone know of any tricks for storing a cover letter for a 
>>>> patch
>>>> series inside of git somehow?
>>>
>>> It is not stored as a blob, but I use `git 
>>> branch --edit-description` to write the cover letter for patch 
>>> series when I expect a couple of iterations.
>>
>> Does this (or can it?) get used by send-email or format-patch's
>> --cover-letter? This sounds like exactly what I want.
>
> Yes, format-patch picks it up if you say `--cover-letter`.
>

I didn't know that. It doesn't appear to be mentioned in the man pages.

IIUC https://github.com/git/git/blob/master/builtin/log.c#L971 suggests 
that it is a deliberate extra inclusion, rather than being part of the 
shortlog and diffstat mentioned in the manual 
https://github.com/git/git/blob/master/Documentation/git-format-patch.txt#L216

Sounds like it may be a worthwhile doc patch.
--
Philip 
