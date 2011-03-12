From: Alexander Miseler <alexander@miseler.de>
Subject: Re: Summer of Code project ideas due this Friday
Date: Sat, 12 Mar 2011 20:47:07 +0100
Message-ID: <4D7BCDBB.7080604@miseler.de>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com> <20110303185918.GA18503@sigill.intra.peff.net> <AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com> <20110303203323.GA21102@sigill.intra.peff.net> <20110309174956.GA22683@sigill.intra.peff.net> <AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com> <20110309215841.GC4400@sigill.intra.peff.net> <4D794531.40205@miseler.de> <20110310221809.GB15828@sigill.intra.peff.net> <4D7A2EFC.3020505@miseler.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 12 20:47:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyUmk-0006rD-Ec
	for gcvg-git-2@lo.gmane.org; Sat, 12 Mar 2011 20:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545Ab1CLTrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2011 14:47:18 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:52025 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab1CLTrS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2011 14:47:18 -0500
Received: from [192.168.22.13] (f055073147.adsl.alicedsl.de [78.55.73.147])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0LbPII-1QM29A13uM-00kLXK; Sat, 12 Mar 2011 20:47:07 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <4D7A2EFC.3020505@miseler.de>
X-Provags-ID: V02:K0:EvnItQntpQBQPTkplMzLZ5UaVCkTscgm8fjJO2qerRu
 kyq/qDD8wmoLwpI22nO6EVPIP8GeRIYCjem4yLnXCKUBjVSTBR
 ziUiy+JdgvflNlFhSl6usgbmJUQQwt84+6V/1WVNfAc3Bc/GD5
 ychShAtjsCvONaK8sRsmqYtRpdBqHokdvrYK5WN2a9fDxltgYv
 2dz9XDyQl1DX68AdhTLEQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168949>

>>> Even worse yet, commits consisting of smaller files but with a
>>> combined size over the limit will also cause out-of-memories.
>>
>> That generally should work OK. The diff and packing code tries to keep
>> memory usage reasonable, which generally equates to two times the
>> largest file. If you have a test case that shows problems, there may
>> very well be a bug.
> 
> I will look into it.

I failed to create an artificial test case for this (thus probably misunderstanding the exact circumstances leading to this). I will investigate it when I get a real life test case again.
