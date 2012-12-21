From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Change in cvsps maintainership, abd a --fast-export option
Date: Fri, 21 Dec 2012 20:19:21 +0100
Message-ID: <50D4B639.9000807@alum.mit.edu>
References: <20121220215638.E54BC44119@snark.thyrsus.com> <50D4199C.6000002@alum.mit.edu> <20121221104437.GA5244@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Fri Dec 21 20:19:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm88F-0005Xk-TV
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 20:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392Ab2LUTT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 14:19:26 -0500
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:63953 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752016Ab2LUTTZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2012 14:19:25 -0500
X-AuditID: 1207440f-b7f276d0000008b2-c8-50d4b63cf64d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id D0.3B.02226.C36B4D05; Fri, 21 Dec 2012 14:19:24 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qBLJJMZk026482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 21 Dec 2012 14:19:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121221104437.GA5244@thyrsus.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsUixO6iqGuz7UqAwf82IYurW3wsuq50Mzkw
	eSz72sni8XmTXABTFLdNUmJJWXBmep6+XQJ3xuu1CQULuCuezelhamBs5exi5OSQEDCR+Ni0
	lBHCFpO4cG89WxcjF4eQwGVGiaOv5rFAOMeZJK5smsMKUsUroC3x6vskZhCbRUBV4tjdTrBu
	NgFdiUU9zUwgtqhAgMTiJefYIeoFJU7OfAI0iINDREBY4lifGojJLCAu0f+PBaRCWMBdYtvO
	fWAThQRqJbb0LGcCKeEUMJC4cwtsKbOAjsS7vgfMELa8xPa3c5gnMArMQjJ/FpKyWUjKFjAy
	r2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdHLzSzRS00p3cQICVD+HYxd62UOMQpwMCrx8F5q
	uhIgxJpYVlyZe4hRkoNJSZR3+RagEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRFe/3lAOd6UxMqq
	1KJ8mJQ0B4uSOK/6EnU/IYH0xJLU7NTUgtQimKwMB4eSBO+WrUCNgkWp6akVaZk5JQhpJg5O
	kOFcUiLFqXkpqUWJpSUZ8aAYjS8GRilIigdobxJIO29xQWIuUBSi9RSjMUfDyxtPGTluNdx8
	yijEkpeflyolzjsZpFQApDSjNA9uESw1vWIUB/pbmLcLpIoHmNbg5r0CWsUEtEpECWxVSSJC
	SqqBMbontc78R+0stprFqaeLLAsVs/K3HNj671kEw/N4q70X3s2ceYs/6KL2J+kexmu7Gmbf
	99y7qnXLrp83Nivd7ZeSU+wNOtCTPsU7bMdTGdYHmaqSBX8zP1k0/gvvEey8qCAS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212005>

On 12/21/2012 11:44 AM, Eric S. Raymond wrote:
> Michael Haggerty <mhagger@alum.mit.edu>:
>> If you haven't yet seen it, there is a writeup of the algorithm used by
>> cvs2git to infer the history of a CVS repository [1].  If your goal is
>> to make cvsps more robust, you might want to consider the ideas
>> described there.
> 
> I shall do so.  Their design ideas may well be interesting, even though I
> don't trust their code.  I've seem cvs2svn drop far too many weird artifacts 
> and just plain broken commits in the back history of Subversion repositories.
> I don't know if this is due to design problems, implementation bugs, or both.

If you have seen any problems with cvs2svn/cvs2git, please file bug
reports.  In the past years there have been very few valid bugs
reported.  We very often find that artifacts that users thought were
bugs are in fact intentional workarounds required to make the contents
of branches and tags in the target VCS agree with those in the CVS
repository.

Perhaps your experience is with an older version of cvs2svn?  If not,
please be specific rather than just making complaints that are too vague
to be rebutted or fixed (whichever is appropriate).  I put a *lot* of
effort into getting cvs2svn to run correctly, and I take bug reports
very seriously.

Michael
(the cvs2svn maintainer)

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
