From: "Zorba" <cr@altmore.co.uk>
Subject: Re: is there an easier way to do this ?
Date: Tue, 30 Dec 2008 23:20:32 -0000
Message-ID: <gjeacg$3r5$4@ger.gmane.org>
References: <gjc52u$ehc$4@ger.gmane.org> <m3k59hb6xr.fsf@localhost.localdomain>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 31 00:22:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHnuw-0006JC-8m
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 00:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbYL3XVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 18:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbYL3XVI
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 18:21:08 -0500
Received: from main.gmane.org ([80.91.229.2]:46398 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbYL3XVH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 18:21:07 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHntQ-0006qk-UV
	for git@vger.kernel.org; Tue, 30 Dec 2008 23:20:57 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 23:20:56 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 23:20:56 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.2 points;
 *  0.0 RCVD_BY_IP Received by mail server with no name
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  1.2 PRIORITY_NO_NAME Message has priority, but no X-Mailer/User-Agent
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104225>

thanks Jakub, but I don't mind copying the versions in by hand and running 
the git commits on them sequentially.

I only have 5 max historical versions to archive..

"Jakub Narebski" <jnareb@gmail.com> wrote in message 
news:m3k59hb6xr.fsf@localhost.localdomain...
> "Zorba" <cr@altmore.co.uk> writes:
>
>> ok, now I'm in this for real, archiving versions of our website project 
>> (5k
>> files approx)
>>
>> so here is the workflow:
>>
>> - copy version 1 files into GIT dir
>>
>> - open git bash
>>
>> $ git init
>>
>> $ git add .
>>
>> $ git commit -m "version1"
>>
>> all vanilla ? cool
>> next job = store version 2 [...]
>
> Check out contrib/fast-import/import-tars.perl
>
> -- 
> Jakub Narebski
> Poland
> ShadeHawk on #git 
