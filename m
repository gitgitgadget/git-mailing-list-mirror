From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Pair Programming Workflow Suggestions
Date: Wed, 16 Sep 2009 09:35:09 -0400
Message-ID: <c115fd3c0909160635x4d7368aeg4370668d765fd242@mail.gmail.com>
References: <c115fd3c0909151043v3216a147v35e18710fbead515@mail.gmail.com> 
	<BLU0-SMTP195165E447A0C42386D083AEE30@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Sean Estabrooks <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Wed Sep 16 15:35:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnufp-0003bs-1R
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 15:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbZIPNf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 09:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbZIPNf1
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 09:35:27 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:52518 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbZIPNf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 09:35:26 -0400
Received: by yxe1 with SMTP id 1so6616927yxe.21
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=7L5AXjxEEY+O5w3U4zXnfAIHfmwWeECgB5uvj/6FMKU=;
        b=JUV0AaKxDc3mF5f5kFFkAeZh/2xKBMQZ8BrLbURvtQQ/Y12RErOo96NEZ8Q4y5J26/
         iY07HbCz9FZAI25VNiA1zR9R3RrnJRjdqGpoNeAGRL1GYiw/Dkx8rfpXKYJai+7sfGTk
         0BwxaBPMyVmEMiBhpblk0JXvtXvD3svg3VjL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=j7fF3qwpzOz7C5rkUbp3pwLOQAdqpz6rw7m53Wp6nyJBBlhD9CxIgyf0h4Vmu/zkf3
         wEXN7SlaCxRtDurXNOq4O/0i0Dxmg1RDhjxXOAebMNlnhLsJNqSozZx9PU1Zp9nbMpjT
         9TTgRhTTCIdJpiyp4eNMqhaEkPVxfmqo2Wqko=
Received: by 10.101.95.3 with SMTP id x3mr8972669anl.112.1253108129130; Wed, 
	16 Sep 2009 06:35:29 -0700 (PDT)
In-Reply-To: <BLU0-SMTP195165E447A0C42386D083AEE30@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128653>

On Tue, Sep 15, 2009 at 2:14 PM, Sean Estabrooks <seanlkml@sympatico.ca> wrote:
> On Tue, 15 Sep 2009 13:43:17 -0400
> Tim Visher <tim.visher@gmail.com> wrote:
>
> [...]
>> It would be nicer to
>> have an arbitrary number of authors that can all exist separately, but
>> I'm fairly certain that git does not support that.
>
> Tim,
>
> If you're just looking for a way to quickly switch the author information
> quickly between individual commits.  You could create a shell alias for
> each of the programmers that does:
>
>   export GIT_AUTHOR_NAME="some name" GIT_AUTHOR_EMAIL="name@where.com"
>
> This will override the global and per repo configured author information
> for all subsequent commits.

That is an interesting idea.  My point is really that having a
committer and an author is something that makes sense in terms of
non-pairing.  Especially in the OS world where developers may never
even get to meet, let alone code together, one developer writes a
feature somewhere and then submits it to the maintainer and the
maintainer puts it in.  Pairing, on the other hand, is much more
tightly integrated than that.  Just like in Brian's post, it's really
a situation of Dev1 _&_ Dev2 wrote this feature, but one of them
happened to be typing and doing most of the nitty-gritty developing.
Changing the authors between committs almost seems to introduce an
arbitrary level of distinction where it's no longer _both_ but _one
then the other_.  Does that make my question any clearer?

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
