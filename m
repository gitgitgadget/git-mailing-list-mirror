From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: release-notes could be clearer on git-fetch changes
Date: Wed, 19 Feb 2014 23:58:00 +0100 (CET)
Message-ID: <alpine.LSU.2.11.1402192356480.1491@nerf08.vanv.qr>
References: <alpine.LSU.2.11.1402191952070.31131@nerf08.vanv.qr> <xmqqtxbu98ie.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 23:58:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGG5g-0000PO-Bf
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 23:58:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbaBSW6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Feb 2014 17:58:04 -0500
Received: from ares08.inai.de ([46.4.84.70]:58707 "EHLO ares08.inai.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbaBSW6D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 17:58:03 -0500
Received: by ares08.inai.de (Postfix, from userid 25121)
	id 4CD0310677D33; Wed, 19 Feb 2014 23:58:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by ares08.inai.de (Postfix) with ESMTP id 4A17D189D469C;
	Wed, 19 Feb 2014 23:58:00 +0100 (CET)
In-Reply-To: <xmqqtxbu98ie.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242416>


On Wednesday 2014-02-19 21:01, Junio C Hamano wrote:
>Jan Engelhardt <jengelh@inai.de> writes:
>> The release notes for 1.9.0 read:
>>
>>> * The "--tags" option to "git fetch" no longer tells the command to
>>>   fetch _only_ the tags. It instead fetches tags _in addition to_
>>>   what are fetched by the same command line without the option.
>>
>> I think the release notes should also say -- like it was done
>> extensively for git add -- how to get back the old
>> behavior (perhaps through now-different commands).
>
>Perhaps, but the release note is not a place to repeat what the
>documentation already teaches---it primarily is to enumerate the
>changed areas, to highlight the things users may want to look up in the
>documentation, to give them a starting point.
>
>You would do something like this, I would think:
>
>	git fetch $there 'refs/tags/*:refs/tags/*'

Looking at it from one more angle, `git fetch r --tags` and
`git push r --tags` is now no longer symmetric :(
