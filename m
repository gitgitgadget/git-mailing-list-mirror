From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [GSOC] Git Configuration API improvements
Date: Tue, 11 Mar 2014 21:49:33 +0530
Message-ID: <CAOLa=ZQwrtvoBWEra-p9wwFmYBZqcz75a9R0qm7bv2g7UCJn4A@mail.gmail.com>
References: <CAOLa=ZSKDg9DKxTRMy4yWW7=ZHcudGmK4guYmaP2okxH8Q044Q@mail.gmail.com>
 <vpqsiqovleu.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 11 17:20:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNPPO-0006Ph-3B
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 17:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbaCKQT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 12:19:56 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:38707 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbaCKQT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 12:19:56 -0400
Received: by mail-pd0-f172.google.com with SMTP id p10so8748235pdj.17
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 09:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Q1Pvcc532ROAQ1PL/B7hzdkhJ7nCsH9tKpzblg6ql9Q=;
        b=iNfpqfeVa5xbPBpqqNEvAHMt8R5HsZOyZ3Qkik/7cwkDCZ5qujV3EfXf5M3oTNUD/2
         gaJy/G2zxelBBgtVVOBEIWcXYI/C7/D7nwtHfCnXf1j1frK5oMvGs6/jAbKMKaIKB4zC
         reYvYuhdj7JvpQQbGI6wfSJJCJ0zkLh9iRM5IOt9Nn/9ukUzx90OwByP4xwMPc8HMSXg
         6YFyVFcAFZ2E16ir4b1a+3EiQ/OYdDdCI7zBzbWSk7pftAFsQj7jiN+c6cnl5WFLKQJu
         DhFmbKsu15YdmOg9RnYbLAdPqHqU0aPYSzIk8i6S3w0P+WPh0h00CefOjLsIoRZb8aTZ
         9tqQ==
X-Received: by 10.69.31.171 with SMTP id kn11mr49004616pbd.47.1394554793938;
 Tue, 11 Mar 2014 09:19:53 -0700 (PDT)
Received: by 10.68.189.2 with HTTP; Tue, 11 Mar 2014 09:19:33 -0700 (PDT)
In-Reply-To: <vpqsiqovleu.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243868>

On Tue, Mar 11, 2014 at 8:21 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> karthik nayak <karthik.188@gmail.com> writes:
>
>> Currently we have multiple invocation of git_config() in an
>> individual invocation of git() which is not efficient. Also, it is
>> hard to implement new features,
>
> I think efficiency is not a real concern here. Config files are small
> and easy to parse, so parsing them multiple times isn't really
> noticeable from the performance point of view.
>
> OTOH, the extensibility is a real concern, and that should be the main
> motivation for the project.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

Hello Matthieu,

Thanks. I understand what you mean. extensibility is the main motivation of the
project, i think that by implementing the cache system we can fix the
small problems
(reappearing of headers while setting and unsetting configs) and also
implement new features
like to unset a config easily.
