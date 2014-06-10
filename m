From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH v2 00/11] Zsh prompt tests
Date: Tue, 10 Jun 2014 16:28:46 -0400
Message-ID: <53976A7E.8010001@bbn.com>
References: <1401176460-31564-1-git-send-email-rhansen@bbn.com> <1401915687-8602-1-git-send-email-rhansen@bbn.com> <53976563.5020905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 10 22:28:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuSf7-0004O8-8s
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 22:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755067AbaFJU2t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 16:28:49 -0400
Received: from smtp.bbn.com ([128.33.0.80]:53871 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754501AbaFJU2s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2014 16:28:48 -0400
Received: from socket.bbn.com ([192.1.120.102]:34841)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WuSf0-0002AV-OS; Tue, 10 Jun 2014 16:28:46 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 820EE407E8
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <53976563.5020905@web.de>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251231>

On 2014-06-10 16:06, Torsten B=F6gershausen wrote:
> On 2014-06-04 23.01, Richard Hansen wrote:
> []
> I haven't digged too deep, but this is what I get on pu:
>=20
> ./t9904-zsh-prompt.sh=20
> ./lib-zsh.sh:emulate:42: too many arguments
> ./lib-zsh.sh:emulate:52: too many arguments
> /lib-prompt-tests.sh:.:6: no such file or directory: /lib-prompt-test=
s.sh
> ##

Thank you for trying these patches and reporting your findings!

>=20
>  zsh --version
> zsh 4.3.9 (i386-apple-darwin10.0)

zsh 4.3.9 is over 5 years old (2008-11-03).  Is that young enough that
we should still try to support it?

>=20
> I'm not a zsh expert, but I can offer to do more tests/debugging if n=
eeded=20

I'm not a zsh expert either (I just got a crash course over the past
couple of weeks), but if I were to guess I'd say that the 'emulate -c'
option is new to zsh 5.0 (2012-07-21).  When I next have time I'll try
testing with a bunch of different versions of zsh.

Thanks,
Richard
