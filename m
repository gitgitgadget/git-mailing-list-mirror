From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Please revert e371046b6473907aa6d62b7862a3afe9d33561e1
Date: Thu, 07 Jun 2012 09:41:57 +0200
Message-ID: <4FD05B45.2090006@alum.mit.edu>
References: <m24nqoohss.fsf@gmail.com> <CA+39Oz4f_Wn1cVzqNWO76HZWa4AswSBpbriaRc0OznapVLJfGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: John Wiegley <jwiegley@gmail.com>, git@vger.kernel.org
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 09:42:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScXM7-0005Zq-Vm
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 09:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268Ab2FGHmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 03:42:03 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:53746 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755035Ab2FGHmC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jun 2012 03:42:02 -0400
X-AuditID: 1207440c-b7fc26d0000008c0-a2-4fd05b481e95
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 33.8C.02240.84B50DF4; Thu,  7 Jun 2012 03:42:00 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q577fwru009631
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 7 Jun 2012 03:41:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <CA+39Oz4f_Wn1cVzqNWO76HZWa4AswSBpbriaRc0OznapVLJfGg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqOsRfcHf4OAnQ4uuK91MFos6fzJb
	LFzax+TA7LFz1l12j8+b5DyuvLvEHsAcxW2TlFhSFpyZnqdvl8CdsXbpaaaCmYIVZ16dY2pg
	fMDbxcjJISFgIrGw5Sk7hC0mceHeerYuRi4OIYHLjBIbtx1kgXCOMUlcu3+FCaSKV0BbovVN
	KzOIzSKgKrFg5l2wbjYBXYlFPc1ANRwcogJhEqsfaECUC0qcnPmEBSQsIqAs8ayNBSTMLGAl
	sWMbyC5ODmEBZ4lrO1eAxYUEsiVOXN0DZnMKBEocP32ZEaLeTKJraxeULS+x/e0c5gmMArOQ
	bJiFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3QN9XIzS/RSU0o3MUJCl2cH47d1
	MocYBTgYlXh4J/ec9xdiTSwrrsw9xCjJwaQkynsj6oK/EF9SfkplRmJxRnxRaU5q8SFGCQ5m
	JRFegTKgct6UxMqq1KJ8mJQ0B4uSOK/qEnU/IYH0xJLU7NTUgtQimKwMB4eSBO9SkKGCRanp
	qRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoDiNLwZGKkiKB2hvHUg7b3FBYi5QFKL1FKMu
	x8zL564zCrHk5eelSonzTgMpEgApyijNg1sBS1SvGMWBPhbmvQRSxQNMcnCTXgEtYQJa0gqx
	pCQRISXVwNgaNMvSbefHGSHFxsIOTxbGh+/zcGzlsBc3Wrxi3ZaS6bsjEk+8+RtxfXc6S9NU
	j+Qrvkzbfz4J3xzjvaM1X4Zfythz6m+bEM/70/5JVDKxBk4L8Fjcleq949JqQ6O6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199375>

On 06/06/2012 07:54 PM, Thomas Adam wrote:
> On 6 June 2012 11:28, John Wiegley<jwiegley@gmail.com>  wrote:
>> I've spoken to the author of this commit, Matthias Urlichs.  Here is an
>> excerpt of our conversation:
>>
>>> On Sat, 2012-04-21 at 00:08 -0500, John Wiegley wrote:
>>>> Just wanted to let you know that this bit me.  I have a client whose CVS
>>>> repository I'm converting to Git, and they have _many_ log messages that
>>>> are larger than 32k in size.
>>>
>>> Feel free to submit a patch that reverts this. These days, there's probably
>>> no user of cvs2git left, but at that time it was important to get the same
>
> This assertion is not only wrong, it's just ludicrous.  The intended
> functionality has a statement of intent with regards to its
> functionality -- and as a user of cvs2git, I'd not want to lose *any*
> of that functionality.

I was confused about this conversation.  The commit that John Wiegley 
proposes to revert is from 2005.  The "cvs2git" functionality in cvs2svn 
was not added until 2007.  So it must be that commit e371046b64 was 
added for compatibility with some other cvs2git script (i.e., not the 
one that is part of the cvs2svn project).  Nowadays the only script 
called "cvs2git" that I ever see mentioned (and I maintain a Google 
search on that string) is the one from the cvs2svn project.  So I assume 
that the old "cvs2git" script (the one mentioned in commit e371046b64's 
log message) has died off.

The current cvs2svn-based cvs2git script doesn't have any limitation on 
the size of log messages and doesn't clean up their whitespace.  The 
only things that it does, in the default configuration, is check that 
the message is ASCII (if not there are options to reencode it as UTF-8) 
and convert all EOL sequences into LF.

Therefore I don't believe that there is any reason to preserve the 
functionality of commit e371046b64 in the name of compatibility with 
cvs2git.

I have no opinion about whether it makes sense to revert/preserve the 
commit for other reasons.

Michael
(the cvs2svn/cvs2git maintainer)

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
