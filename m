From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/25] gettextize: git-merge basic messages
Date: Thu, 2 Sep 2010 16:13:39 -0500
Message-ID: <20100902211339.GA2801@burratino>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
 <1283456446-22577-11-git-send-email-avarab@gmail.com>
 <20100902200940.GB2531@burratino>
 <AANLkTiksZykH4zDbdDReYYgJZk7gmZ_2g0v=9X_MP73p@mail.gmail.com>
 <20100902203711.GE2531@burratino>
 <AANLkTi=ZQAjA9SN1A3WDr-L2rFA6v-XH0mZAkhuUgdAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 23:20:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrHCP-0006FV-0m
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 23:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757963Ab0IBVPe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 17:15:34 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46949 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757938Ab0IBVPc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 17:15:32 -0400
Received: by wwj40 with SMTP id 40so1387717wwj.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 14:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=m4gGCPGBybJh8whOi18ReDwY98LMMoOY7Fp/wpMjVRk=;
        b=x5PVGtEsQPTtksQb7GA2mZvrLVwijsV8eRPdqPhC6BJ0qATb0Bc94tQBaz7ySKdZkB
         Chr1ma7DiX27Y1V6U3hM2Z6T1doxHsEt9RBrzWstNM1IPrLrqveT/tpKnfKRQuJD+J8/
         j1b63WvWD78zaf+jDWITYLHTfQDHYDfZSKxN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=OhD75Mk6omeU2rzDwU+rPyfBvJ66w7L7rbR2p1IEWQ2LvKr+wmDL6QwRfa1kgwKzeD
         vWOfFOtwrl0cTD72jAG/a9vqYwvaicSOIIrPVUxIAj2Dzlt0Q+71rnuQ1jdG6vXOyuDw
         Pu43EfGiTwgYMl2wM52P2vhTihhYDjbjonq0M=
Received: by 10.227.143.198 with SMTP id w6mr327773wbu.124.1283462130524;
        Thu, 02 Sep 2010 14:15:30 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id i14sm783024wbe.18.2010.09.02.14.15.28
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 14:15:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=ZQAjA9SN1A3WDr-L2rFA6v-XH0mZAkhuUgdAg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155209>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Yeah, I was just hoping I could get away with it :)

To be clear, I think you made a reasonable choice at this stage of
development.

Aside: maybe for translation (though not for gettextizing) the idea of
patches that get applied to the development tree is more trouble than
it's worth.  GNU sed and some similar projects do not include
translations in the development tree but fetch them from
translationproject.org as part of the "bootstrap" procedure when
building a source tarball or binaries.

See autoboot in git://git.sv.gnu.org/sed.git for example.
