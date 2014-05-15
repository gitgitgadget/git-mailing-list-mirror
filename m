From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] Gitweb: Convert UTF-8 encoded file names
Date: Thu, 15 May 2014 22:45:22 +0200
Message-ID: <CANQwDwffdbqD96OadyECFs=6WY_t+_0b63L5yAZVQ8aXrMvHHA@mail.gmail.com>
References: <20140514184145.GA25699@localhost.localdomain> <xmqqd2fghvlf.fsf@gitster.dls.corp.google.com>
 <CANQwDwdh1qQkYi9sB=22wbNnb+g5qv5prCzj2aWhHBbTZhVhdg@mail.gmail.com>
 <20140515050820.GA30785@localhost.localdomain> <alpine.DEB.2.00.1405150957520.10221@ds9.cixit.se>
 <20140515184808.GA7964@localhost.localdomain> <CANQwDwe+GJ+yAYWdVfMaHq97zGXBoepCfUdLiaQD9LFoz3SiOA@mail.gmail.com>
 <xmqqmweiessl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Wagner <accounts@mwagner.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 22:46:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl2XZ-0005n7-Q2
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 22:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837AbaEOUqF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 May 2014 16:46:05 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:54285 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755652AbaEOUqD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 May 2014 16:46:03 -0400
Received: by mail-oa0-f47.google.com with SMTP id i7so1920746oag.34
        for <git@vger.kernel.org>; Thu, 15 May 2014 13:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=87FocE0A2XW2javBFf9cFIowZ1gUHHVh0JF0zzFmZbg=;
        b=zo3UY0Pbr+reNmUF2QiPBMDnq01zWhw9JVh4vcYN3c9Uu0OgMh9f3LsUt8A7r84GWb
         KoQqahUMMgx4/WoWqDA76mVS0MJUuHDcxEQbi/SfXytdji18L+b6GiSJALW3GMJ21NZG
         yeippo4EWoKukIK482ivRMEBi8EyeJ3fMQNBPYa1DoIVWVRKfsRvpcXwpZ97GknGjjtE
         8jFWhZ3Tln1OEZ+NNAJ1RzYAtFu/yH47lT8dQNuBjC03H9zLPXoftdzhUtWlldbtcDBT
         iqHdDAxUJM3C8Sgvme71WKlkCMVh1ytHwSKJMksvYSg+X8tbkeiHZoYx6xvFktUfgKQp
         PMUw==
X-Received: by 10.60.17.132 with SMTP id o4mr12515520oed.34.1400186762687;
 Thu, 15 May 2014 13:46:02 -0700 (PDT)
Received: by 10.76.132.4 with HTTP; Thu, 15 May 2014 13:45:22 -0700 (PDT)
In-Reply-To: <xmqqmweiessl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249200>

On Thu, May 15, 2014 at 9:38 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>
>> Writing test for this would not be easy, and require some HTML
>> parser (WWW::Mechanize, Web::Scraper, HTML::Query, pQuery,
>> ... or low level HTML::TreeBuilder, or other low level parser).
>
> Hmph.  Is it more than just looking for a specific run of %xx we
> would expect to see in the output of the tree view for a repository
> in which there is one tree with non-ASCII name?

There is if we want to check (in non-fragile way) that said
specific run is in 'href' *attribute* of 'a' element (link target).

--=20
Jakub Narebski
