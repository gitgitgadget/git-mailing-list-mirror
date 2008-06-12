From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH 0/2] Respecting core.autocrlf when showing objects
Date: Thu, 12 Jun 2008 22:16:24 +0200
Message-ID: <48518418.2010007@trolltech.com>
References: <7vprqqdwh7.fsf@gitster.siamese.dyndns.org> <cover.1213084587.git.marius@trolltech.com> <alpine.DEB.1.00.0806101632570.1783@racer> <7vk5gxc4gz.fsf@gitster.siamese.dyndns.org> <484F6A27.1040602@trolltech.com> <alpine.DEB.1.00.0806112000400.1783@racer> <4850E647.7050602@trolltech.com> <7vtzfy8n4i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@citi.umich.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 22:17:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6tEo-0005xt-89
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 22:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525AbYFLUQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 16:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755427AbYFLUQn
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 16:16:43 -0400
Received: from hoat.troll.no ([62.70.27.150]:36094 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755047AbYFLUQm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 16:16:42 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 9F68B20B96;
	Thu, 12 Jun 2008 22:16:36 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 2E4D820B20;
	Thu, 12 Jun 2008 22:16:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <7vtzfy8n4i.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
OpenPGP: id=34EB4437
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84782>

Junio C Hamano wrote:
> Marius Storm-Olsen <marius@trolltech.com> writes:
>> Uhm, 'git checkout side file.txt' is not the same file content 
>> (ignoring EOLs please) as 'git show :3:file.txt'. Ref:
>> user-manual.html#conflict-resolution
> 
> Bruce, I think the comment in this quoted section is wrong.
> 
> True, the combined diff can show only the interesting differences
> between the three, but that is not because we munge stage #2 and #3.
> They contain verbatim copies from the HEAD and the MERGE_HEAD
> respectively, and the combining logic runs three-way diffs between
> the three stages to discard the hunks that the result comes solely
> from either stage #2 or stage #3.
...
> -Since the stage 2 and stage 3 versions have already been updated
> with -nonconflicting changes, the only remaining differences between
> them are -the important ones; thus linkgit:git-diff[1] can use the
> information in -the index to show only those conflicts. +When you ask
> linkgit:git-diff[1] to show the conflicts, it runs a +three-way diff
> between the conflicted merge results in the work tree with +stages 2
> and 3 to show only hunks whose contents come from both sides, +mixed
> (in other words, when a hunk's merge results come only from stage 2, 
> +that part is not conflicting and is not shown.  Same for stage 3).

Aah, that certainly clears things up a bit. A good patch I'd say.

However, it doesn't change the fact that IMO "git show" should respect 
core.autocrlf, while "git cat-file" shouldn't.

I think many would consider
     git show MERGE_HEAD:file.txt > file.txt
before
     git checkout MERGE_HEAD file.txt
if only because they'd be scared to do a "checkout" in the middle of a 
merge conflict.

Personally I think the latter is nice, short and sweet, but that doesn't 
mean that it's less scary for people staring out on git. The fact that 
the two commands above are *not* identical in result, are the kind of 
things that we need to iron out, to make git more accessible to the 
general public.

--
.marius
