From: Alexander Miseler <alexander@miseler.de>
Subject: Re: Summer of Code project ideas due this Friday
Date: Fri, 11 Mar 2011 15:17:32 +0100
Message-ID: <4D7A2EFC.3020505@miseler.de>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com> <20110303185918.GA18503@sigill.intra.peff.net> <AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com> <20110303203323.GA21102@sigill.intra.peff.net> <20110309174956.GA22683@sigill.intra.peff.net> <AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com> <20110309215841.GC4400@sigill.intra.peff.net> <4D794531.40205@miseler.de> <20110310221809.GB15828@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 11 15:17:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py3A5-0000XM-3D
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 15:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268Ab1CKORo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 09:17:44 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:49923 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238Ab1CKORn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 09:17:43 -0500
Received: from [192.168.0.32] (dslb-188-103-098-160.pools.arcor-ip.net [188.103.98.160])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MPbr3-1PtwYG14rp-005TCA; Fri, 11 Mar 2011 15:17:33 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110310221809.GB15828@sigill.intra.peff.net>
X-Provags-ID: V02:K0:REBfeYk6inehYjlzwmWvqBwQZDSxJcNis7NDHBpfMdd
 K0auqQmEVYSscyfJ0UR1Ctpm8d7zuxkbfpN1gX0lILDmiREkqS
 Bep9yfKHubMkqCo3sZXJdmCucPC57RyQn4MFoKlZ5O+5bCxyB+
 z5IM0oqWJotJJxZvrusJz75emwstxH78UBxAlMvyfFAOaWU8AP
 uFskWwrgTeX9yXG+exdkA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168901>

On 10.03.2011 23:18, Jeff King wrote:
>    1. The fundamental design of git does not prevent storing
>       arbitrary-sized binary data.

agreed


> But I think we are probably in agreement with what needs to be done to
> make things better. Specifically, I am thinking of:

agreed


>> Even worse yet, commits consisting of smaller files but with a
>> combined size over the limit will also cause out-of-memories.
>
> That generally should work OK. The diff and packing code tries to keep
> memory usage reasonable, which generally equates to two times the
> largest file. If you have a test case that shows problems, there may
> very well be a bug.

I will look into it.


> But don't let that stop you if you want to take a look at it;
> I'm sure there is plenty of work to go around. :)

Certainly ^_^
