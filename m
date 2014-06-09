From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: [RFC PATCH] clone: add clone.recursesubmodules config
 option
Date: Mon, 9 Jun 2014 16:27:25 -0700
Message-ID: <20140609232725.GA9047@odin.tremily.us>
References: <xmqqoay9wvo6.fsf@gitster.dls.corp.google.com>
 <1401874256-13332-1-git-send-email-judge.packham@gmail.com>
 <xmqqvbsgvb9l.fsf@gitster.dls.corp.google.com>
 <20140604194216.GA4636@sandbox-ub>
 <539020D1.1090601@gmail.com>
 <20140606055430.GC77405@book.hvoigt.net>
 <5395B3D3.9060501@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Chris Packham <judge.packham@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	mara.kim@vanderbilt.edu, Jonathan Nieder <jrnieder@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 10 01:27:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu8yT-0007SJ-B3
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 01:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbaFIX13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 19:27:29 -0400
Received: from qmta13.westchester.pa.mail.comcast.net ([76.96.59.243]:34008
	"EHLO qmta13.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751388AbaFIX12 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jun 2014 19:27:28 -0400
Received: from omta22.westchester.pa.mail.comcast.net ([76.96.62.73])
	by qmta13.westchester.pa.mail.comcast.net with comcast
	id CPNP1o0021ap0As5DPTTsL; Mon, 09 Jun 2014 23:27:27 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta22.westchester.pa.mail.comcast.net with comcast
	id CPTS1o003152l3L3iPTSLr; Mon, 09 Jun 2014 23:27:27 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 5E9B6120E25F; Mon,  9 Jun 2014 16:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1402356445; bh=ZOFfXCGO3HIwI/OV8Ha8Gj18g4utjZrSz77Tdgb6PgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kMJfH7k4pvSsHZkVOCBk9sxlFM53I1KbUXiN9pGtonemgg9QpUmY/ss/dZkblu/KI
	 kUyxZnTbIBqCmEtSoHV61m4vi4/G3Hr91GBaJmF7DU1fJadNOr8LMeJMq7cMQnMJOZ
	 7WtV+w0ycDtbacXbY0O//+TuBw/Pl7D9JCehJx1A=
Content-Disposition: inline
In-Reply-To: <5395B3D3.9060501@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1402356447;
	bh=sXAkmz1/IJhNKuV+vJpLQRTrn4JDLv7IAudozPwPLZw=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=Xm5eFq8fmiZ529iWh4cHK8ay7g0HgZhFJqD7mycZnVm+90QqQFxqFRROwtgVc1ktR
	 ZEi/LxP+rxy5VIWIIsfADD02KO1qEa1wu1bXGCOZm2zaX5if9XA4g5WRBGEALn0zwC
	 wTINBoZBCLm+5domVQref+jfCbb/3LECnM3KVxjl4gLnVxF/7hz93ZUc7T1FE2xygU
	 VYo7vH1WhiYsM6KQZRXa9TobDCT8Ga4Z81+Rzn9ckA9/7+HyhxgIWEU6Mj3lqKqj6l
	 Wdd+MX1Xhy2GkGyXL2CA09SzLneSAJ+ub32fYRA3Y9DgFHOx2i+0XE5+Q9oqtjiWPj
	 YJlI4RsNGBUCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251144>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 09, 2014 at 03:17:07PM +0200, Jens Lehmann wrote:
> And by the way: wouldn't it make more sense to tell the user /what/
> we do automatically? So maybe 'submodule.autoupdate' is a better
> name for the new switch?

Or autocheckout?  No need to preserve submodule-specific jargon when
we have a perfectly acceptable word for this in the core interface ;).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTlkLaAAoJEG8/JgBt8ol8XYsP/1B2saETZfDH3s59OX7ZasyN
yYjhPFB+hjYSwpORlxeIsjApSIcdttHVL/6oBWZcQ/NULSQN+b0RYaQ55JRzBel0
S79vj1+ip31fuUJyk/tHSDEN2meL7AhJXcZxahnn1WxTzS/+MwEnKYpJaz65rs/x
RI0lVmMbjp6oOIINZMVlqX3ByULT6JAPDso27AtS5asAvkBzypIM4YqkrOuAf6U1
nzjvDpYbwkuCN6bKTm10SYj1MPzAZo4ZV3j3JZODsDXH67TLLKUtAZ1MbmkvLO/H
nqNeUv6GdtTh3IhlKB5vF8PrtM5S/7e458bArA2Pjmq784wdEwPGIYNvaNKovuhu
e3HWtyg6yyroPBK/9W1LBenBguQCOfwF3m6EBQtNUu0UMSnqAN+juVZTa6FXmpRR
lY3scvKP7BVzauEYycO2KMr72WrW+P7ienLm/ol2ATm1ysriXfhFzro3XhIS9U31
z14clQzMZp//HloxQYJbNcU3A/Y9rVr4GifjvY/SLCGZTui5zFsa5ok+wfyyGtnz
niu+INKV5OiQN0jE3WWMClLLFImrgrVqG9A9dr+ngzdqT3gReQxZqoNDm4yTicYJ
QMpQANYQHXH0U1oloyWdYWqnq6W7aDEdhcY9EC8EjN5jX3yHZBJWPqcZeuUVZ1s2
5Z9ROc9EGSVXnP1nQNN5
=ZR6a
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
