From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/4] vcs-svn: make reading of properties binary-safe
Date: Mon, 28 Mar 2011 22:30:45 +0200
Message-ID: <4D90EFF5.9050603@web.de>
References: <7vsjuegzj8.fsf@alter.siamese.dyndns.org> <1300970636-31743-1-git-send-email-david.barr@cordelta.com> <20110325033431.GA3007@elie> <20110325040730.GB3007@elie> <4D90AA6A.1090904@web.de> <20110328194157.GC13433@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: tb <tboegi@web.de>, David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 22:31:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4J5r-0005Pf-In
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 22:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911Ab1C1UbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 16:31:15 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:56815 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab1C1UbO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 16:31:14 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate02.web.de (Postfix) with ESMTP id 2996B19B35007;
	Mon, 28 Mar 2011 22:31:07 +0200 (CEST)
Received: from [194.22.188.61] (helo=[192.168.209.16])
	by smtp02.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #2)
	id 1Q4J5e-0000qW-00; Mon, 28 Mar 2011 22:31:06 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110221 SUSE/3.1.8 Thunderbird/3.1.8
In-Reply-To: <20110328194157.GC13433@elie>
X-Sender: tboegi@web.de
X-Provags-ID: V01U2FsdGVkX18YrzaZdqlFO+B8SGpCe+FtHLOiljLQQOr7fSsZ
	PkYUubBui0rlrfRtN+/myD8HDUWLyzgFFxZGzhUEYjK1iLPzpl
	8j8RbxPKc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170186>

On 03/28/2011 09:41 PM, Jonathan Nieder wrote:
> tb wrote:
>
>> failure on t9010 with commit 195b7ca6f229455da61f9f6b
> [...]
>> Darwin birne.lan 10.7.0 Darwin Kernel Version 10.7.0: Sat Jan 29
>> 15:17:16 PST 2011; root:xnu-1504.9.37~1/RELEASE_I386 i386
>
> Could you try 41e6b91f (vcs-svn: add missing cast to printf argument,
> 2011-03-27) from
>
> 	git://repo.or.cz/git/jrn.git svn-fe
>
> ?  I suspect this is fallout from a missing cast in the commit you
> pointed to.  Thanks for noticing.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
No good news from my side:
Same (?) problem with 41e6b...

not ok - 13 NUL in log message, file content, and property name

/Torsten

Note:
(commit 41e6b  works OK on  my 32 bit 386 linux machine.
  There is no svn on that machine, and commit 195b7ca6f22 had 10 
failures in TC 9010. (If that is any useful information))
