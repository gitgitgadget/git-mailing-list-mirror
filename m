From: Andreas Ericsson <ae@op5.se>
Subject: Re: The MIT error
Date: Tue, 25 Oct 2005 15:52:18 +0200
Message-ID: <435E3892.4020002@op5.se>
References: <200510251340.j9PDeGGt006248@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 25 15:56:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUPED-0008Un-Dx
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 15:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVJYNwW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 09:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVJYNwW
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 09:52:22 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:39400 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932146AbVJYNwV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 09:52:21 -0400
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 878D86BD00
	for <git@vger.kernel.org>; Tue, 25 Oct 2005 15:52:19 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: GIT Mailing List <git@vger.kernel.org>
In-Reply-To: <200510251340.j9PDeGGt006248@laptop11.inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10588>

Horst von Brand wrote:
> Morten Welinder <mwelinder@gmail.com> wrote:
> 
>>After the isspace/BSD conflict I looked into what reserved symbols are
>>being used by git.  Quite a few, it turns out.
> 
> 
> [...]
> 
> 
>>Just as isspace is reserved by the C implementation...
>>
>>       7.26.2  Character handling <ctype.h>
>>
>>       [#1]  Function  names that begin with either is or to, and a
>>       lowercase letter (possibly followed by  any  combination  of
>>       digits,  letters,  and  underscore)  may  be  added  to  the
>>       declarations in the <ctype.h> header.
> 
> 
> There go is_space(), etc as suggested by the relevant patches...


No they don't. "begin with either is or to and a lowercase letter", 
meaning (is|to)[a-z].*, just as Morten wrote. is_.* doesn't fall into 
this category. The underscore exemption is so that users can write their 
own is_file(), is_whatever() str_replace() and such. Some thought has 
gone into the standard.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
