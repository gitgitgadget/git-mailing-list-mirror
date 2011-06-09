From: Andreas Ericsson <ae@op5.se>
Subject: Re: Command-line interface thoughts
Date: Thu, 09 Jun 2011 12:02:37 +0200
Message-ID: <4DF09A3D.8040908@op5.se>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <m339jps1wt.fsf@localhost.localdomain> <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com> <201106051311.00951.jnareb@gmail.com> <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com> <7vwrgza3i2.fsf@alter.siamese.dyndns.org> <4DF08D30.7070603@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 09 12:02:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUc4c-0008Uw-GR
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 12:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539Ab1FIKCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 06:02:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43152 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219Ab1FIKCl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 06:02:41 -0400
Received: by fxm17 with SMTP id 17so866053fxm.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 03:02:40 -0700 (PDT)
Received: by 10.223.144.205 with SMTP id a13mr541613fav.135.1307613759813;
        Thu, 09 Jun 2011 03:02:39 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id e15sm579577faa.23.2011.06.09.03.02.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Jun 2011 03:02:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Thunderbird/3.1.10 ThunderGit/0.1a
In-Reply-To: <4DF08D30.7070603@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175513>

On 06/09/2011 11:06 AM, Michael Haggerty wrote:
> On 06/06/2011 08:16 AM, Junio C Hamano wrote:
>> Scott Chacon<schacon@gmail.com>  writes:
>>> For example, implementation details aside, I think having something
>>> like WTREE and NEXT available would help users understand that there
>>> are these 3 trees that are important and useful in Git and re-inforce
>>> a very non-SVN style workflow in that manner.
>>
>> That's a funny thing to say. Working tree may almost always (to put it
>> another way, "you could make it to") act like a tree, but the index does
>> not act like a tree at all in more important situations.
> 
> My naive understanding is that in the case of a merge commit, the index
> contains information equivalent to *multiple* trees:
> 
> NEXT -- HEAD plus the files that have been resolved
> BASE -- the contents of the common ancestor
> OURS -- equivalent to the tree from HEAD
> THEIRS -- equivalent to the tree from MERGE_HEAD
> 

Except there might be any number of THEIRS in the case of an octopus
merge. The most common case is just one though.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
