From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Please consider extending .gitignore to support setting of a file size limit
Date: Fri, 8 May 2015 22:55:17 +0100
Organization: OPDS
Message-ID: <682DB2BD13D143CEB606BF9C8E4E55D5@PhilipOakley>
References: <CAC+AdWRpJnt2PN1YcB7VoHcKsO86_DhE1mOB5Ls9bWaEd_XKXQ@mail.gmail.com> <xmqqy4l0m5wf.fsf@gitster.dls.corp.google.com> <20150508065459.GB31516@vps892.directvps.nl>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Roger Mendes" <sproger1@gmail.com>, <git@vger.kernel.org>
To: "Kevin Daudt" <me@ikke.info>, "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 23:55:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqqEZ-0002yJ-8D
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 23:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257AbbEHVy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 17:54:59 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:19747 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752696AbbEHVy6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2015 17:54:58 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2B8FACGME1VPDsFFlxcgw6BMoZMbcUyBAQCgTVNAQEBAQEBBwEBAQFBJBuEGwUBAQEBAwgBAS4eAQEhCwIDBQIBAw4HAwklFAEECBIGBwMUBgESCAIBAgMBiAYDFrtmh2YNhS8sizqCTYFgWIMegRYFi2aGVXCIHIJ5g1qKZYMZg1WCLByBUz0xgQSBQgEBAQ
X-IPAS-Result: A2B8FACGME1VPDsFFlxcgw6BMoZMbcUyBAQCgTVNAQEBAQEBBwEBAQFBJBuEGwUBAQEBAwgBAS4eAQEhCwIDBQIBAw4HAwklFAEECBIGBwMUBgESCAIBAgMBiAYDFrtmh2YNhS8sizqCTYFgWIMegRYFi2aGVXCIHIJ5g1qKZYMZg1WCLByBUz0xgQSBQgEBAQ
X-IronPort-AV: E=Sophos;i="5.13,393,1427756400"; 
   d="scan'208";a="781372315"
Received: from host-92-22-5-59.as13285.net (HELO PhilipOakley) ([92.22.5.59])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 08 May 2015 22:54:52 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268678>

From: "Kevin Daudt" <me@ikke.info>
> On Thu, May 07, 2015 at 02:31:12PM -0700, Junio C Hamano wrote:
>> Roger Mendes <sproger1@gmail.com> writes:
>>
>> Having said all that, why is it that you do not want to track
>> certain files that happen to be large?  Don't the existing large
>> file support facility work for you (or perhaps you are not using
>> them)?  It might be that your time is better spent on improving
>> that, instead of working around the issue, no?
>>
>
> My experience in #git is that people want to prevent other people
> accidentelly adding large files, resulting in all sorts of problems,
> which takes a lot of effort to fix if you're not an experienced user.
> --
I'd also support this option.

One issue is to locate a suitable method/character code for the 'magic 
pathspec' that would define a size limit that can be used for the 'git 
add .' etc., and possibly also for sparse checkout (definitely an area 
where a size limit may be appropriate for some users).

The ability to extend the ignore method could also, in the future be 
used for a possible narrow clone (when desired).
--
Philip 
