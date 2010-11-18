From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: How to import bzr repository into git
Date: Thu, 18 Nov 2010 10:38:51 -0600
Message-ID: <20101118163851.GB16610@burratino>
References: <AANLkTinVrwkOvYgGFX3S2530jfWnrAP28gVm4te1B4sC@mail.gmail.com>
 <AANLkTimPmPOJq64=VePSb2efsx17j8BNxCLt_i=b2ykW@mail.gmail.com>
 <4CE32062.6010308@gmail.com>
 <AANLkTimm2unZoUNH=wgnAFjPpeF_C=tJAZ0DkNK4mMv_@mail.gmail.com>
 <AANLkTikLt+=ffsqY1=-fN49fVZ_Q4HVWnzn5qSftg=T3@mail.gmail.com>
 <20101118163702.GA16610@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitri Pissarenko <dmitri.pissarenko@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>, git@vger.kernel.org,
	bzr-fastimport@packages.debian.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 17:39:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ7WV-0003J0-TI
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 17:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759822Ab0KRQjl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Nov 2010 11:39:41 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:40114 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759732Ab0KRQjl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 11:39:41 -0500
Received: by wwi18 with SMTP id 18so272045wwi.1
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 08:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dXzLE+MxOuEgmnsfXkqi/+eH+I1JYDNRjFhcEjCOjRI=;
        b=KfNYRzD0cWUux6M4YFonVx5Gc8oMmOmWOgrPJ07mFx1AabU5LG8AYtXxSCQEsAwKtr
         wAQMrcSevPPZ99V2MuNBFhRyMgIDXab5BNxQyzAK184TEGuMu1hibI6jeZwzko6vJUS7
         zbeFmzo9sFIAVPcq6A88fzrypCvh3SkaKGRh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Wx87MUNiqu2+msZ9TEuM9kw2uc5CY9YpVS/B47ZiroCWyJUEspcPTgjJ8fc0zi6KuZ
         CoRqCEJXCGVaLp621kOc0LDzibLT+J2rc5YZ+VUNndlZ2LHTNDSMNd+0+pqZjEH6++Ld
         x2DHM2JXsKfQMh/ds1VbpRVnTvwE5nvMZv1Zw=
Received: by 10.216.179.210 with SMTP id h60mr846654wem.42.1290098378486;
        Thu, 18 Nov 2010 08:39:38 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id x3sm305492wes.22.2010.11.18.08.39.36
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 08:39:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101118163702.GA16610@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161683>

Jonathan Nieder wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Nov 18, 2010 at 15:34, Dmitri Pissarenko
>> <dmitri.pissarenko@gmail.com> wrote:

>>> However, I had to give up this idea due to an "out of memory" error
>>> during bzr-export.
>>
>> Buy more memory or use more swap?
>
> Or report it as a bug/wanted feature?
>=20
> Cc-ing Jelmer Vernooij in the hope that he might be able to point
> to the right person for that.

This time with a valid email address (sorry for the noise).
