From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Documentation - pt-BR.
Date: Thu, 8 Oct 2009 00:25:01 -0300
Message-ID: <a4c8a6d00910072025l179541e1t67b6dd46f20d61d5@mail.gmail.com>
References: <1253730339-11146-1-git-send-email-tfransosi@gmail.com>
	 <7vhbuek3ma.fsf@alter.siamese.dyndns.org>
	 <20091005100910.GA866@coredump.intra.peff.net>
	 <20091006094701.GG32702@genesis.frugalware.org>
	 <a4c8a6d00910060820se973fcci31c94c42937c7eb2@mail.gmail.com>
	 <20091008001248.GS32702@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Oct 08 05:30:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvjhj-00076O-KJ
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 05:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbZJHDZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 23:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbZJHDZz
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 23:25:55 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:49350 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbZJHDZy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 23:25:54 -0400
Received: by fxm27 with SMTP id 27so5199081fxm.17
        for <git@vger.kernel.org>; Wed, 07 Oct 2009 20:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=/KEsPq/ajhTy3p92ljdbVFR7cSrgaa0DJz9hNC4Xr/s=;
        b=cp9V7ldMycPcQegmPVPMX06xHSxbkuoJQriu0Bi0tVHOV8IUazncqAfze+iiotRL8Q
         CspTop6GTrT4UGP1m97yuWBNqeyLHYgaPFPc2nHVk3PtmEXXEUDyHhD4ciKimx1DEB4Q
         LtpqNNTj7fn2BrzZP8JajYgQARuaoz7gj0sIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ScMYAts59dTaemeaS7DBoU2x6EOV929LgJ9/z7o70T+e4WLDWQdaX1EM2fOoBzaIpS
         x8vXCkXsFvGXrv8FoJuMGjycMQe+/N2JH3C8eUFB6hX+XWvtREXwrqphTMZnvpYIGdh8
         So9wCa1pBYLBLFDPy1CUT77gJawkvYy0ljbvA=
Received: by 10.204.33.7 with SMTP id f7mr570664bkd.123.1254972301912; Wed, 07 
	Oct 2009 20:25:01 -0700 (PDT)
In-Reply-To: <20091008001248.GS32702@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129668>

Hi Miklos,
On Wed, Oct 7, 2009 at 9:12 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Tue, Oct 06, 2009 at 12:20:00PM -0300, Thiago Farina <tfransosi@gmail.com> wrote:
>> > $ ls -1 /etc/asciidoc/lang-*
>> > /etc/asciidoc/lang-de.conf
>> > /etc/asciidoc/lang-en.conf
>> > /etc/asciidoc/lang-es.conf
>> > /etc/asciidoc/lang-fr.conf
>> > /etc/asciidoc/lang-hu.conf
>> > /etc/asciidoc/lang-ru.conf
>> In my system I only have installed lang-es.conf, how I could install the others?
>
> This is with asciidoc 8.5.0, I guess you have a bit older version.
I will check :)
>
>> Sure, I made the lang-pt-BR.conf, and I sent it to asciidoc@googlegroups.com.
>
> Great, then sooner or later you could have those 'NAME' and 'SYNOPSIS'
> strings localised. Till then, I would suggest having them in English -
> git typically supports building with older asciidoc versions.
My patch was added to the trunk -
http://hg.sharesource.org/asciidoc/rev/5bc014ab7c52.
