From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 1/4] submodule: implement `module_name` as a builtin
 helper
Date: Thu, 6 Aug 2015 21:54:21 +0200
Message-ID: <55C3BB6D.5090905@web.de>
References: <1438882524-21215-1-git-send-email-sbeller@google.com>
 <1438882524-21215-2-git-send-email-sbeller@google.com>
 <55C3BA48.6050600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, hvoigt@hvoigt.net
To: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 21:54:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNRFG-00054N-33
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 21:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597AbbHFTyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 15:54:25 -0400
Received: from mout.web.de ([212.227.17.12]:60900 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755347AbbHFTyY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 15:54:24 -0400
Received: from [192.168.178.41] ([79.211.102.26]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LuuNx-1Yf3uw0zar-0103cv; Thu, 06 Aug 2015 21:54:23
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <55C3BA48.6050600@web.de>
X-Provags-ID: V03:K0:Fe/GzvBtI1W9kzO/FEsGYIRT4FbkxHwOgWxTZmaeqS7LEL/E57+
 Vf60re/gb1w7yzz3ePD2TUFwcdSzHX34jWz6jk5iIuGgjYoW72+LGwmVm9nVjezmcVl1yLS
 EPTM9fL4jHuCPNSqFKyRAKQLT8gaovZqY86chpV/zkwhrM6RURUXKPZZcP3+zU8v9WQn40h
 HKFSNWH6jgh3HgwCzM5ZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yJ7FwuAHbTs=:Xj42tKANw0tLvTDAuhEucz
 ZllN0JsrbB61oe0A9l9W6nrLOn9sC1yJTRzIfHAe4XeEHbfZgW/gB128IFlnhBL4Dg7tPpdTa
 bPK2aQfoSbH8Sbcl++ROm48KgM0lqXZdjgFb8VyuT2fa1ITTXnuxaJKVc+ZP/fETGr87db/mf
 3dHo3flSzyDO06LyBP9wWaMFPKB0NR2t87MWC0+Botns1/xKrGbQ7LmuNCthnKunlSUJw6fJa
 AzDNdFRVze/0dRspqOV5yRfmc4kyMsroMWjtitHAHKLYiQ+w3bEFfCOCFixxY8QWlMf5cOZ6w
 dktu2RXqPaSrA/nlL23NC/dsdnS7qedE1u4xAZiwDCI6xYZKyouDx7o5rr2ro1qLnM6gIwQtX
 2yHjOeIn2ncUjkc4Cj7IqY99OgjRgS9eSGWhO3T5pDPcfKFofKpmMnv5pdq3OMcNCJVLGi74Q
 ymVnI0ZztZz/o7665UIsoSvzyOYLFwLmXKiggwFn1ril7FPepbaBasv1eGUQv6KPEPGdRRIzp
 ee+kY6eUXNA+I9qAyNJ1S47NTkGJFYtrNN7wc4+mMu6synRnUnp5TT4Jmv8w5uPOZjl6pEqaF
 zKaW1l3Gri9OwmI22vYsEAKhuM/AzGd4A3v0HeUM0ZWrKMTRr7WHMnoqp/+stIt3Hd75WKNA+
 sm+rL9ZqsOnzTItBRpTDzdtsvuEAWQ/1okKJG9SXe5EZ6mTtjmkS85uRBWkBrcQ2jt7o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275441>

Am 06.08.2015 um 21:49 schrieb Jens Lehmann:
> And wouldn't it make more sense to keep this patch together with
> the "submodule: implement `module_list` as a builtin helper" in
> its own "submodule-helper" series and have the following three
> patches in a separate "parallel fetch for submodules" series?

Please scratch that, I just now read your comment in the cover
letter on that ...
