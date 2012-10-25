From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Thu, 25 Oct 2012 15:33:03 +0200
Message-ID: <CAMP44s0guY7GUhDVuuehGwvyv4ZFWPkxmnjMxhV257cN7uDtgg@mail.gmail.com>
References: <20121025042731.GA11243@elie.Belkin>
	<CAMP44s1Pe8Ef6-GRbmSs7rY7gWyaPCN+jWGysyttZp3drSDoZg@mail.gmail.com>
	<20121025052823.GB11243@elie.Belkin>
	<CAGdFq_gg3gPvCADje9ibz8xHgPOLF+=79EqksVzG2JeTOfHocw@mail.gmail.com>
	<CAMP44s3kBxzJbyoxPqWbRMWmpX9sNPGjdRy_KrTeRoVmGC-+Hg@mail.gmail.com>
	<CAGdFq_jfiX9apPyq6pba4S4iCQLGLmDvSrLaujSB5rO0i+fzfg@mail.gmail.com>
	<CAMP44s1cRg_we5nXeRG1WcWz7YUOBrauJigeNna1YETcno9p=A@mail.gmail.com>
	<CAGdFq_hgYPF5eeCB9hSsjVfUyEhkBNJAtzoNuNqs5N6V-+w9Hg@mail.gmail.com>
	<20121025073454.GB15790@elie.Belkin>
	<CAGdFq_j5sWsHwJY-rWP-XJ6cMF6uwSq=9beFe9ZuZyixBa1fVA@mail.gmail.com>
	<20121025074829.GD15790@elie.Belkin>
	<CAGdFq_ifDYKTXt_cKkz5ZTBPgZKB7HFEbWereNnhSmS3qbhbsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 15:33:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRNYk-0004iN-NP
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 15:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759493Ab2JYNdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 09:33:06 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54336 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759057Ab2JYNdE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 09:33:04 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so1545604obb.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 06:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zLuB1kcxiXuYs5Yr7/MHiujjAunglF0EYRkIk2K4/64=;
        b=mdQpJnieKi1hVERhwhm1f5SifkyPTjvRbWT40XLW3qo0sanIkcOGFyswIhBam89jgw
         bwwoJbg0ta1DPTBlVpQ/omysYUOTszc/YJBiIloa3UWKFims6gnlUnV3Ugv7tkwfC4z8
         pU9KgYuY8oC6Oz29OYD0/9jpe3K6zNuBIs6I0WtJsbimcXvhiJQA9wAv7K8OlfRPbWnG
         wy/7cl5VKiZVqyxX5cMyg1AMQTNGn3/5k3C9hsZ7FxGpvnedU/57FA/pWVh/ioLJ0qkE
         z1C6BxarOWEhjkxpoYJwE5nbwgwMY2VD8OLKMt0KcSRJD4XdfBprI8RnOdtndeSbUcYh
         Cwug==
Received: by 10.60.27.201 with SMTP id v9mr7768766oeg.85.1351171983907; Thu,
 25 Oct 2012 06:33:03 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Thu, 25 Oct 2012 06:33:03 -0700 (PDT)
In-Reply-To: <CAGdFq_ifDYKTXt_cKkz5ZTBPgZKB7HFEbWereNnhSmS3qbhbsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208399>

On Thu, Oct 25, 2012 at 9:50 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Thu, Oct 25, 2012 at 12:48 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Sverre Rabbelier wrote:
>>
>>> I know there was a reason why using UNINTERESTING didn't work
>>> (otherwise we could've used that to start with, instead of needing
>>> Junio's whence solution). I think all refs ended up being marked as
>>> UNINTERESTING or somesuch.
>>
>> True.  Is it be possible to check UNINTERESTING in revs->cmdline
>> before the walk?

It is possible to check in revs->pending, but '^foo master' will mark
them both as UNINTERESTING, and 'master..master' as well, which again,
is what we actually want, because that's how it works in the rest of
git.

> That might work, maybe Dscho remembers why we did not go with that approach.

Because you want 'master..master' to output something, but that's
wrong; it's changing the semantics of commitishes, and you don't need
that to solve this problem.

-- 
Felipe Contreras
