From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Reporting bugs and bisection
Date: Wed, 16 Apr 2008 23:05:17 +0200
Message-ID: <bd6139dc0804161405j28470914u488568b565b68a0b@mail.gmail.com>
References: <20080414043939.GA6862@1wt.eu>
	 <20080413232441.e216a02c.akpm@linux-foundation.org>
	 <20080414072328.GW9785@ZenIV.linux.org.uk>
	 <Xine.LNX.4.64.0804150131300.4160@us.intercode.com.au>
	 <4804765B.2070300@davidnewall.com>
	 <bd6139dc0804160515s64a36748v49556c56d475dda4@mail.gmail.com>
	 <20080416132634.GA545@cs181133002.pp.htv.fi>
	 <bd6139dc0804161239h17e79c70ta5e938619e5743c9@mail.gmail.com>
	 <20080416201606.GS1677@cs181133002.pp.htv.fi>
	 <20080416205333.GT1677@cs181133002.pp.htv.fi>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	"James Morris" <jmorris@namei.org>,
	"Al Viro" <viro@zeniv.linux.org.uk>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Willy Tarreau" <w@1wt.eu>, david@lang.hm,
	"Stephen Clark" <sclark46@earthlink.net>,
	"Evgeniy Polyakov" <johnpol@2ka.mipt.ru>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	"Tilman Schmidt" <tilman@imap.cc>, Valdis.Kletnieks@vt.edu,
	"Mark Lord" <lkml@rtr.ca>, "David Miller" <davem@davemloft.net>,
	jesper.juhl@gmail.com, yoshfuji@linux-ipv6.org, jeff@garzik.org,
	netdev@vger.kernel.org, "David Newall" <davidn@davidnewall.com>
To: "Adrian Bunk" <bunk@kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765482AbYDPVFf@vger.kernel.org Wed Apr 16 23:12:30 2008
connect(): Connection refused
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765482AbYDPVFf@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmEpl-0002wB-Ew
	for glk-linux-kernel-3@gmane.org; Wed, 16 Apr 2008 23:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765482AbYDPVFf (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 16 Apr 2008 17:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753584AbYDPVFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2008 17:05:20 -0400
Received: from el-out-1112.google.com ([209.85.162.182]:8140 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970AbYDPVFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2008 17:05:19 -0400
Received: by el-out-1112.google.com with SMTP id n30so509306elf.21
        for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2008 14:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=uYrp/tig368zrRXSj1xFvMsFXlmR/wtCsv8FKNthdwc=;
        b=uisKc1kqJVX9r/DCYmAAGIoQ972nKNsQ1COCeXGi/ZgtPZJY34gkkwUhtKL46+3zZ05eJ/SWN8wh/MACx08oLm39LvJ+W3usk383OIs7elPYxLwkfUuEArGzzZ/PDKvAPb8nW2ZRhWuH2j5Q2LpOs9dHprz6mL2GCC888YXTnC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CTFOPurnpymdCxf4F97uCkjgSL7A8jbr3wzEo0WWdVAsgxDHHGvFC0dmxBCeQZ9kWzOyQNiGOIT7XxfSu5HETIdyMl18sQPhszQO153SWTb7eXiWWnsxHVCeyxT1rdPR1bTvfE6YrXZ16WrCIjV9FjL9GYp/MFveCUsgv5NVycs=
Received: by 10.142.242.8 with SMTP id p8mr155130wfh.24.1208379917951;
        Wed, 16 Apr 2008 14:05:17 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Wed, 16 Apr 2008 14:05:17 -0700 (PDT)
In-Reply-To: <20080416205333.GT1677@cs181133002.pp.htv.fi>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79752>

On Wed, Apr 16, 2008 at 10:53 PM, Adrian Bunk <bunk@kernel.org> wrote:
>  To avoid any misunderstandings:
>
>  This is not in any way meant against you personally.

Thanks for pointing it out, I wasn't quite sure, but assumed that :).

>  But saying things like " X% of your commits introduced bugs" is not a
>  friendly thing, and wrong data could be quite hurting.

Yes, it could be, and I agree that conclusions shouldn't be based on
the details, but on the bigger picture. Also, I think it should (at
first) be used mainly as an indicator, of where attention might be
required. I mean, if it points out that one contributor almost always
commits buggy code, you don't have to present them with those
statistics right away. Instead you can ask the program where it bases
it's conclusions on, and research them yourself. If it does indeed
turn out that they are slacking that much you have good ground to have
a talk with them.

>  Especially in the open source world where much motivation comes from
>  people being proud of their work.

Yes, that is very true, I very much agree with that, but on the other
hand it might also point out contributors that are particularly
skillful in a certain section that was previously not noted. As with
all statistics, it's up to interpretation, misinterpreting statistics
could -always- have bad effects.

>  Even correct data can do harm.
>
>  And bad data can have really bad effects.

True, both, but as said, if properly interpreted it could be very useful.

Cheers,

Sverre Rabbelier
