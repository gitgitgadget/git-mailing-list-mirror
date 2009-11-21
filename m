From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.15
Date: Fri, 20 Nov 2009 21:29:53 -0500
Message-ID: <2c6b72b30911201829i52ffa022qff827bdf317ad447@mail.gmail.com>
References: <20091120133117.GA26917@diku.dk> <20091120135004.GA3919@debian.b2j> 
	<2c6b72b30911200755l16b306cey16efb42fe9ba27da@mail.gmail.com> 
	<20091120162543.GB3919@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 21 03:30:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBfkA-0002Ut-Ea
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 03:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbZKUCaI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Nov 2009 21:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753805AbZKUCaI
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 21:30:08 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:37563 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbZKUCaH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Nov 2009 21:30:07 -0500
Received: by iwn8 with SMTP id 8so2976935iwn.33
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 18:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=ORyG2Y+LdvoHNkF8CAcemNgkxN9tYSQe9hKo3zaIXns=;
        b=j1ClUqzMoA+0xwH7m/R9c+nwxzHgu8g7XIs7Kd+af6Xg6G+0QaEKCVzLG9LAV0CL4r
         heRyLDpWiis/5ywCxPj9K6Qywa7GHFBcUkBrueYV7e7BwwOMhE/VUPygQ09oaavs52VY
         hsBjjSObBGwl+49aMkPHQGqh7LqbGEgySFKyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=ADKcYAOQqAUjzJOomJsrtzABGdtasiVpdXfjo2ewKNX5RjEq5ya4MthaYMm56Ev7Ct
         mU95jksfARgoN9vzXdZnTg311MvqiyaJ97TUQRt3l6rkaSTKkGMQFa0I1IPkTcjtuvgv
         XyUwoDZ4s9WiK2LtLX+IJvDMmK8LjKkvcdo/Y=
Received: by 10.231.170.201 with SMTP id e9mr1567985ibz.16.1258770613129; Fri, 
	20 Nov 2009 18:30:13 -0800 (PST)
In-Reply-To: <20091120162543.GB3919@debian.b2j>
X-Google-Sender-Auth: c5f325f203cb5f74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133389>

On Fri, Nov 20, 2009 at 11:25, bill lam <cbill.lam@gmail.com> wrote:
> On Fri, 20 Nov 2009, Jonas Fonseca wrote:
>> install-release-doc-man:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0for doc in $(MANDOC); do \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout =
origin/release $$doc; \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0done
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(MAKE) install-doc-man
>
> Thanks it works. =C2=A0Could you also commit this to git?

Done, but using git-checkout-index ...

--=20
Jonas Fonseca
