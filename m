From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 08/12] MINGW: config.mak.uname allow using CURL for
 non-msysGit builds
Date: Mon, 28 Apr 2014 18:24:59 +0200
Message-ID: <CABPQNSZvEgKqCLrbtgWxU=BM2vCmW=tiHLrx4aTcC-2aw-megA@mail.gmail.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-9-git-send-email-marat@slonopotamus.org>
 <CABPQNSaywg_1pdixaEz0DALCO6pvhjdMhGW09aC+LALMzZAz1w@mail.gmail.com> <20140428162332.GA19504@seldon>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 18:26:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeoNR-0002XX-C5
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 18:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756554AbaD1QZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 12:25:49 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35244 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756580AbaD1QZl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 12:25:41 -0400
Received: by mail-ie0-f177.google.com with SMTP id rp18so1447661iec.22
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/7LF4hkmjBYNQ/gtf6R+FixL/EHE7vWuWyuJs59Zv9w=;
        b=NF1WkwKWmFt/peNqOg5iafDdrpQN44zzGpQE6ii6FnH7ucQ8vgCp+Sc/4gvdp2F3TJ
         We+bx72U6U+q1kKB07lEPIGojoncNxqpXWHwOswq7F+JxtXqhDBHDRzcxGBJYiTEhjqn
         FsyDomFNq0O5zhI7MdiAPm9tCo02FzkV2ax51/5MQJfFvQvyAF3w2SMYjQiwdeVm2LRU
         GleedfgKrSbFX0YJkO/w0bzqc7qjnrKy73l//DKwmc460nF1btA0DTnbGeVnn54vL+77
         D7u8EmOuXJXJF2XqQvV1uFsabVX1q+29g5zIySilB4CWLJwioWmDMdXQ2uYvyDSiCMRr
         TzlA==
X-Received: by 10.42.204.197 with SMTP id fn5mr1738143icb.95.1398702340626;
 Mon, 28 Apr 2014 09:25:40 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 09:24:59 -0700 (PDT)
In-Reply-To: <20140428162332.GA19504@seldon>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247375>

On Mon, Apr 28, 2014 at 6:23 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> On Mon, Apr 28, 2014 at 05:26:38PM +0200, Erik Faye-Lund wrote:
>> On Mon, Apr 28, 2014 at 3:51 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
>> > Also, fix `warning: passing argument 2 of 'mingw_main' from
>> > incompatible pointer type` in http-fetch.c and remote-curl.c.
>>
>> These seems completely unrelated, perhaps it should be split in two?
>
> Okay, will split. Though there is a connection - until this patch,
> http-fetch.c and remote-curl.c never built for MinGW.

Ahh, thanks for pointing that out. But yeah, I think splitting is
still the right option.
