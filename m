From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Tue, 09 Apr 2013 13:51:58 +0200
Message-ID: <516400DE.4080809@gmail.com>
References: <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com> <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com> <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com> <20130407212342.GA19857@elie.Belkin> <CALkWK0=Q-P-fGLmkoiV3_CJ43MNmFzpfkvFjNUwxB+zOsqTxmg@mail.gmail.com> <5162763D.5030708@web.de> <CALkWK0m5iN8h0J1EkbMTJoXy6QHHzyTjRfPnhL3XMgi=NAi2eg@mail.gmail.com> <20130408081959.GD20159@elie.Belkin> <CALkWK0nz878Xh9BFSCrtBGT=g3fys3uBy7QQs9cdWaFtoS8Rsg@mail.gmail.com> <CACsJy8CAW1h4rAOK_2+EAFEL28CKeqf4vqROsLByjZaMU3D-ow@mail.gmail.com> <CALkWK0mLG78anjbcVRF7Zpj-hMmts1pshF=XhLh--MCYV66Gng@mail.gmail.com> <CACsJy8D-M3xMkO7CPmOzeMxRV0Bv6MtCjH5eCr_vguxPF2N0vg@mail.gmail.com> <CALkWK0m93ZzWVJVUxgVQGUTK8t2pTEaDAPs7vW-
 tcgiewjOLwA@mail.gmail.com> <7v1ual12pj.fsf@alter.siamese.dyndns.org> <CALkWK0=2T5BA8+dro8U7bcp3ODsuQAj78mEPnxs=ERqf9FhSBQ@mail.gmail.com> <7va9p8yjuf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 13:52:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPX5x-0001q0-CP
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 13:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935613Ab3DILwI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 07:52:08 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:40861 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755740Ab3DILwH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 07:52:07 -0400
Received: by mail-ee0-f43.google.com with SMTP id e50so2899322eek.16
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 04:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:newsgroups
         :to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=in4mtJuZKNXYFPis1v08OTyXZ5lCxi/qQtdE6H+Wxis=;
        b=AAJHs+9lt8ctaOgxHqbzsU9GPL10ezyx8F/fgXA5lGF7Rn9VsDiAbGX6tM7dfuJIIH
         MTzBn2FIeJ+UVVr91TreaHW1xg3h05iRwyGHoEwQZif3FfwJK+Uc6BBBpWU3mb/b8mWE
         k1+KAEZ25mFPXyWCIRg1cHRGO9XbFHn3MLTW6L8wLlnpWjekGB9xDKiuaDnfz0EJdMTo
         DzcB+GW1vNOC7j2pnp5z3zxWusKpDce0DVmcoifshqQy8Gp6N9NESpjeYNuCpYh7VCXm
         49bxhyazw7JsG9VFhjnhqo9gsE30FTJyeg2VxCxeYVSoP+2o1/b9QhyyN4KLrnOTJtxc
         8ECA==
X-Received: by 10.14.215.193 with SMTP id e41mr59355207eep.32.1365508326282;
        Tue, 09 Apr 2013 04:52:06 -0700 (PDT)
Received: from [192.168.1.14] (eio154.neoplus.adsl.tpnet.pl. [83.21.130.154])
        by mx.google.com with ESMTPS id bc1sm37532564eeb.11.2013.04.09.04.52.04
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 04:52:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7va9p8yjuf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220564>

Junio C Hamano wrote:
> Ramkumar Ramachandra wrote:

>> 2. If we want to make git-submodule a part of git-core (which I thin=
k
>>    everyone agrees with), we will need to make the information in
>>    .gitmodules available more easily to the rest of git-core.

> Care to define "more easily" which is another subjective word?  The
> .gitmodules file uses the bog-standard configuration format that can
> be easily read with the config.c infrastructure.  It is a separate
> matter that git_config() API is cumbersome to use, but improving it
> would help not just .gitmodules but also the regular non-submodule
> users of Git.  There is a topic in the works to read data in that
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> format from core Heiko is working on.
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

BTW. this is something that I was missing to implement better
submodule support in gitweb (and thus git-instaweb) than just
marking it as submodule in 'tree' view.

--=20
Jakub Nar=C4=99bski
