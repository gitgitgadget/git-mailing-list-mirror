From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 7 Jan 2014 20:48:08 +0100
Message-ID: <CALas-ihLbODY6idQizsvH-U6OFRnC6e5=WRB6gkJ7SpBJ3VskQ@mail.gmail.com>
References: <20140105212458.GG3156@odin.tremily.us> <20140105225733.GB4660@book.hvoigt.net>
 <20140105233943.GJ3156@odin.tremily.us> <20140106003314.GL3156@odin.tremily.us>
 <20140106011255.GM3156@odin.tremily.us> <20140106160202.GE27265@t2784.greatnet.de>
 <CALas-ijXQFcUHWk-jJrLifqsMHAKo6NNKya+jR6RJGGDXY76hg@mail.gmail.com>
 <CALas-ijNgaTQr77DZw3acypgaJHpDFVnGdq97ECM4zu+CPma0w@mail.gmail.com>
 <xmqqd2k3ejfr.fsf@gitster.dls.corp.google.com> <CALas-ihPmJSf9eH0P7Vf28pB4zN_dsa_2=fe+_moZgiP0C3UTA@mail.gmail.com>
 <20140107194503.GA26583@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Git <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Jan 07 20:48:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0cde-0005s7-1M
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 20:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbaAGTsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 14:48:30 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64576 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbaAGTs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 14:48:29 -0500
Received: by mail-ob0-f174.google.com with SMTP id wn1so675039obc.5
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 11:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7jlXx6XwTQKx9NUVSRcj0bI493UVs+rWImxWBUpAeTs=;
        b=pfKgEJkg/RfDn4DMqK6CLTbJGdnLGawngD3YzmXra698DaVoXRsetcDXdBk7ArGHsh
         fZSBGUrYFVhgl4TT7DDjqLp2+tcXJz2tcUbKroKT0Dtrn2B7duy0Tw7Bhg5Cohqbb8BO
         5fdOp9xdWhSvRxDtCjis/9njbT0C4wjahyZ6yRLZoPuuJKeplzik6ep3aQlhJfvJKYZJ
         PIPAMJ6kGwlNGTVvXgWklOtcUMTxluzl3FyTnk+GRnusDHtcr6zufEwrp0ADbI885GW2
         bSayjIYGuLVZdGt5bQ+5FBD53Sm2wIBnDdDpVWlKguX044PKLBTJQzQUyjfp0LvjsleO
         8lmQ==
X-Received: by 10.60.50.202 with SMTP id e10mr11866944oeo.39.1389124109012;
 Tue, 07 Jan 2014 11:48:29 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Tue, 7 Jan 2014 11:48:08 -0800 (PST)
In-Reply-To: <20140107194503.GA26583@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240139>

2014/1/7 W. Trevor King <wking@tremily.us>:
>> Junio, for what it concerns me I fully support this patch as, IMO, it
>> makes cleaner the role of the property "submodule.<name>.branch".
>
> No.

Trevor, maybe it was not clear. But I wanted to say:

" I fully support *Trevor's* patch..." :)
