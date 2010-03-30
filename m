From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [GSoC Proposal/RFC] Rolling commit message writing
Date: Tue, 30 Mar 2010 00:32:11 -0400
Message-ID: <32541b131003292132q10db3c5eh1bb6443d625fcb82@mail.gmail.com>
References: <alpine.DEB.1.00.1003281834520.13534@pip.srcf.ucam.org> 
	<32541b131003291331y3ae5ca23la33466d588c1b9e1@mail.gmail.com> 
	<20100330030508.GA2887@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Thomas <drt24@srcf.ucam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 06:32:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwT81-0004X6-S5
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 06:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443Ab0C3Ecd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 00:32:33 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:56660 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab0C3Ecc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 00:32:32 -0400
Received: by gxk9 with SMTP id 9so2151457gxk.8
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 21:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zwoMip2Cz18qpRixAD58M1+/eS5hijzgv3J+N+4oVhQ=;
        b=ITn+eOJx+jVXoYySNL+H6FNyEulke2TZvNFWWgNShZkASTrvbfYUQJGwv3Rx/SElF5
         mt8QnEBEGdzZRB+gqmEvTb2KbaTvtTF/6FCuOUEiO/bbfMxNDz368Joo48t7SLDig8JH
         NxKW9WwYSBTJ5RPRFfFeOiPKSLTscNknBKT08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Z3yQgBAE6P+ljjOhLr5wEfJp8S+dQnRn3GFfMfES3vqa6JLudj/LiWzJ8YKHkTQgW6
         auoZO8Ou69jeyNYL4zVQuynfQPZaZyRqkWs/7ZepvQVOVqrc37570tm4sawNJJ+VeD9T
         2hCfb1j8s9TXT/gs+ziMoOQK6ruOD3mq9boJc=
Received: by 10.150.203.4 with HTTP; Mon, 29 Mar 2010 21:32:11 -0700 (PDT)
In-Reply-To: <20100330030508.GA2887@progeny.tock>
Received: by 10.150.128.41 with SMTP id a41mr5565427ybd.245.1269923551116; 
	Mon, 29 Mar 2010 21:32:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143542>

On Mon, Mar 29, 2010 at 11:05 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Avery Pennarun wrote:
>> Given these existing capabilities, is it still worth adding the
>> feature you propose?
>
> I think it might be, in some modified form.
>
> Suppose I am working on a medium-sized change that for reasons of
> bisectability or ontology has to be one commit. =A0In the middle of
> working, I notice I needed to do something nonobvious. =A0Currently w=
hen
> this happens, I get out a pad of paper and write it down, so I can be
> sure to mention it in the commit message.

When I have this situation, I generally just make a temporary commit
with "git commit", then revise it using "git commit --amend" over
time.

Or else I make a series of commits, then *later* squash them all
together using 'git merge --squash' or 'git rebase -i'.

It seems like the suggested feature would encourage people to do it
the "wrong" way (not creating temporary commits, thus making it easy
to make a mistake and blow things away) just because they aren't aware
of the above options.

Is there a reason that these methods don't work for you?

Thanks,

Avery
