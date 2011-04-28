From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 10:08:39 +1000
Message-ID: <BANLkTikwyrwknzPmXwKMAsv5d6PUWSm6AQ@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	<4DB82D90.6060200@op5.se>
	<7vbozr8uo8.fsf@alter.siamese.dyndns.org>
	<7vpqo77dlr.fsf@alter.siamese.dyndns.org>
	<1303930175.25134.38.camel@drew-northup.unet.maine.edu>
	<20110427194233.GA16717@gnu.kitenet.net>
	<7vwrif5q93.fsf@alter.siamese.dyndns.org>
	<20110427220748.GA19578@elie>
	<7vsjt35l84.fsf@alter.siamese.dyndns.org>
	<BANLkTin0=1LdvHgLebuSyUGmFRVzNGoVtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 02:08:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFEmk-0002dP-Hy
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 02:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005Ab1D1AIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 20:08:42 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:48543 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab1D1AIl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 20:08:41 -0400
Received: by ewy4 with SMTP id 4so671794ewy.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 17:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=9qJxUxJhkGv1zhddWIZKSQFKB4i8MXQkyckwaAEN4yo=;
        b=Z5OFGAmYRMnyZGISDf32A1fyz+FzfpadAiADiDr97rWVsYS9uxGOoG0Yog4fGZ68iz
         Qe7pxDasDjljojytSsnMU23AbmBvC/gJBFYX9byqcMObldAUnlkqJuubPeSHiuOjOjJ3
         3Fj11cNfKgaqZSCRdJJfAHWvhOHHlHhGRccpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=iGDu2+914vrFxbzd87lk+zaoD5Vx5+wfiqc1llZ+AZg6Jau9ochL969waYnSr5HBO5
         HtAxvgY4652qgKegFnFvyx+oK0NeBoX56pfr5OQJXJq8W78Z/YkJTuvo6B3dpHxLzz76
         9MHsNJ0tLIA5/jvs/SKnxXxXQzOYkt7SUer14=
Received: by 10.14.123.9 with SMTP id u9mr1241013eeh.53.1303949320024; Wed, 27
 Apr 2011 17:08:40 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Wed, 27 Apr 2011 17:08:39 -0700 (PDT)
In-Reply-To: <BANLkTin0=1LdvHgLebuSyUGmFRVzNGoVtg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172294>

On Thu, Apr 28, 2011 at 10:06 AM, Jon Seymour <jon.seymour@gmail.com> wrote:

>
> gitwork would get into plugins/ by your existing platform manager or
> make install do some minimal validation of conflicts, etc.
>

Sorry, garbled

I meant:

gitwork would get into plugins/ via the path of an existing platform
manager or make install.

One function of git plugin activate would be to perform some minimal
validation to report on and/or prevent conflicts.

jon.
