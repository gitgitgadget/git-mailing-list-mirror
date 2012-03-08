From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] fast-import: fix ls command with empty path
Date: Thu, 8 Mar 2012 09:29:38 -0600
Message-ID: <CAGdFq_iKaruvsLi73F6oVwLs95Ka0AbSRx3UsFv-HVr9OzNqHw@mail.gmail.com>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
 <1331184656-98629-1-git-send-email-davidbarr@google.com> <20120308070951.GA2181@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <davidbarr@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 16:30:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5fIO-0002ON-CL
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 16:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756858Ab2CHPaU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 10:30:20 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48360 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756738Ab2CHPaT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 10:30:19 -0500
Received: by vbbff1 with SMTP id ff1so452063vbb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 07:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=CXz9g3D6AJaJUFtXW38oChbHBQoUtTlmQzhKf+PU0cA=;
        b=BShJRBXsfN2N7uGyrM3z/542eyWtaPh4UpG1ZnEoddTW1BpWJqsKWOEXiVow7h/lcp
         INAdLXk1wazTvhqzWlx3M6WgBfgX9o8El1jt2sPVNs37rbyr7tkfoD9OgXxkx0+sFzrt
         bjzy4xxAyjopotaE1i6fGJ8SXB8NvFeU5NdN180dqXcPadTlXN57+hmN2m5dBREQkd7c
         85Z1TKu9ergfcXZa3AO6VlWIaAFLpNHGDSTTqy7Iak9DVecraAQFTlSz2M+Vfxxl7Di1
         yaHqfEJgeXWOFbvTRPab8Ld44sy4bKuyta/mz80WuXiDiOELXWQCSyrPNxLVwJV9Edtz
         ugXA==
Received: by 10.52.173.104 with SMTP id bj8mr10463522vdc.83.1331220618370;
 Thu, 08 Mar 2012 07:30:18 -0800 (PST)
Received: by 10.220.215.2 with HTTP; Thu, 8 Mar 2012 07:29:38 -0800 (PST)
In-Reply-To: <20120308070951.GA2181@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192610>

On Thu, Mar 8, 2012 at 01:09, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
>> [Subject: fast-import: fix ls command with empty path]
>
> I would s/fix/accept/ to be more precise about the nature of the
> breakage. =C2=A0(In other words: rather than mishandling ls with an e=
mpty
> path, fast-import was not handling it at all.)

Makes sense to me :)

--=20
Cheers,

Sverre Rabbelier
