From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [BUG] git bash-completion is incorrect for "git pull origin mas<tab>"
 if the ssh key is encrypted
Date: Thu, 22 Mar 2012 19:30:05 +0100
Message-ID: <4F6B6FAD.6010905@in.waw.pl>
References: <4F6AC0FA.7040708@gmail.com> <4F6AFEC8.9090907@in.waw.pl> <7vmx78y1eq.fsf@alter.siamese.dyndns.org> <vpqvclwo70a.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hong Xu <xuhdev@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 19:30:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAmmE-0007rw-1z
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 19:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923Ab2CVSaQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 14:30:16 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:56081 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226Ab2CVSaO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 14:30:14 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SAmm3-0002uM-2o; Thu, 22 Mar 2012 19:30:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <vpqvclwo70a.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193675>

On 03/22/2012 06:55 PM, Matthieu Moy wrote:
> Junio C Hamano<gitster@pobox.com>  writes:
>
>> Zbigniew J=C4=99drzejewski-Szmek<zbyszek@in.waw.pl>  writes:
>>
>>> Maybe git-ls-remote should learn --quiet?
>>
>> I would rather think that the completion should ask for refs only wh=
en
>> dealing with local repositories, without going over network, whether=
 the
>> query involves authentication or not.
>
> It depends on what "network" is. When the network is just a machine o=
n
> the same Gb-ethernet LAN, completion can still be useful (only if you
> have password-less authentication of course). I don't use it much wit=
h
> Git, but I find it handy that ZSH completes rsync remote pathes for
> example.
Yeah, I can second that. Even on a slow network, it can be useful. I us=
e=20
ssh with ControlMaster=3Dyes and completion over a relatively slow netw=
ork=20
is pretty much instantaneous.

-
Zbyszek
