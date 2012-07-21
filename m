From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: pushing branches
Date: Fri, 20 Jul 2012 18:58:40 -0700
Message-ID: <CAJsNXT=-Ap0zJqK2F_3uJ7secmq7uvnSc218x+NoYdO5pLJAMg@mail.gmail.com>
References: <CACnwZYdqP_ptj0++dj5NkCoKWKHiLEj+c0t7zrmNidkHsyzMgw@mail.gmail.com>
	<7vhat2toz8.fsf@alter.siamese.dyndns.org>
	<CACnwZYchBpSsvfY_-cu33dmPateNPgYaPr822Ri=Xn6=V0OOnA@mail.gmail.com>
	<CAJsNXTkH6wRgH9g4BCZVxKz9ntf0P_Y81kc+bAhcchkQM3+3Bw@mail.gmail.com>
	<CACnwZYe03VzR0=m6oCo8X6y=iiLkZXi+xQpvW9goya0roU+PFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 03:59:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsOye-0001CV-3r
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 03:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346Ab2GUB6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 21:58:42 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49414 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060Ab2GUB6m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 21:58:42 -0400
Received: by lbbgm6 with SMTP id gm6so5794977lbb.19
        for <git@vger.kernel.org>; Fri, 20 Jul 2012 18:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=lQtFscHW/JHaHwPAZxA16PP2QhLgs995BewREV2YxW8=;
        b=A8MryAzxGHQWWeLdqMRj+a3c3P+p0imUB+LoDM8psROibNq9W9EFIKQK3UHB/5Z7nv
         pgiozP3Hz/KX1UDOP5NelFvhfvpRUBWU9tADyrQIrffHZxoaiR+TM/1v9WdD/3N0S6Qn
         C+6k8XwAgHfBuMT9dsNlGr964B8Hm4nQZC/hGDv4Cyfxdm6hdjh45NzjBL21eQHUo5I/
         YPSFDsIoZMrIP2Ko9EoHr4XaQ468P8C5/KM1l7eBdzXD8ErGdBAlJDvX7xT2VBpa/Wlu
         09MSFLcZ2aJIax+qr2fVytQhCCi3cc2piV6+kXiqaBtTAHkRpMlzoLpTclbyeOq7xRMF
         ksXg==
Received: by 10.152.113.68 with SMTP id iw4mr8268631lab.50.1342835920438; Fri,
 20 Jul 2012 18:58:40 -0700 (PDT)
Received: by 10.112.5.102 with HTTP; Fri, 20 Jul 2012 18:58:40 -0700 (PDT)
In-Reply-To: <CACnwZYe03VzR0=m6oCo8X6y=iiLkZXi+xQpvW9goya0roU+PFQ@mail.gmail.com>
X-Google-Sender-Auth: dDcjLr5s910CwQpzod9u9FkEAjE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201800>

On Fri, Jul 20, 2012 at 6:40 PM, Thiago Farina <tfransosi@gmail.com> wrote:
> On Fri, Jul 20, 2012 at 4:19 PM, PJ Weisberg
> <pj@irregularexpressions.net> wrote:
>> On Fri, Jul 20, 2012 at 8:49 AM, Thiago Farina <tfransosi@gmail.com> wrote:
>>
>>> What I'm looking for is to upload/create the remote branch in github
>>> from inside my local branch, without having to checkout master in
>>> order to do so.
>>
>> In that case, do exactly what you did, except don't checkout master.
>>
> Why you suggest that? If I demonstrated that origin master or just
> origin in the current branch doesn't do what I want, i.e, push it to
> github.

In your original email, you had one command that did what you wanted
and one that didn't.

$ git push origin master
$ git push origin feature-work

Can you spot the difference between them?

Like Konstantin said, you can look into the different options for
push.default, but don't expect Git to push one branch when you told it
to push another.

-PJ

Gehm's Corollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.
