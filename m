From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: CVS-$Id:$ replacement in git?
Date: Fri, 31 Aug 2007 18:58:50 +0200
Message-ID: <46D848CA.3060707@dawes.za.net>
References: <46D82DC3.2030203@bioinf.uni-sb.de>	<Pine.LNX.4.64.0708311732580.28586@racer.site> <7v8x7r1wyy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Hildebrandt <anhi@bioinf.uni-sb.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 19:01:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR9sX-0005Kv-07
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 19:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965345AbXHaRBr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 13:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759569AbXHaRBr
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 13:01:47 -0400
Received: from sumo.dreamhost.com ([66.33.216.29]:58161 "EHLO
	sumo.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759194AbXHaRBq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 13:01:46 -0400
Received: from spunkymail-a12.g.dreamhost.com (sd-green-bigip-74.dreamhost.com [208.97.132.74])
	by sumo.dreamhost.com (Postfix) with ESMTP id 194C31F6BD3
	for <git@vger.kernel.org>; Fri, 31 Aug 2007 10:01:44 -0700 (PDT)
Received: from [192.168.201.101] (dsl-146-25-78.telkomadsl.co.za [165.146.25.78])
	by spunkymail-a12.g.dreamhost.com (Postfix) with ESMTP id 861657FA8;
	Fri, 31 Aug 2007 09:59:40 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7v8x7r1wyy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57189>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> On Fri, 31 Aug 2007, Andreas Hildebrandt wrote:
>>
>>> But unfortunately, we internally rely heavily on the $Id:$ - expansion 
>>> of CVS, that is the ability to have a line like
>>>
>>> $Id:$
>>>
>>> in the source file expanded to something like
>>>
>>> $Id: HINFile.C,v 1.64 2005/02/09 13:02:41 oliver Exp $
>>>
>>> The information we want to store in the file would be something like the 
>>> SHA1 of the last commit that touched that file, the date when it 
>>> happened and the person who commited it.
>> Please see Documentation/gitattributes.txt, look for 'ident'.
> 
> Please do _not_ see that.  ident is about blob object name and
> does not have anything to do with the commit, pathname,
> committer, nor date, and this is deliberately so.
> 

For more details see this thread:

<http://thread.gmane.org/gmane.comp.version-control.git/44750>

Rogan
