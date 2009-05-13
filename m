From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: switching upstream tips
Date: Wed, 13 May 2009 11:05:19 +0200
Message-ID: <81b0412b0905130205u68237834o9172685974cbac4f@mail.gmail.com>
References: <4A0A6BD1.7050907@gmail.com>
	 <81b0412b0905130019x114d53d1v86833217bff613bc@mail.gmail.com>
	 <4A0A777E.7080506@gmail.com>
	 <81b0412b0905130041t327ef5f2m3b6d1dfac51fc1b1@mail.gmail.com>
	 <4A0A7BA1.4030500@gmail.com>
	 <81b0412b0905130115v78b5065bjdeb3f349072eed4c@mail.gmail.com>
	 <4A0A858C.2070808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Ittay Dror <ittay.dror@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 11:05:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4AP6-0006tm-GN
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 11:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836AbZEMJFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 05:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbZEMJFV
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 05:05:21 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:7356 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754628AbZEMJFU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 05:05:20 -0400
Received: by fk-out-0910.google.com with SMTP id 18so249220fkq.5
        for <git@vger.kernel.org>; Wed, 13 May 2009 02:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8hK6ivw5gvIz4K5gIBQER9CdqN/v2WnLOsBGPYi7b98=;
        b=MK6X63pnH/9vwnUBrNNnlARNKU10sBS6aqC+N/JtvUSdPP4kK2u9MGd+ZAxkt6Jr0k
         o0PfQMmk1s5GdBJ5spSdwoub7mPQ6M3bqW6Fh1vkp07KqOFB7067UPjgAA/5dHjDXFzL
         mD77HHpErUxZHgrq4yAHaVrZ9OaOJOO6iQiqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IWH0lEAuxan9tVSrrQuj1xjBMMdDcIVGkvCekjZCiO5MR9HskebQM5rCKdH33myq9K
         PArGAUNj8H/VhAX7/fxYR5xADr56aLF/CjMkE6gYIsahvAnyIZAkn10vuxpnkfn3Io7H
         d5iTleou3hF0X+svFI40TyOh8y4IP5hrKwXAU=
Received: by 10.204.123.136 with SMTP id p8mr723019bkr.21.1242205520048; Wed, 
	13 May 2009 02:05:20 -0700 (PDT)
In-Reply-To: <4A0A858C.2070808@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119010>

2009/5/13 Ittay Dror <ittay.dror@gmail.com>:
> Alex Riesen wrote:
>> 2009/5/13 Ittay Dror <ittay.dror@gmail.com>:
>>>
>>> tried git rebase, this is what i get:
>>> git rebase -i upstream master
>>> fatal: Needed a single revision
>>> Invalid base
>>>
>>
>> $ git checkout my-old-master-based-on-old-upstream
>> $ git rebase -i old-upstream
>>
>
> so i need to create an 'old-upstream' branch first, that is based on the tip
> of the old-upstream remote, right? how?

no. Just use the remote reference. Should be something like
origin/master. It is the reference to the commit where to put your
commits on. You can use the SHA1 there, if you wish.
All the rebasing happens on and to that branch of yours
(my-old-master-based-on-old-upstream in the example above)

> (thanks for the patience)

This patience is just about to end. Ever looked at the man pages?
"git help git" can be a good start.
