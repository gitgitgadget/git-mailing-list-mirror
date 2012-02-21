From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 0/8 v6] diff --stat: use the full terminal width
Date: Tue, 21 Feb 2012 01:26:42 +0100
Message-ID: <4F42E4C2.7070801@in.waw.pl>
References: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl> <7v4nuljcnk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	pclouds@gmail.com, j.sixt@viscovery.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 01:26:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzdZH-0006dB-Mp
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 01:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847Ab2BUA0v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 19:26:51 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52874 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754814Ab2BUA0u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 19:26:50 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RzdZA-0008Rk-Q8; Tue, 21 Feb 2012 01:26:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <7v4nuljcnk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191128>

On 02/21/2012 12:41 AM, Junio C Hamano wrote:
> Zbigniew J=C4=99drzejewski-Szmek<zbyszek@in.waw.pl>  writes:
>
>> JC:
>>> Perhaps the maximum for garph_width should be raised to something l=
ike
>>> "min(80, stat_width) - name_width"?
>> I think that a graph like
>> a | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++
>> b |    1 -
>> is not very readable. I like the consistency forced by the 40-column=
 limit.
>> But I guess that this is very subjective.
>
> The above makes it very obvious that there is a huge amount of change=
 made
> to 'a' and a bit of deletion to 'b', compared to a mini-graph that is
> truncated to half the screen width.
Yes. But the same graph with 40 columns tells me exactly the same thing=
=2E
OTOH, if the filenames+graph fill the whole 80 columns, everything is=20
nicely aligned wrt. to text above and below. Maybe it should be=20
configurable after all?

> Besides, the above is what you would get without your patch on 80-col=
umn
> terminal, no?
Yes.

Zbyszek
