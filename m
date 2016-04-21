From: Dominik Fischer <d.f.fischer@web.de>
Subject: Re: [PATCH/RFC/GSoC 0/2] add a add.patch config variable
Date: Thu, 21 Apr 2016 19:28:53 +0200
Message-ID: <d6747d29-601f-d9ba-2f27-812bf064edff@web.de>
References: <xmqqio0b5ash.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD0KZk1nTgR8gdbedsAuw2ztWZDWri6EkeEkf8FhwS9yag@mail.gmail.com>
 <cover.1459946531.git.d.f.fischer@web.de>
 <alpine.DEB.2.20.1604211737170.2826@virtualbox>
 <34fb607f-1c4c-528a-cb5d-eca95e0e7c68@web.de> <vpqr3dyud3i.fsf@anie.imag.fr>
 <xmqq4mauucx6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 21 19:29:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atIPk-000123-06
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 19:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbcDUR3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 13:29:11 -0400
Received: from mout.web.de ([212.227.15.3]:49922 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355AbcDUR3K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 13:29:10 -0400
Received: from [192.168.178.38] ([95.116.240.233]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0Mb6EN-1b91ye0nlb-00KhEP; Thu, 21 Apr 2016 19:28:55
 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
In-Reply-To: <xmqq4mauucx6.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:x1JdTjvBPYBfZczn5+87l8U1MlSek4GNSiNOhFJlxz727Oa2VFy
 tYgEmQnAH/1CQi5QSxQChb/lu3VpkugeTU9vR8Hu/WxyC56D7Wl29E+VKaqz5u20JFb/s8C
 P8Z2mz6dMaZFkf8o7GrsHUY8wgDGBtEctlHdg/U9Tddr7FwUdGqB+0tDRoGrGqw6nQfAJq2
 nWr/lU4gkNKDzy3ubVRjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m7kGjOIpMLo=:q6gbjFvAsCgAljwYdV2inz
 OiyhbzAmI0lR1lgItUtMbere1G4h1l4ROzAWIsA6Ww08l3iMzQazOoE6Yp4cqiQoxVZgv6mCH
 forw9h8TMprNTgRb60CkGlHWNGnimILMWvsJrUYqhqq8HiibJ6QyVOlSIPJpvGVUBP6ftFM7G
 5uZ52xRsqD9Fd+meouh+Ixpxs4SWqG/5iMgfz83HAPP4DYUkoqC9921mZ9+uGRG+D81H+dJbQ
 x5xpfuizu5G+Y5mhzzCFYfnNsTwDq88mZfH0tf3LPtRkzUlTrEHMfgSApGEHg000VPBdPYi1X
 pcznmHKm5T5nquF+9urVFhxrnONiIo/1OKCMVsPBoAvHyYpVTVOaq5hy3rToZy2huXhvcVyDo
 sw/R1alQZfJbQLw/4ovVfAb5rPGg4t1HoOKfyiLfNlMGBxBm6zRxEpTkyjnrAOcefWIyrCACf
 muKEF/9Kr0WYeHQ2vp/By2p+7N7/RFwwICfJLTf6Xx6I0AvghAtuaZJXhyXc47zUcQBwqN4cp
 ios2waYNTg9uAtmJhMJdO9P2YNaqDVRPOebhMDp2vtWUhGfkzX3HQHDy2iTomz2xUB9l58zDJ
 EKqueaDthLSzQBpPDySOkqlus7ahbU4UmgBWIlzvt1f1mm9CD0sYBEF0W6Pv8L9etKqavSrTG
 BDz1x64gfI1a9BogohepRtOJc6Zfz4aWldTOStqjghOTi9TPt/1YZ3Pb2905G/vEjJ7nG/ICL
 WXBMhsq5c2swbKhmbMpeoJfbwUVe39zrTt7lt8w9hhR0PVusVeDUCF8xMhX3f6npr13bqnnO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292132>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
 > any transition plan would be far more painful than the possible benefits
I agree, it cannot be expected that every external script sets 
GIT_RECURSION_DEPTH before issuing any command just because of this 
little option.

As an exercise for GSoC, I implemented it nonetheless to get more 
familiar with the code base and testing system and receive some 
feedback. Perhaps the counter can even be useful for some actually 
significant use case in the future.

Regards.
