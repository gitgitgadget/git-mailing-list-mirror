From: "norbert.nemec" <norbert.nemec@native-instruments.de>
Subject: Re: How to find and analyze bad merges?
Date: Thu, 02 Feb 2012 10:01:18 +0100
Message-ID: <jgdjd1$5mn$1@dough.gmane.org>
References: <jgdgcv$h8n$1@dough.gmane.org> <7vd39xy7it.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 10:01:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RssY9-00009u-01
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 10:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214Ab2BBJBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 04:01:34 -0500
Received: from plane.gmane.org ([80.91.229.3]:37021 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130Ab2BBJBe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 04:01:34 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RssXt-0008V0-5h
	for git@vger.kernel.org; Thu, 02 Feb 2012 10:01:33 +0100
Received: from 46.231.181.199 ([46.231.181.199])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 10:01:33 +0100
Received: from norbert.nemec by 46.231.181.199 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 10:01:33 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 46.231.181.199
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7vd39xy7it.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189605>

Am 02.02.12 09:16, schrieb Junio C Hamano:
> "norbert.nemec"<norbert.nemec@native-instruments.de>  writes:
>
>> a colleague of mine happened to produce a bad merge by unintenionally
>> picking the version of the remote branch ("R") for all conflicting
>> files. Effectively, he eliminated a whole bunch of bugfixes that were
>> already on his local branch ("L").
>>
>> Obviously this was a mistake on his side, but hey: everyone makes
>> mistakes. The real problem is to find this problem afterwards,
>> possibly weeks later, when you suddenly realize that a bug that you
>> had fixed suddenly reappears.
>
> Bisect?

This is not the point: My colleague knew exactly which commit contained 
the bugfix. The trouble was finding out why this bugfix disappeared even 
though everything indicated that it was cleanly merged into the current 
branch.
