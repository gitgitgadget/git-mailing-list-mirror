From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/1] convert.c: correct attr_action
Date: Tue, 23 Feb 2016 06:26:26 +0100
Message-ID: <56CBED82.5040400@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>	<1456117898-30357-1-git-send-email-tboegi@web.de> <xmqq8u2d88ce.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, tboegi@web.de
X-From: git-owner@vger.kernel.org Tue Feb 23 06:26:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY5Ub-0006B7-Vo
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 06:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757231AbcBWF0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 00:26:34 -0500
Received: from mout.web.de ([212.227.15.3]:59514 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751574AbcBWF0d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 00:26:33 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MfqSa-1aLvtf3Cc8-00NAq5; Tue, 23 Feb 2016 06:26:27
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <xmqq8u2d88ce.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:EVhVPOPmUD+Qizsgxfwh1qPGvxwf3DW8snMJzMkqsLcfR0kuGge
 9RBdS3IkyoJHIPkvohQHooRjFcH+SW1o34OpQYoUqpWbF8C7DLWMukVYL2aG/tLPfK64mJF
 BQDH9+cQWSkRx8xlhf2sckQhiCcyjjvEv/rjDKXnhKY0mogb5ORr5Ymo0r5/FmZAM7lRZNu
 fY7cO92HYEtCbwLj06YKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yLwHchwDsfc=:NsrLvWgTfGe83V9WiQWixK
 voTBkGzEn/yoxJwZ2hpShYrcapsiFzsSSqPv0nuvsemTFzqdmiP0OJ7fdyKAfE/1i5LDt9CrZ
 tfwl8bhhFBU/6Q5TXxphFlKxTWsHp9gqqKj5XqSjlFiVNRBdmQhpEVEwfCzjP+mRbYcrBTuKf
 OThTaSczATQTHindUfw3ITuRU4KH8lcoq2S2b29JFrJbOdoAwwNAwoYtpiWNFS2NuJ904N3rl
 kbR3VtyH/JB5tDZZxwVCKV470sG7KABW8Ti8DR0w/+2DFrKFbURzyjnUuO+576vqXoK0T7chU
 5fCcoYXTtkz56uVPGhDdAex2FIaOj9rOkHX51arOSYZOVfv3kiUnwuWb+EZL8uLSiOJUWpW/A
 K3qX+r16Wvyo+NdoPS6XhqlzhPWZlQnrn8oko1g3b1qqZHG0/9iOZ6WVjWLdo6vnFjXvIMppG
 9ugqys5/4+D0a82tR5b50rP4HqObl3R0a/P1BSyNjSEngdkQ/jZPKG9Sff/ldGZRjQBXMYE4z
 bvNPsQHw65UKuyz3WH0ZP+KQpnXo+jw4Llvk3SkXVEkKFDguKYCL3jgVDrOAS76SyMSgvWzZE
 2RzMXS6WPLx0kC85jUiVeKGIhUBqmTGaqyyM1HeiDqsyfk7nrABnR6cJAMeDGOeGOb7UMB7z9
 JKduE+ggiLXuiyNiyiohchxQyEEIuh351oU45CWRIyxmhV1cQDNQGwGyQEMznIJhnKsYAThtj
 X2VLyPtgLQT0yjZqUhjy/rwFk/PvnCpws3gEExM1BeueTgXHhcusHmuI6skkU0AzO8W/yC1r 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287016>

On 02/22/2016 09:20 AM, Junio C Hamano wrote:
Thanks for all the comments,
I will send a new version the next days.
