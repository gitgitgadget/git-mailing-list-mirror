From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t/: work around one-shot variable assignment with
 test_must_fail
Date: Tue, 20 Jul 2010 19:14:02 -0500
Message-ID: <20100721001402.GE4282@burratino>
References: <8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil>
 <iU5XdZGtMeaspoCqSJIp6Y--60TPVkZUrm3SdW86dsTZkNYZWqbSppLBrMXyL1rVqqYtHm94ACo@cipher.nrlssc.navy.mil>
 <AANLkTilzC8iMikfBieS_pcChP7_F4hA6bT1ydWHD4etP@mail.gmail.com>
 <20100721000101.GB4282@burratino>
 <AANLkTik0gKFfDCmcLZnn4WFCFY3Lb5zRgrzKLAgD5qH6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	erick.mattos@gmail.com, jaredhance@gmail.com, drafnel@gmail.com
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 02:15:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObMxn-00049L-NL
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 02:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305Ab0GUAPA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 20:15:00 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61507 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504Ab0GUAO7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 20:14:59 -0400
Received: by mail-iw0-f174.google.com with SMTP id 7so6208805iwn.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 17:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=x6qaKcg0MZREHOlqsdrxjkpF4yBU6hYx2lYpWBjDBRk=;
        b=ik8x5j9DCZeiTv4ai+/2EmZ6LuX6CYYixNXA6WIvicEr9PKjRfBUJELS7iai1JcFuH
         K+jYq6ulTuDbHZGUQ2D0SF9Om6xNDee4W3AzmlEP+qi9s1BD14lE+f6eqGBxHdL74Tcx
         akNWrZcxdcFI95TAkE06bCDR8h5NzgyKrNcQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=s6YDsJflzg4sT60o1XpUtIO2yGZnCSz9SrtA2SDDNk5Ki0in0JQrKIGQFWOY2srDU3
         QqZH6pLJx3Xwh+y9vMKZPhb/hB1qBnnXDs2o6XhMPJMSRv/ukzBPQvShb4Adtdg2iAFa
         Kxa81UJbds+qE+70x2V99P1adt232Cw8WKeMw=
Received: by 10.231.34.70 with SMTP id k6mr7906956ibd.25.1279671298692;
        Tue, 20 Jul 2010 17:14:58 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm28066932ibh.10.2010.07.20.17.14.57
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 17:14:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTik0gKFfDCmcLZnn4WFCFY3Lb5zRgrzKLAgD5qH6@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151380>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> We should have examples for both export and unset

What is unportable for =E2=80=9Cexport=E2=80=9D is the effect of export=
ing an unset
variable.  I am not even sure whether the return value is unportable,
but it doesn=E2=80=99t matter; that is an example of a =E2=80=9CDon=E2=80=
=99t=E2=80=9D rather than a
=E2=80=9CDo it this way=E2=80=9D.

See v1.5.6-rc0~61 (filter-branch: fix variable export logic,
2008-05-13) for an example.

> but the prose
> should mention both IMO

Yes, thanks for putting this portability guide together.

Jonathan
