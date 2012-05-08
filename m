From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Does content provenance matter?
Date: Tue, 8 May 2012 10:23:53 +0100
Organization: OPDS
Message-ID: <F5AF82B3BF334F0A88C8755426C725F0@PhilipOakley>
References: <1336432417.36394.YahooMailClassic@web121504.mail.ne1.yahoo.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Kelly Dean" <kellydeanch@yahoo.com>,
	"PJ Weisberg" <pj@irregularexpressions.net>
X-From: git-owner@vger.kernel.org Tue May 08 11:23:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRgdw-0003G3-Gd
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 11:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646Ab2EHJXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 05:23:36 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:21409 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751211Ab2EHJXf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 05:23:35 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmgQAObkqE9cHlGK/2dsb2JhbABEizqBA5RIkH8BAQKBHIEIggcFAQEEAQgBAQQqHgEBDRQFBgIDBQIBAxUBAgklFAEEGgYHBRIGARIIAgECAwGHbwMGCQetHo4AihppPxwQaINTYwSIMIVKiRWKLoUDgmo
X-IronPort-AV: E=Sophos;i="4.75,549,1330905600"; 
   d="scan'208";a="34136729"
Received: from host-92-30-81-138.as13285.net (HELO PhilipOakley) ([92.30.81.138])
  by out1.ip07ir2.opaltelecom.net with SMTP; 08 May 2012 10:23:33 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197351>

From: "Kelly Dean" <kellydeanch@yahoo.com> Sent: Tuesday, May 08, 2012 12:13
AM
> --- On Mon, 5/7/12, PJ Weisberg <pj@irregularexpressions.net> wrote:
>> But there could be any number of unrelated commits newer than "Bar"
>> but older than "Revert Bar" on other branches.  Even if you could
>> trust the timestamps to be accurate (you can't), you still can't
>> determine a commit's parent unambiguously.
> Therefore, provenance does matter, and it must be explicitly recorded
> because it can't necessarily be correctly and fully deduced from content
> alone. And git does record inter-commit provenance.
> However, git doesn't record intra-commit provenance, as I mentioned in my
> original message. My question is: why this discrepancy?

>  Either provenance matters, or it doesn't;

The logic error is here. There are many other available choices as to
deciding the points at which the many provenance quality levels decay. (e.g.
see [1]).

People eventually give up caring at some level of detail/history, each in a
different place ;-) It's a choice. e.g. Have you noticed all high
performance cars (Porche?) need brightly coloured brake cylinders with
carefully specified paint jobs - why? At some point we give up caring how
someone got a few (how few?) characters into a file... It's not right, but
it's not wrong either.

I've worked with systems (e.g. DOORS) that record every keystroke, and
recored every hunk at the undo/redo level, but for little benefit.

Git takes the approach of having lightweight (easy) branching with easy
commits, with local history re-writing (rebase), to give users the ability
to balance between their WIP (work in progress), and their public record.
But with strong verification of any given history (e.g. "My Master"). It's a
choice as to who and where to blame.

>     why record it in one case but not the other?

Philip
[1] Measuring and Managing Technological Knowledge,
IEEE Engineering Management Review Winter 1997 p77-88.
Reprinted from  Sloan Management Review, Fall 1994
http://sloanreview.mit.edu/the-magazine/1994-fall/3615/measuring-and-managing-technological-knowledge/
