From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git-gui and gitk-git as submodules
Date: Mon, 28 Jun 2010 20:58:49 +0200
Message-ID: <4C28F0E9.8080903@web.de>
References: <4C24C34B.20403@web.de> <7vlja3j7hu.fsf@alter.siamese.dyndns.org> <20100625190147.GA17493@burratino> <AANLkTimqXhGw5fAAgZsoDAI9s6kaIzcka9mbFEW8j05v@mail.gmail.com> <4C25E83E.4080905@web.de> <20100626183154.GA13581@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 28 20:59:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTJXw-0008M4-Ir
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 20:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146Ab0F1S6x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jun 2010 14:58:53 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:57966 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab0F1S6w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 14:58:52 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate03.web.de (Postfix) with ESMTP id 8D00315890432;
	Mon, 28 Jun 2010 20:58:50 +0200 (CEST)
Received: from [80.128.76.242] (helo=[192.168.0.214])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OTJXe-0005CT-00; Mon, 28 Jun 2010 20:58:50 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100626183154.GA13581@burratino>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX185Z10yIJRmH7XsXxf04ZCfRxUhJWLbeJtkaUna
	7qIKOV2ciIR5h67cJRurpb0yaNdmZdXm7cjoWOwLob8RYROk94
	PqQPgL31dyQDNCV/m+IA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149848>

Am 26.06.2010 20:31, schrieb Jonathan Nieder:
> For the latter, maybe it would make sense to introduce =E2=80=98git c=
heckout
> --recursive=E2=80=99 which runs =E2=80=98submodule update --init --re=
cursive=E2=80=99 after
> checkout.  IMHO, in git 2.0 this even ought to be made the default.
> One could use --no-recursive to access the more flexible traditional
> behavior.

Yup, I am working on that (I did post a WIP patch some time ago where
I added a '--ignore-submodules' option, but since then I changed my
mind on the name and now too think that '--[no-]recursive' is a much
better choice).
