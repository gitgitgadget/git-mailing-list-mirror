From: =?ISO-8859-1?Q?Dirk_H=F6rner?= <dirker@gmail.com>
Subject: Re: [PATCH] git-cvsimport: add support for cvs pserver password 
	scrambling.
Date: Fri, 14 Aug 2009 08:17:17 +0200
Message-ID: <4da546dc0908132317t656f503ah5adc6e0cd09f0288@mail.gmail.com>
References: <5794AED2-43FF-4441-8292-0C9BFB3139A2@gmail.com> 
	<20090410093434.6117@nanako3.lavabit.com> <7vhc0udiac.fsf@gitster.siamese.dyndns.org> 
	<alpine.DEB.1.00.0908131837110.7429@intel-tinevez-2-302> <4da546dc0908131219q149844abi453d8429847af1cf@mail.gmail.com> 
	<fabb9a1e0908131304m53ab2a68p9faade35969add5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 08:17:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbq6p-0005GD-LC
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 08:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756378AbZHNGRi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2009 02:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756365AbZHNGRi
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 02:17:38 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:61322 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756285AbZHNGRh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2009 02:17:37 -0400
Received: by ewy10 with SMTP id 10so1290924ewy.37
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 23:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=f/2pacyfWeywxPkViCwFsuHstrBPa6WpO6JnwRN/pEo=;
        b=DE6+lFVZM2JrW2nbViooCdP9U1Md2gg4VsuIETpm0iz+F+zSQjRNc+xjEIZ850yx9b
         qocL4EYl56sRlcko3Dlj67uYMyYOiDDux9Y53RqJq1GO+LAJHxwIGhjLg/jQBpkCg5RW
         I9c1/J2C6PvadGXdSlmjSSJYjmJUMRIPulBLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fJ2zaZyQXZJxfAdptuqb0lZQrj7AoFmq4lclQOXGDIP45Boz1XBHIy+7tWQxYYHtfl
         u31Y3+CGuoenWeDX5r8LzDNgh+JBpZDZadY9gH+uHzm1pxlSS0dQE6DtuRL+rI2HzP3/
         iZszO1ETm/foWxyYKwQaTVklLU7AUhhWuDI7s=
Received: by 10.210.27.4 with SMTP id a4mr392687eba.37.1250230657133; Thu, 13 
	Aug 2009 23:17:37 -0700 (PDT)
In-Reply-To: <fabb9a1e0908131304m53ab2a68p9faade35969add5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125899>

Hi Sverre,

thanks for the heads up, I will resend it in a minute.

Ciao,
Dirk

2009/8/13 Sverre Rabbelier <srabbelier@gmail.com>:
> Heya,
>
> 2009/8/13 Dirk H=F6rner <dirker@gmail.com>:
>> sorry for the long delay, but I finally sat down, hacked two testcas=
es
>> and amended the patch after rebasing to the most recent HEAD. Find i=
t
>> attached to this mail.
>
> I think we'd rather find it inlined, as per SubmittingPatches ;).
>
> --
> Cheers,
>
> Sverre Rabbelier
>
