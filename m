From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Sun, 20 May 2012 20:32:34 -0500
Message-ID: <20120521013234.GA3055@burratino>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
 <vpqehqxmwpj.fsf@bauges.imag.fr>
 <CAMP44s2DU_3UnHxhgwsTVT59KjLi0+=iW7utuofEyis+_06jGA@mail.gmail.com>
 <CACBZZX4_wjFG4D4_2w8UcvbRwBmJ583QpoP_n-tq+dNds3Bi7Q@mail.gmail.com>
 <7v1umv7ub0.fsf@alter.siamese.dyndns.org>
 <CAHREChgTHZL0sNJ3TkZOL7x4k9x=4GRhrZ6Gm0W+Ai_UnX2FEg@mail.gmail.com>
 <20120519060031.GB23799@burratino>
 <7vzk92a76z.fsf@alter.siamese.dyndns.org>
 <CAMP44s1Bghc6zXRQ7fJxJORiHqAgs5dg-8_cp_FoChnBG7oD4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Lodato <lodatom@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 21 03:32:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWHUT-0000JL-04
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 03:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188Ab2EUBcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 May 2012 21:32:43 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40084 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700Ab2EUBcn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2012 21:32:43 -0400
Received: by obbtb18 with SMTP id tb18so7401581obb.19
        for <git@vger.kernel.org>; Sun, 20 May 2012 18:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NemEiTWA0+JIvdd7TFtJsYEE4rTEmd9+Wpa3c8cOEuo=;
        b=fk6GeL0eiOfJJISFryISFqTK7xHvof+yj/49RbN5dhF4QguccbwImbgvKYZ5lRFCMR
         z7fLVKtsX3rxZEWCltch8pWTtDgXe1R3/vjT7ufYYk4svIgfw66HInsDyVt2ZyD4VJIl
         HamXLZft0LVwOYn0jFs6GfljknTCRT94ahz12et9egYM4W2W9sxPvh2xyaSwMso6hKLl
         y7Axnfd5j1xXJ3YNXIy2QzbisKejkoRHU7DouVgVnIdWWvj5ZAccixzmfmngedYxUH4p
         9O4vJL4MslsvG8IiDbEtZ381jCm2zuDSvCkW06ihDERm1pFn5qpCk+fqsJwl15moxBR/
         f11g==
Received: by 10.50.11.225 with SMTP id t1mr5479370igb.64.1337563962643;
        Sun, 20 May 2012 18:32:42 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id rf2sm19283820igb.0.2012.05.20.18.32.39
        (version=SSLv3 cipher=OTHER);
        Sun, 20 May 2012 18:32:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s1Bghc6zXRQ7fJxJORiHqAgs5dg-8_cp_FoChnBG7oD4w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198075>

Hi Felipe,

Felipe Contreras wrote:

> Indeed, but you are missing the important part; everything else in
> that sentence.

You're probably onto something, but I'm missing the point in your
message.  Could you repeat, carefully explaining:

 - what change you would like to propose in git
 - whether it is backward compatible, and if it is not, what
   transition plan you propose
 - briefly, the rationale behind the change, in such a way as to
   convince skeptics like me that it is a good idea and to recruit
   us to help in your cause

?  For that third part, a good example to take inspiration from is the
project to improve Linux to function as a real-time operating system.
Each change is so well justified _individually_ that someone not
interested at all in that goal can still not help but agree with the
changes!

Perhaps your message includes these elements already, but I found it
hard to follow, hence this request.

Thanks,
Jonathan
