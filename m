From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [RFC/PATCH 6/8] config: add core.untrackedCache
Date: Thu, 3 Dec 2015 17:10:37 +0100
Message-ID: <5660697D.5090308@web.de>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
 <1449001899-18956-7-git-send-email-chriscool@tuxfamily.org>
 <565E99F9.2020906@web.de>
 <CACBZZX5eQuaYumFcuW6PO_FCrAd3Vqq8gPyg5JeZ4Kk+0YBGRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 17:11:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4WTV-0007SR-L0
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 17:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbbLCQLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 11:11:12 -0500
Received: from mout.web.de ([212.227.15.14]:52683 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844AbbLCQLM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 11:11:12 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0Lfipe-1acBTT1g8g-00pPTP; Thu, 03 Dec 2015 17:10:45
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.4.0
In-Reply-To: <CACBZZX5eQuaYumFcuW6PO_FCrAd3Vqq8gPyg5JeZ4Kk+0YBGRQ@mail.gmail.com>
X-Provags-ID: V03:K0:fnGc3NCEfONYdTNSfPJSOT/6qInBbuSvCTPRr1pDh+4AGs7NZny
 NhQiKgVak5GR6uX4CgHV8z6BrfLgwrdAQz9u2XYY8FvIGrgpsI096QkTP0dJOwMxAs/x6R6
 70fuMQIIdSZ+cS7PcNhysIIp7ygJYZONNDXyDfka2Q6LW1M8EuiOsbd4wE+ZRXj5WmwNO/+
 yM8HaCDGggHpRRBoKoA4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xavu5OtSkng=:Qivo1RVo0C51jgsFopULRP
 U6EuqiQSsDO+FCQNIb+4Q4wIu1WLzBGiSCsmHuSnVZFXY0ChWuiewB7paBe9V3a9Bqk8P+ByI
 P2B2OtQ9yzGVJLYvNi4UVb+LsTT3pY3s5Zc0H4qTYncdMeC1ifwkOZFMdvjbyEowjBJ54OCXs
 bPFadb0hqmLdbxQfOOsgby4lj8YQ0dYFuiLyKJ8Woo2iYSqSE/2UJCMBktSfVOX7mps0/+y5J
 HvKCU+M+inWgwKYVXRudJGrd0TzO2njhBD4FzhBCNRAjrN493OK5132AJf93svoJKgs0fTOrU
 tauK6sBGqx/zhjH0I16ijgNHd9PvH43aeCZ0Z439IUyTpM9FZUQR0oJuRip9WH665VDS8qcHc
 N6jq2nzdRY61c50orL7YbvBG4nn4ZzDt0hbSw57ev6Qye7l4YTPbFFTgsmFTF/Bl1Q0OJnUqP
 q75iqaUQAMxwIDkaGRPPe5CxKWcXAEnZqJ0aZe37svMep5S9FRzdnKYEWfT+xohiw69Yywyvn
 L3rv84NBoBz2ddydcY8XZNhVCYDPOFZrGHTYqnAVigbXKvW2nyr3EcUKiHYGXO6eay86CDGOR
 eONvYb3hdCQyWPvODLn2Q+EglwBwtTVFrD7QDlug9CdcAoxpbxBcZO9P6kSqwD7bcGYDvG29h
 /bpGVn0YSAV3i7xy8gfkSpID7A3HvgOYkqit1LdgLJYt5fMyLAB9qFYJ8IYaWFBH1fzO934GZ
 RofRKHMkyoUBwoMwq12w89BGEdKwkIXUt3/JHte/RAm/NCVUHShOgDcewZLwFCCS8lJVrIph 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281956>

[snip all good stuff]

First of all:
Thanks for explaining it so well

I now can see the point in having this patch.
(Do the commit messages reflect all this ? I need to re-read)

The other question is: Do you have patch on a public repo ?

And, of course, can we add 1 or 2 test cases ?


Thanks for pushing this forward.
