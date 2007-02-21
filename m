From: David Lang <david.lang@digitalinsight.com>
Subject: Re: Unresolved issues
Date: Tue, 20 Feb 2007 16:51:44 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0702201648450.14284@qynat.qvtvafvgr.pbz>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net><Pine.LNX.4.64.07022009
 34270.20368@woody.linux-foundation.org><7vfy90v729.fsf@assigned-by-dhcp.cox
 .net>  <Pine.LNX.4.64.0702201621050.4043@woody.linux-foundation.org><Pine.LNX.4.63
 .0702210136050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702201648000.4043@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 02:09:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJfym-0007nU-MA
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 02:09:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbXBUBJF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 20:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbXBUBJF
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 20:09:05 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:47507 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S932293AbXBUBJE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 20:09:04 -0500
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 20 Feb 2007 17:09:04 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 20 Feb 2007 17:08:44 -0800
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.64.0702201648000.4043@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40271>

On Tue, 20 Feb 2007, Linus Torvalds wrote:

> On Wed, 21 Feb 2007, Johannes Schindelin wrote:
>>
>> Um, I don't want to spoil the party, but was not the original idea of this
>> auto-CRLF thing some sort of "emulation" of the CVS text checkout
>> behaviour?
>>
>> In that case, .gitattributes (I mean a tracked one) would be wrong, wrong,
>> wrong.
>>
>> It's a local setup if you want auto-CRLF or not. So, why not just make it
>> a local setting (if in config or $GIT_DIR/info/gitattributes, I don't
>> care) which shell patterns are to be transformed on input and/or output?
>
> That is a good point. We *could* just make it a ".git/config" issue, which
> has the nice benefit that you can just set up some user-wide rules rather
> than making it be per-repo.

some of the things that .gitattributes is being talked being used for about for 
are local, some are per-repo

per the prior discussion of how many places to check a local configuration 
should override the per-repo setting.

David Lang

>
> Of course, the config language may not be wonderful for this. But we could
> certainly have something like
>
> 	[format "crlf"]
> 		enable = true
> 		text = *.[ch]
> 		binary = *.jpg
>
> which would just override the built-in rules (where anything that doesn't
> match is just "auto-content"). And make the default built-in ones be good
> enough that in _practice_ you never even need this in the first place.
>
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
