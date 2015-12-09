From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 5/8] dir: add add_untracked_cache()
Date: Wed, 9 Dec 2015 08:37:15 +0100
Message-ID: <5667DA2B.3000506@web.de>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
 <1449594916-21167-6-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershause?= =?UTF-8?Q?n?= 
	<tboegi@web.de>, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 09 08:38:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6ZKl-0006Vy-Vu
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 08:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbbLIHiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2015 02:38:05 -0500
Received: from mout.web.de ([212.227.17.12]:51402 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbbLIHiE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 02:38:04 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LeLSr-1ac4Ia0nzp-00q8Hk; Wed, 09 Dec 2015 08:37:33
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.4.0
In-Reply-To: <1449594916-21167-6-git-send-email-chriscool@tuxfamily.org>
X-Provags-ID: V03:K0:6m2IwISlBiuHozg/3OFdIqtVgili3At6nYUHTN5rthN0v4LoJFU
 MOeeZ8WFiUHCTIMjEKYYUiZH2KvwHmzlyh1eU8t8P3MrOzZOi39rbszzMhx5yPLY2R0yCxp
 twiZfJwdIsBus9K4ng6oQ9OsC3hk7/Plop0+7ZCm9Y8y/7Aqr8H4v/9NwG2yrneX5YZzMn0
 PF9uKgtgGi5IOWERNeM+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1JJqh8iGahI=:Cb0YwBo+6m7JksBGsEry7l
 l7RDAQSvqNJp2uQyXm2pib5aMjOSq4LLQyw30NepMSBx3BjAOgAeJ5Caj1BMfbBB0jARxy567
 W3Vvd42LfCe0GEk5MDbkByEUhPjp5PnnCyZtwyDRCzoQ08vPOHun9dMmcpAxdS3AT659Pz4lZ
 kSyWZPJ3XeFNWeNzTP7wkBrvi+wIHgSGbEHJ7qn97/lecRyIiJltE7u+hwrcipcqpczYJmFuO
 hB4p4EM03aYiEPvw8OrdNfkLcX99GWZ0sa0tLp7z0YPPz86fHdOXCGt/vow3D2AKjD0k3kS0o
 tlZojJhNhYJIAGBa+vDNICseOy36XFMDGnG6jHQPhO6aRq6kMCTrXbOw6dwTt3RrnpLGxu0yt
 zUUonwmIwvH4vY54R5OA65Z6j05eIHuMhWbCIeRnJaWTlY0OSsrjHw3Hr39m9iAftrpZeEj32
 PChqobP8sMtmoinbUjq0R2JVO7e6LAiGc3mtSV4mSxT5+/RwmAF+132hk+8OVIvSa9W3LMdXm
 Q1LrDyDsNNDQqUJT7CHJjHdufKP9Q3tL6QMsgb4Sf9haNrvPM4n8pV4VvpfqD1kDvMxZg78Zk
 mW+G3ir5FAW3FWZm3EwyJ2RGHbdrsrKKdq4S68W545Y/EL5J1iS1Ty0jMoqu+O0sXd8L9GDps
 6pmkeEmU/VT4u8NherzradoYrwBCVL47ZAXKHw4mzCM4585R8QUPzGqv6ux9sqwRL0JR6UdXh
 ks02F71IaCQPQUS1BzlhODEtiH22umMrv6NI7S+1CYUXKFOQf1tifosVugPlEFChC0uJmYSZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282186>

On 08.12.15 18:15, Christian Couder wrote:
> This new function will be used in a later patch.
May be 
Factor out code into add_untracked_cache(), which will be used in the next commit.
