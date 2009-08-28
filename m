From: david@lang.hm
Subject: Re: Using git to track my PhD thesis, couple of questions
Date: Fri, 28 Aug 2009 14:44:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0908281443070.28411@asgard.lang.hm>
References: <vpq7hwo8gxd.fsf@bauges.imag.fr> <4A979690.1050601@gnu.org>  <vpqk50pasek.fsf@bauges.imag.fr>  <9b18b3110908271521w764684cfg3b009f6960ee5dc4@mail.gmail.com>  <7v1vmxq6nw.fsf@alter.siamese.dyndns.org>  <fabb9a1e0908271341o3a558eedq85541e68875ab77f@mail.gmail.com>
  <20090827203402.GC7168@kisimul> <20090828133708.GA11146@kisimul> <9b18b3110908280912o271dc095o67bc82b31e91680e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: seanh <seanh.nospam@gmail.com>, git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 23:44:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh9FU-0004HT-78
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 23:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311AbZH1Vo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 17:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752981AbZH1Vo3
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 17:44:29 -0400
Received: from mail.lang.hm ([64.81.33.126]:36018 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752878AbZH1Vo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 17:44:29 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n7SLiTgP003405;
	Fri, 28 Aug 2009 14:44:29 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <9b18b3110908280912o271dc095o67bc82b31e91680e@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127354>

On Fri, 28 Aug 2009, demerphq wrote:

> 2009/8/28 seanh <seanh.nospam@gmail.com>:
>> On Fri, Aug 28, 2009 at 12:21:42AM +0200, demerphq wrote:
>>> As you can generate the PDF's from the latex then just hack gitweb to
>>> let them download it from there.
>>
>> Unfortunately gitweb is written in Perl. But I know what you mean, it
>> should in theory be possible for them to click on a 'Get PDF' link for a
>> particular revision that causes the PDF to be built and returned to
>> their browser.
>
> What is unfortunate about that? Perl is a duct tape/swiss-army-knife
> of the internet.  Hacking gitweb to generate PDF's on the fly from
> latex documents should be a fairly trivial hack, even if you aren't a
> Perl hacker.

I have a situation where I need to generae pdf's from files that are under 
git. I have a git repository on by webserver that I push to and have a 
trigger that regenerates the pdfs any time there is a push.

David Lang

> See:
>
> http://search.cpan.org/~andrewf/LaTeX-Driver-0.08/lib/LaTeX/Driver.pm
>
> for just one of many Perl modules to interface with with LaTeX.
>
> Good luck.
>
> Yves
>
>
