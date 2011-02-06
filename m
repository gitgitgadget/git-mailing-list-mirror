From: Sebastian Pipping <webmaster@hartwork.org>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Mon, 07 Feb 2011 00:49:55 +0100
Message-ID: <4D4F33A3.7060002@hartwork.org>
References: <4D4DEDC4.4080708@hartwork.org>	<20110206051333.GA3458@sigill.intra.peff.net>	<4D4EF7E4.7050303@hartwork.org> <vpq1v3kopn3.fsf@bauges.imag.fr> <20110206231914.GA8147@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Git ML <git@vger.kernel.org>
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Feb 07 00:50:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmEMt-0001uS-G6
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 00:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189Ab1BFXuD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Feb 2011 18:50:03 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:44312 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149Ab1BFXuB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 18:50:01 -0500
Received: from [85.177.91.128] (helo=[192.168.0.2])
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1PmEMd-00072x-H2; Mon, 07 Feb 2011 00:49:55 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20110103 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <20110206231914.GA8147@neumann>
X-Df-Sender: hartwork@binera.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166214>

On 02/07/11 00:19, SZEDER G=E1bor wrote:
> And others are bitten by it every once in a while.  Yes, myself
> included ;)  Maybe this is also one of those things that might be
> reconsidered for 1.8.0?
>=20
>>> Could it be it has been working from anywhere before?
>>
>> Can you post an example where Git 1.7.4 and a previous version behav=
e
>> differently? Up to now, I see difference between your expectations a=
nd
>> what Git does, but not between new and old versions.
>=20
> git add -u was tree-wide when it was introduced in dfdac5d (git-add
> -u: match the index with working tree., 2007-04-20), but 2ed2c22
> (git-add -u paths... now works from subdirectory, 2007-08-16) broke i=
t
> while fixing something related.

So my memory didn't fool me.  Thanks for digging this out.

Can we have tree-wide "git add -u" back, please?

Thanks,



Sebastian
