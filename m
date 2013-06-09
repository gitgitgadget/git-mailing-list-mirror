From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sun, 9 Jun 2013 14:46:16 +0530
Message-ID: <CALkWK0nCe-fDVdYjD=0XrW-MXBrP1aMrcwdmxfZ_bnM+_esuhQ@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org>
 <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
 <alpine.DEB.2.02.1306060904100.13204@nftneq.ynat.uz> <CALkWK0mwxfGJdZi6kSaAPr66o550RiT_p8_r_4mDvcd_VAFYQw@mail.gmail.com>
 <alpine.DEB.2.02.1306061308100.29361@nftneq.ynat.uz> <CALkWK0k8m16oy7u+a8bHK93pRxfomOZDne3k0voVHLGULO+uiw@mail.gmail.com>
 <7vd2ryueuu.fsf@alter.siamese.dyndns.org> <CAMP44s2f2RBGd0VwJaSB1FkHBXRGhrTs_sA80kcinmpzJX8UDg@mail.gmail.com>
 <CALkWK0m4V4KYyKW8KJMRsCgOxqcLi0XDYZvS4w++6BKVVvioyw@mail.gmail.com> <alpine.DEB.1.00.1306090456160.28957@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Lang <david@lang.hm>, Greg Troxel <gdt@ir.bbn.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1ecKtbiBUaMOhaSBOZ8O3Yw==?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 09 11:17:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlbkH-0007Vr-8G
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 11:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573Ab3FIJQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 05:16:59 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:39871 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507Ab3FIJQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 05:16:58 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so5560773ieb.38
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 02:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xAFHIHpuqBPv0AOKHe5Q90OaO5ivkkLlES2qnJUOgdI=;
        b=aU1ShOgAJggaPH5e4QlYvJaCOIfEfcC8lbwzK2bK/t2hYk0z1bKG4FwWdMjav/VC0Y
         4rem8xl0/Mij1+ASpjFq5NJCtTaQhuTbpwLAHo6g4zbY+jlvpwfwcWP3fejI0CopaKhb
         c9Ur588YHlimFFbbY+rl5FAeNTi5ZwE4gW1rsQiiimaO3Hs9tPUXycTtNm3X2ce96H5D
         SA35jGgfBnuPBYKWZi2EczS6usD1SrS/1smZlDeoc4PV7C8CYq0hoRE7l+ifXojDiSVH
         7qlCLcCxiIQjW+8W1PbO5Xigg1ivN2Q61TsgeB8FvONtI1HrdJi+SghJqzCzK+9VwrJj
         vd4w==
X-Received: by 10.50.79.231 with SMTP id m7mr1997635igx.40.1370769418041; Sun,
 09 Jun 2013 02:16:58 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sun, 9 Jun 2013 02:16:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1306090456160.28957@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226948>

Johannes Schindelin wrote:
>> Correct.  The opinions of inactive community members and
>> non-contributors are less useful.
>
> I humbly suggest to treat other people's contribution with the same
> respect you want yours' to be treated.

What?!  When did I disrespect other people's contributions?  git.git
is what it is today because of everyone's contributions: if I
disrespected them, why would I work on improving git?

My opinion has nothing to do with me, or my contributions.  I have
already stated multiple times on the list that I take no pride in my
contributions whatsoever*: I have no ego to speak of.  I said "the
opinions of inactive community members and non-contributors are less
useful [than those of active contributors]", and I'm still scratching
my head over what you inferred.  Do you think that the opinions of
inactive community members and non-contributors are _more_ valuable
than those of active contributors, or am I missing something?

* You'd know that if you read emails on the list.  But you don't, for
some mysterious unstated reason.
