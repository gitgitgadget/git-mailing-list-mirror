From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: specify charset for commits (Was: [PATCH] Fix documentation copy&paste typo)
Date: Thu, 21 Dec 2006 14:14:52 +0100
Organization: At home
Message-ID: <eme17b$vff$1@sea.gmane.org>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de> <200612211623.14236.litvinov2004@gmail.com> <emdorr$kt$1@sea.gmane.org> <200612211905.27555.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Dec 21 14:12:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxNiu-0001QW-2h
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 14:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161092AbWLUNMd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 08:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161096AbWLUNMd
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 08:12:33 -0500
Received: from main.gmane.org ([80.91.229.2]:49125 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161092AbWLUNMc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 08:12:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GxNie-0002CF-BK
	for git@vger.kernel.org; Thu, 21 Dec 2006 14:12:20 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 14:12:20 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 14:12:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35063>

Alexander Litvinov wrote:

> ? ????????? ?? Thursday 21 December 2006 16:52 Jakub Narebski ???????(a):
>>> May we can add new header into commit with commit text encoding ?
>>
>> I think it should be repository-wide decision. And we have
>> i18n.commitEncoding configuration variable (perhaps it should be propagated
>> on clone?).
> 
> I would disagree with you. Is is not hard to imagine international project 
> managed by git. We [developers] can start to use utf-8 or similar universal 
> encoding but it is not easy sometimes. Fir example, not long ago all russian 
> linux machines has LANG set to ru_RU.KOI8-R, now it tend to be ru_RU.UTF-8. 
> It will not big surprise to me if developr from China or Japan use something 
> very unusual. And just imagine one developer using Windows and Cygwin - ha ha 
> ha, try to ask him to change the encoding :-)
> 
> The easiest way for git is just to store commit encoding and let tool for 
> history browsing deal with encoding. Or as it does now - simply ignore all 
> encodings at all and work with bytes not chars. But at this case history 
> browsing tool must have some magic knowlage about encoding taken from 
> air :-). Or from config file that cover most used encodings.

Perhaps it is time to resurrect idea about "note" header in commit object?
It could be used to store charset for those commits which doesn't use
default charset...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
