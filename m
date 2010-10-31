From: Mathias Lafeldt <misfire@debugon.org>
Subject: Re: Pushing everything
Date: Sun, 31 Oct 2010 12:32:45 +0100
Message-ID: <4CCD53DD.4090605@debugon.org>
References: <loom.20101031T064406-734@post.gmane.org> <AANLkTikG5yTPwkjmnSv8yg2QRNNjDu_JxBdHzLBjO1RP@mail.gmail.com> <m28w1epu9o.fsf@whitebox.home> <loom.20101031T113039-859@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Sun Oct 31 12:32:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCW9g-0001z7-EU
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 12:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322Ab0JaLcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 07:32:52 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:56519 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575Ab0JaLcu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 07:32:50 -0400
Received: from [192.168.2.102] (dslb-088-071-184-013.pools.arcor-ip.net [88.71.184.13])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0LphYc-1OhI882FQU-00eqNP; Sun, 31 Oct 2010 12:32:46 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.15) Gecko/20101027 Thunderbird/3.0.10
In-Reply-To: <loom.20101031T113039-859@post.gmane.org>
X-Provags-ID: V02:K0:6pmU2QDCUwKmlfM/XtyQ3qplT1dmXOLP2/YYS3CQBJB
 37OaDuom69JxRlbtatFPYH3ti0clf+K/gPhlV//imZVBzZM+X/
 GAjPTGBuxXvyYkWNWSEUPXwqGqpSuWYQQnQtWoCP/VU0u7kTJ5
 KQ5kcV/a5FG2amqINiPlODeRIcryNwpi40+Vdut8B4pGyUzcbc
 sZA2sy/pRlOhwr3Pxy0x+DvnGrvMdlPHdRqGWtaazE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160433>

On 10/31/2010 11:48 AM, Maaartin wrote:
> Andreas Schwab <schwab <at> linux-m68k.org> writes:
>>
>> Tay Ray Chuan <rctay89 <at> gmail.com> writes:
>>
>>> On Sun, Oct 31, 2010 at 1:47 PM, Maaartin <grajcar1 <at> seznam.cz> wrote:
>>>> I'd like to push all my branches and tags to the server, but for whatever 
> reason
>>>> "--all" ignores tags and is incompatible with "--tags". I could imagine 
> there's
>>>> a reason I'm not experienced enough to see?
>>>
>>> You can spell the refs explicitly, like this:
>>>
>>>   $ git push refs/heads/* refs/tags/*
>>
>> The first argument needs to be a reference to a repository, so insert an
>> origin here.
> 
> Nice, that works. It answers only a part of my questions, but maybe I can 
> complete it. I want to use a repo as both a private backup (which everybody may 
> read but nobody should) and a shared base. So maybe something like
> 
> git push origin +refs/heads/*:refs/heads/maaartin-* +refs/tags/*:refs/tags/
> maaartin-* :
> 
> would do both the backup (where everything gets prefixed by my name) and normal 
> pushing of tracking branches. Could it work? Should I try it out or can it be 
> destructive?

Hi,

why don't you try pushing to a local clone first, and then check the results?

This puts your data at no risk.

-Mathias
