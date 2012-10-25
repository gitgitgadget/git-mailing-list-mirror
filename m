From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Thu, 25 Oct 2012 07:18:37 +0200
Message-ID: <CAMP44s1Pe8Ef6-GRbmSs7rY7gWyaPCN+jWGysyttZp3drSDoZg@mail.gmail.com>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
	<1320535407-4933-2-git-send-email-srabbelier@gmail.com>
	<CAMP44s1hdZb_7Lv8SEe+MsfC_q-nXsnjJobABFq6eFR_er4TaA@mail.gmail.com>
	<20121024180807.GA3338@elie.Belkin>
	<CAMP44s2RspCrRXZbRTsVwezyU9X=+8RF=_9Q+3zX75LBJkdoPA@mail.gmail.com>
	<20121024191149.GA3120@elie.Belkin>
	<CAMP44s2kjv9fHbruXv7NyVm9m+FjFnYDryuPZQ-RQXN9Nj6MAw@mail.gmail.com>
	<20121025042731.GA11243@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 07:18:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRFqE-000225-L0
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 07:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873Ab2JYFSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 01:18:39 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:48220 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442Ab2JYFSi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 01:18:38 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1231028oag.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 22:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=L2Xp1cnd/phCCQIqVh3CRVety5h+sM6GQ47vvteeyo0=;
        b=ffj0nuafaAYfNUUSu9egTd+yv564KY7NbnOS/9SO8hTW+rD02eKSofz4b+fmEze3gA
         xWily1I/dqbh7UcJAC5qQposy5/yp9VgEoHp8Ks3CikMMRoFs+oBt3i4i8RNgfsnjy6f
         3tx73z89qoRlOmQhBkhVmTlVmf7Qaf9+n74sIxJFwq8GNtS9dD2RfX4oGKl14DkciFER
         7IjBlmuY0b5qFR6mm+QvPNEh4EyIfUayAReUk599HCCom926oHVBTyzBBJcZmE++7DW8
         DIt+Sro+fkhWJCTeNn6Fj9X/Afer5QJW0y3pDsU+sQGbLb32v8DqrQAIF3jWmdxo81p7
         udww==
Received: by 10.60.32.19 with SMTP id e19mr16318091oei.9.1351142317487; Wed,
 24 Oct 2012 22:18:37 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 24 Oct 2012 22:18:37 -0700 (PDT)
In-Reply-To: <20121025042731.GA11243@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208343>

On Thu, Oct 25, 2012 at 6:27 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>
>> Again, if you don't have marks, I don't see what you expect to be
>> exported with 'master..master', even with marks, I don't see what you
>> expect.
>
> And that's fine.  Unless you were trying to do some work and this lack
> of understanding got in the way.

What is fine? What lack of understanding?

You still haven't said what you expect the output to be.

Consider this repo:

---
git init test
cd test
echo one >> file
git add --all
git commit -m 'one'
echo two >> file
git commit -m 'one'
---

What *exactly* should the output of 'git fast-export master..master'
be? I say nothing, what do you say?

> In that case, with a calmer and more humble approach you might find
> people willing to help you.  Maybe they will learn something from you,
> too.

I don't need help, I am helping you, I was asked to take a look at
this patch series. If you don't want my help, then by all means, keep
this series rotting, it has being doing so for the past year without
anybody complaining.

Cheers.

-- 
Felipe Contreras
