From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3 10/25] Add new environment variable $GIT_COMMON_DIR
Date: Wed, 26 Feb 2014 16:12:01 -0000
Organization: OPDS
Message-ID: <6CF0FBAC168D48BA901A31901FAD0C3E@PhilipOakley>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com> <1392730814-19656-11-git-send-email-pclouds@gmail.com> <CAPig+cRPpdfNYP=8o+9ku7Lr6bQ3EBiFQcS_aM4YBVhCbuJ3sQ@mail.gmail.com> <CACsJy8CSZZptDr6rWTNES1peDrkk5k7Ai9mzQvSBDZz7FGJxLA@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Duy Nguyen" <pclouds@gmail.com>,
	"Eric Sunshine" <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 17:12:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIh5U-0004lp-Tv
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 17:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbaBZQL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 11:11:56 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:55799 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751790AbaBZQL4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Feb 2014 11:11:56 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuwZAOcRDlNZ8Yi5/2dsb2JhbABagwY7g1qFPrgrAQECAQGBGRd0aQEBgR8BARYBBAEBBQgBARkVHgEBIQsCAwUCAQMOBwMCAgUhAgIUAQQIEgYHFwYBEggCAQIDAYU4BwGCBw0DFQmoKJkrDYdAF4EpixUbgXuCdTWBFASPLYccjD+CD4VHgy08
X-IPAS-Result: AuwZAOcRDlNZ8Yi5/2dsb2JhbABagwY7g1qFPrgrAQECAQGBGRd0aQEBgR8BARYBBAEBBQgBARkVHgEBIQsCAwUCAQMOBwMCAgUhAgIUAQQIEgYHFwYBEggCAQIDAYU4BwGCBw0DFQmoKJkrDYdAF4EpixUbgXuCdTWBFASPLYccjD+CD4VHgy08
X-IronPort-AV: E=Sophos;i="4.97,548,1389744000"; 
   d="scan'208";a="455556788"
Received: from host-89-241-136-185.as13285.net (HELO PhilipOakley) ([89.241.136.185])
  by out1.ip02ir2.opaltelecom.net with SMTP; 26 Feb 2014 16:11:54 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242733>

From: "Duy Nguyen" <pclouds@gmail.com>
> On Wed, Feb 26, 2014 at 8:24 AM, Eric Sunshine 
> <sunshine@sunshineco.com> wrote:
>>> +'GIT_COMMON_DIR'::
>>> +       If this variable is set to a path, non-worktree files that 
>>> are
>>> +       normally in $GIT_DIR will be taken from this path
>>> +       instead. Worktree-specific files such as HEAD or index are
>>> +       taken from $GIT_DIR. This variable has lower precedence than
>>> +       other path variables such as GIT_INDEX_FILE,
>>> +       GIT_OBJECT_DIRECTORY...
>>
>> For a person not familiar with "git checkout --to" or its underlying
>> implementation, this description may be lacking. Such a reader may be
>> left wondering about GIT_COMMON_DIR's overall purpose, and when and
>> how it should be used. Perhaps it would make sense to talk a bit 
>> about
>> "git checkout --to" here?
>
> I don't want to repeat too much. Maybe mention about "git checkout
> --to" and point them to git-checkout man page?

I've just looked at both 
https://www.kernel.org/pub/software/scm/git/docs/git-checkout.html and 
http://git-htmldocs.googlecode.com/git/git-checkout.html and neither 
appear to mention the --to option.

Is it missing from the man page? Or is it me that's missing something?

--
Philip 
