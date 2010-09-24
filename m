From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 08/24] t9300 (fast-import), series A: re-indent
Date: Fri, 24 Sep 2010 09:22:44 +0200
Message-ID: <AANLkTimjD6LqMgQSez=t9N_KPsXaFXm3sMcrZc=qQug+@mail.gmail.com>
References: <20100701031819.GA12524@burratino> <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes> <20100905031528.GA2344@burratino>
 <20100905032253.GB2344@burratino> <20100924065900.GA4666@burratino> <20100924071631.GI4666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 09:23:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2ck-0001ER-L5
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749Ab0IXHXI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 03:23:08 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54174 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab0IXHXG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 03:23:06 -0400
Received: by gwj17 with SMTP id 17so858653gwj.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6/aav3DJVm7u4nJHT6b7r4yHTqbwSCYKSlQsbRydsaE=;
        b=yHIuRcn1GoUlMkdu4f4Necaqng/q7jZylCawiCNltu/oCbJzh+BWDo91iV4MN4QwfM
         TQlKa1OqImb0Hnafzp+ZwkNDfAbIe/dBadyTcJDsKvUulYcR3HRFsLshnlEfsLxhdJjC
         A59zrVrJTzm4KxtAVo9MazwazqzeyU5FAjZHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=G9GyRqgJed3vjz1KN/U0jCkLb8Yz+DDNZbIthr+ZKdrMksP8hyFlEAT11LRPHonSO/
         eUgSMDvgaVZoPfApWvjXiNtmvR1+/1Mv9pLLUuHoNEu7NrLtDPTROPsbrQNmZSK9V3CW
         MZKxLVqHoYIHtaQn9eT+8vjaAJxPoDjx6u7KQ=
Received: by 10.150.12.16 with SMTP id 16mr1746489ybl.236.1285312986131; Fri,
 24 Sep 2010 00:23:06 -0700 (PDT)
Received: by 10.151.82.3 with HTTP; Fri, 24 Sep 2010 00:22:44 -0700 (PDT)
In-Reply-To: <20100924071631.GI4666@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156946>

Heya,

On Fri, Sep 24, 2010 at 09:16, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_expect_success \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0'series A: foo=
 bar baz' \

Sometimes this style is used if the test description is otherwise too l=
ong.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_expect_success 'series A: foo bar baz=
' '

So what do you do in the case that the line becomes too long?

--=20
Cheers,

Sverre Rabbelier
