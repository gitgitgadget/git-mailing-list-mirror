From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Potential GSoC13 projects (Re: Google Summer of Code 2013 (GSoC13))
Date: Tue, 19 Feb 2013 08:23:11 +0700
Message-ID: <CACsJy8Arotg-fRk-pDGE_MHzah2apyt45co0JzJ4Roy_24EPBw@mail.gmail.com>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch> <20130218174239.GB22832@sigill.intra.peff.net>
 <20130218193424.GC3234@elie.Belkin> <CALkWK0mKZLotuu7pEM_3Of3i6JzU12QV_pHxOZTUr22TOq3PeQ@mail.gmail.com>
 <20130218211101.GA4022@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Barr <b@rr-dav.id.au>, Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 02:24:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7bwH-000350-NI
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 02:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757926Ab3BSBXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 20:23:44 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:60960 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757900Ab3BSBXm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 20:23:42 -0500
Received: by mail-ob0-f181.google.com with SMTP id ni5so6181039obc.12
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 17:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=eSTKjQunz+wcoF6Hke+jdla+kU5T9RicrarLRddB/GE=;
        b=CNmJJEcbY2jpA+ylN+tFC88h8uTivRsUDFqUCmMJ/ou0CBhD3kMwl3dpD/TRa4g2Xg
         WuBWlsFWxdw+pB81NaaiExl1c6DIElvfiWJoke2YhhIw1WJTi0QpcN73WEwJkazL96yf
         S8DJqW4WWXMK4mPI068NXqu88PJZox0fFg2Zmm4H4JEAxE4h1yya7+QlCVTY1N9ByZmp
         vfMdk12RiYCn/y01VDKuYGsrajoqvaqZYscB6f51B2uf26r6Oz10PwPNYkVpJ7tzS+9w
         bd3HEKmCtAD+mrlQe3ppKJhcUdirkNq9bta/J+rN0BBAJGdZIjmmjTNyroQImKnIMwxe
         3wsQ==
X-Received: by 10.182.72.5 with SMTP id z5mr6942714obu.24.1361237021197; Mon,
 18 Feb 2013 17:23:41 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Mon, 18 Feb 2013 17:23:11 -0800 (PST)
In-Reply-To: <20130218211101.GA4022@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216553>

On Tue, Feb 19, 2013 at 4:11 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ramkumar Ramachandra wrote:
>> Jonathan Nieder wrote:
>
>>>  - cross-compilable git
>>
>> Why, exactly?  Git for embedded devices?
>
> My personal motivation would be building Git for Windows while
> spending as little time on Windows as possible.  People deploying git
> to 32-bit x86, 64-bit x86, and ARM (think "ARM laptops") might also
> find it handy.

I did something like that long ago (for cross compiling Windows).
Although I eventually gave up on the Windows front as I was too lazy
to test on Windows :) (and Wine by that time was not good enough) I
think some of my patches are in the archive. Will dig them up.
-- 
Duy
