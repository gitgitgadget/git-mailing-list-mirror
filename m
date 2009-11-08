From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH] Teach the --all option to 'git fetch'
Date: Sun, 8 Nov 2009 16:18:34 +0100
Message-ID: <6672d0160911080718i2a4ff6e0mf6dfd9c5fc5ef45b@mail.gmail.com>
References: <4AF682A5.5020500@gmail.com>
	 <7vaayxfji4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 08 16:18:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N79XO-00008o-M2
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 16:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057AbZKHPSa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 10:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753974AbZKHPSa
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 10:18:30 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:35709 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959AbZKHPSa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Nov 2009 10:18:30 -0500
Received: by bwz27 with SMTP id 27so2654131bwz.21
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 07:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=suMylSWjs8Pcr7BgwSwl+2lwCCFBJnXaunhdsTDMs10=;
        b=vc7n9OWKRLWkLlsHUmoQjsmuvGLeB/rdWG5Tb40NFcpQuYhlv3rKEG3YppFQVmFCWI
         FENNS0TncUvng6BRyr7S25LM+1a/MWZAuAHAMLjbieuhtFjRTorWaFlf3lm2AEhzCZGX
         nezhyO90zzAQndd+1Ab2z74sVVyUwlZsm3kY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=n4ulHopybAzp3n9Mpbs/g+Z1tYPzkuUJOefWbSA29FCeiNCYqc41M1dUU9zICrka/f
         ZzmnJwW38J+FMtGBIX0Oi8FICD/t5pHfkphkoUx7NuTRP7z2RRdC9G0qgMaikltO7H4+
         Epw1XblGhARdIclGgzDqxljgx9KiNWOz9jajQ=
Received: by 10.204.15.22 with SMTP id i22mr1184488bka.13.1257693514462; Sun, 
	08 Nov 2009 07:18:34 -0800 (PST)
In-Reply-To: <7vaayxfji4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132402>

2009/11/8 Junio C Hamano <gitster@pobox.com>:
> Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:
>
> Please drop the "because I said so" part, as I made myself clear in t=
he
> message I was speaking as mere one-of-participants to the project, no=
t as
> the maintainer.

OK.

> Very nice. =C2=A0I like the simplicity of this.

Thanks!

> Hopefully after the parse_options() we can inspect the "repo" argumen=
t to
> see if it names remote groups and transplant the support for that fro=
m
> "remote update" codepath into this, right?

Yes, it can be done, but it will lose some of its simplicity. I'll send=
 a new
patch series that do that soon.

/Bj=C3=B6rn

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
