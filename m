From: Matt McClure <matthewlmcclure@gmail.com>
Subject: Re: Avoiding broken Gitweb links and deleted objects
Date: Thu, 9 May 2013 16:04:18 -0400
Message-ID: <1912835977933437557@unknownmsgid>
References: <CAJELnLFrfY=-gOFEe0cJHuyT4UNjbTm8hXMxAmzmQHVbz4iEbg@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=ISO-8859-1
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 09 22:04:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaX4k-0007Bn-S2
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 22:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558Ab3EIUEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 16:04:22 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:52426 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab3EIUEW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 16:04:22 -0400
Received: by mail-pa0-f44.google.com with SMTP id jh10so2381598pab.17
        for <git@vger.kernel.org>; Thu, 09 May 2013 13:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:references:from:in-reply-to:mime-version:date:message-id
         :subject:to:content-type;
        bh=2NyJzr1DeTHa5NdGfG+JBt1EFjz5qRtWnFIfRd5lGjE=;
        b=MWZdMXEonwQwEQQo0rIeHnW3epVPOuBKFxy02HUunyMcqf1ax6x1aKEJafIbjRo1nD
         sT9A4r0ekr9M05vH/RkL4vNbFtGZf7ul5oa7ZALb6/1gwmrXp2No5mjqR+0siY1EAYwk
         Mq06Zsem2p6oLhGwNYj3YuYbZRpLPK7OOFqftdXAj+991oKwIpyI2Pr8b3rLkJcaEo4p
         wuOEJi+Ak3uu+p/5thMnly28GUCFiUd3KXOliAeqOr3rsg+AXiRfgHY7EUCZt8InyLEz
         7pNeYE1zEbRoDIoXVH4N7uQe4C0epj9P5Jfpd5Njm0vC0WGt05e1JGemRYZkAik8c9uE
         sBbg==
X-Received: by 10.66.177.46 with SMTP id cn14mr14881120pac.4.1368129861712;
 Thu, 09 May 2013 13:04:21 -0700 (PDT)
In-Reply-To: <CAJELnLFrfY=-gOFEe0cJHuyT4UNjbTm8hXMxAmzmQHVbz4iEbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223776>

On Wed, May 8, 2013 at 12:05 PM, Matt McClure <matthewlmcclure@gmail.com> wrote:
> On Wed, May 8, 2013 at 10:41 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> git gc moves unreachable objects that were packed before to the loose
>> object store, from where they can be pruned.
>
> Thanks. That was the piece I was missing. I assumed `git gc` did the opposite.

That begs a follow-up question. It sounds as though Git will typically
delete unreachable objects. My team often shares links like
https://git.example.com/foo.git/log/d59051721bb0a3758f7c6ea0452bac122a377645?hp=0055e0959cd13780494fe33832bae9bcf91e4a90
. If I later rebase the branch containing those commits and d590517
becomes unreachable, do I risk that link breaking when Git deletes
d590517?

What's a good strategy for avoiding breaking those links?

-- 
Matt McClure
http://matthewlmcclure.com
http://www.mapmyfitness.com/profile/matthewlmcclure
