From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git error in tag ...: unterminated header
Date: Sat, 27 Jun 2015 10:57:23 +0200
Organization: gmx
Message-ID: <5bf3e78138813d8667f4761cc7bc23a3@www.dscho.org>
References: <20150625155128.C3E9738005C@gemini.denx.de>
 <xmqqegkzzoaz.fsf@gitster.dls.corp.google.com>
 <20150625201309.5026A384E81@gemini.denx.de>
 <xmqqegkzy1ri.fsf@gitster.dls.corp.google.com>
 <2b124e09d9c89ff3892f246ea91aa3c4@www.dscho.org>
 <xmqqoak3wkkq.fsf@gitster.dls.corp.google.com>
 <xmqqbng3wheu.fsf@gitster.dls.corp.google.com>
 <d455a77d76b3558fb79d550d6ed4468d@www.dscho.org>
 <20150626155248.GB30273@peff.net>
 <xmqqh9puv0a8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Wolfgang Denk <wd@denx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 10:57:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8lvl-0008NI-V0
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 10:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbbF0I5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2015 04:57:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:54492 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940AbbF0I5g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2015 04:57:36 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LoaCE-1YbOFL3RPu-00gVOi; Sat, 27 Jun 2015 10:57:25
 +0200
In-Reply-To: <xmqqh9puv0a8.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:c6Ajq5c6i90qUIwNWy+zHErOv6MDmgQZbpEK5pzsZuYRsxKw54e
 pmAXUaAUWf65JhWmtuo6j72CwWMi+Im9FsEZSi4408D4Jr80yTefL50tkonY1QJk2D0iDVB
 Yf4O8QCKUMTab7GStZQTvFS00++kzQl1109YTwoTCXNyGqfM36grdqzDljp2URqjZig9iyG
 8xMYAgYO5SdE8FtZeZO4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jy3Y9sywyvQ=:p8Db9Aq4fu0a92z6adFYAp
 28mV9c0JQHU+rChRTZkdVrW5ymvVfObrV2Z6pRUNnf2POSIN9u28kuQnxO4hoFExnQSKxh7ZY
 cHntf6GX30/vfQQxOZzKdFJsIUhhLXz67ecEZlcldcYrXfujUhCkBHmgwPRi/Bw4lPyFtCjkw
 ju7NgjEQOczFRUXARcap8vZwEPr/QPSFyzneoiiJrL+vMbEI/L/vjL8I1u+FOW6pvE65Onsoy
 kxtk1tSWKBS9k78o8TMhXGhYbJ6fHVT5piRg3WBXiy8BiurgSaJU0b9DUoCjdgsSNb9Z8q/ox
 3Fjgz3GVBX64J9NA7mqcTxkO5zk7Sxwih/1LeFIj+zzj3hPEjKqSgDDbTcDpo1P3lhRWaxCXK
 HCPoLsoUsBHmMcbukK3IKkydMsHvKvNu3UMHfNds/oh+MXbNxq0wqsaWoCoBTsdfn1xlvM2Wq
 f1GejxYGX8F1p2UIc4j47j8bHIo93aIU8sglpFwPWvY3LiHDj1UBto0Hi3CAcur81oInfBn14
 fgI6Jh8hCzyyNhzWSMkedrvuChRP/n8SgBb/yNBLiHHCLl9JBIRvrzEHN22GYG1VnNXWcGX60
 eaj++8T7wEDn2qM5BzlgnL/qsYP2aqiJ31laL3Jw9K0B4nBJr13dn0MJSzdErprAV2HBQq/l8
 MgYuxpnSx77/YH/NVQLR/CY0szFk7kDMw/qkcfwRuRJNzhU0F23qTnhh/UobQOU1kDoU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272856>

Hi Junio,

On 2015-06-26 19:37, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Fri, Jun 26, 2015 at 10:06:20AM +0200, Johannes Schindelin wrote:
>>
>>> I understood what you were saying, but it still appears too fragile to
>>> me to mix functions that assume NUL-terminated strings with an ad-hoc
>>> counted string check.
>>
>> Yeah, I agree. It is not that you cannot make it safe, but that it is
>> simply a fragile maintenance burden in the future. I thought we dealt
>> with this already with a1e920a (index-pack: terminate object buffers
>> with NUL, 2014-12-08), though.
> 
> Hmph, that is an interesting point.
> 
> It would mean that the require_eoh() can be reduced a bit further.
> 
>  * It is still a good idea to make sure we do not have NUL in the
>    header part,
> 
>  * It can still stop scanning when it finds a blank line (i.e. we do
>    not care what is in the message part of commit and tag),
> 
>  * It does not have to insist that a commit or a tag has a blank
>    line to reject a header-only object.
> 
> That would mean the name of the helper needs to change, though.

You mean in addition to your changes to read new lines only when we're still inside the buffer? I cannot say that I like this fragility (and would prefer the aforementioned patch that simply allocates a NUL-terminated buffer in the rather unlikely event of tag/commit objects without an empty line), but then: you are stuck with maintaining this code, so it is your decision. ;-)

I will hopefully have time starting Tuesday this week to work on that patch, if nobody else beats me to it.

Ciao,
Dscho
