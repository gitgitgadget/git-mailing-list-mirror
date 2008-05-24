From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: git-rerere: Usage question
Date: Sat, 24 May 2008 14:06:32 +0200
Message-ID: <483804C8.8020703@dirk.my1.cc>
References: <4836D46A.7070807@dirk.my1.cc> <7vwslkpo1o.fsf@gitster.siamese.dyndns.org> <20080524075436.GA4377@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat May 24 14:08:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzsXX-0005AE-FS
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 14:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbYEXMGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 08:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbYEXMGk
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 08:06:40 -0400
Received: from smtprelay11.ispgateway.de ([80.67.29.28]:32898 "EHLO
	smtprelay11.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbYEXMGj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 08:06:39 -0400
Received: from [84.176.123.174] (helo=[192.168.2.100])
	by smtprelay11.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1JzsWA-00087k-0T; Sat, 24 May 2008 14:06:34 +0200
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <20080524075436.GA4377@glandium.org>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82809>

Mike Hommey schrieb:
> On Fri, May 23, 2008 at 05:02:11PM -0700, Junio C Hamano wrote:
>   
>> These days, rerere is pretty much automatic in that rerere is called
>> automatically from places that generate conflicts (e.g. "git merge") for
>> purpose of (1), and from places that the user tells git that the conflicts
>> are now resolved (e.g. "git commit") for purpose of (2).
>>     
>
> Note that it is not totally automatic for most people because the
> default is to enable only if the .git/rr_cache directory exists, and
> neither git init nor git clone create this directory.
>   
git-gc does -- at least if rerere.enabled is set.
Thanks for the pointer that this directory must exist.
Probably it gets auto-created when needed?
I didn't check that out coz I currently have nothing
to merge with :-(
A simple no-op "git pull" (Already up-to-date)
did *not* create the directory, but git-gc did.

    Dirk
