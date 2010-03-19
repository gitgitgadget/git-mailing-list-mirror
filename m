From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 21:12:59 -0400
Message-ID: <9e4733911003181812k1cf08833ke683226377527b56@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
	 <alpine.LFD.2.00.1003181909180.31128@xanadu.home>
	 <9e4733911003181626t7d143903mbc5737ff2fa5100f@mail.gmail.com>
	 <alpine.LFD.2.00.1003181930230.31128@xanadu.home>
	 <9e4733911003181641n400704c9r1a0addd6fce6fce0@mail.gmail.com>
	 <alpine.LFD.2.00.1003181953010.31128@xanadu.home>
	 <9e4733911003181716q7f141d5eqd18218c749ca4624@mail.gmail.com>
	 <alpine.LFD.2.00.1003181715490.18017@i5.linux-foundation.org>
	 <9e4733911003181739m2f605dd7g9406aaecc296749f@mail.gmail.com>
	 <alpine.LFD.2.00.1003181739310.18017@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 19 02:13:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsQly-0007Ny-IT
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 02:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612Ab0CSBNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 21:13:04 -0400
Received: from mail-qy0-f182.google.com ([209.85.221.182]:48957 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab0CSBNB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 21:13:01 -0400
Received: by qyk12 with SMTP id 12so693962qyk.5
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 18:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=EPSwO3BkE7IhqWG8rosyRG25HnJwYy25ThHnh605dT0=;
        b=e9LMnUXFXNxL7KQ0ei6ZX49EFGbz4vXlXcIQyuirLUHCpk/MZXj0sWivkSgAh2cyby
         xWtANxWDBIsjpROFoK7DhCTtLtN5QjdK/3AL0demIlO68mg+SZCl4aLjdjPnnqTfgH7M
         OGbthxoLxoH39UF+wkDEbnFbSna8L9dWh+rkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=K4Q45RPspd1cDDV1NOk+57fg6HVWaGUWMCEUqO2sUx+CrFhoFFpdahpelw7fi0UQ1C
         PLqYEatnig1/8X9rzJ2p+FsHeY/0MyYOTTr1MsZCvlNkh0uVt3LZCVXw8cQTzd2fXHWM
         m7TN5pwCI9p8O4lYKnkjQq78GvysrWji/i1Yo=
Received: by 10.224.59.134 with SMTP id l6mr1018274qah.224.1268961180100; Thu, 
	18 Mar 2010 18:13:00 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003181739310.18017@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142551>

On Thu, Mar 18, 2010 at 8:50 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Does anybody care? Certainly not I. There is absolutely zero reason to
> worry about it. I used to find it convenient to see what machines I had
> worked on, so I actually included that. And one of them was clearly
> mis-configured, or git did something wrong when the hostname was already
> in FQDN format. Whatever.
>
> There is no real _value_ in making a .mailcap for each such buggy entry is
> what I'm trying to tell you. Those things are maybe used for statistics.
> On the whole, they are correct.

I was trying to track how many real people were working on the kernel.
 If we don't collapse the 13 different versions of you down to one
person the number numbers are way off.

-- 
Jon Smirl
jonsmirl@gmail.com
