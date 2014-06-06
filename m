From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 20/20] CodingGuidelines: avoid "test <cond> -a/-o <cond>"
Date: Fri, 06 Jun 2014 21:04:08 +0200
Message-ID: <539210A8.5040003@web.de>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com> <1402066563-28519-21-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: jrnieder@gmail.com, Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 21:04:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WszR9-0000xZ-88
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 21:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbaFFTER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 15:04:17 -0400
Received: from mout.web.de ([212.227.17.11]:60469 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146AbaFFTEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 15:04:16 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0Lr2Dz-1WFEyH191v-00eahR; Fri, 06 Jun 2014 21:04:10
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1402066563-28519-21-git-send-email-gitter.spiros@gmail.com>
X-Provags-ID: V03:K0:cUTr+fV52OcAaPP7Nh33ea2o0UeoLDEBziiTTjFItVTTmxyM317
 xfCwMi/EynmfM5poOBKQ8r3DWJyoc9doOf5/rg2ndW4UTSVMD4zhbRUiuMID5egkqjURdYu
 DF3pNj5A5tq93C66p01bS0tcE+pjek/LT9vd8dOOUIARi2QRjMTaIAIsOhXNguldwkGtsER
 n+TrduuT0b0pxQ1Rex+zQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250957>

On 2014-06-06 16.56, Elia Pinto wrote:
> + - We do not write our "test" command with "-a" and "-o" and use "&&"
That "and" "and" "and" could be somewhat confusing.
How about:

We do not write our "test" command with "-a" and/or "-o".
Instead we use "&&" or "||" to concatenate multiple "test" commands instead,
because the use of "-a/-o" is often error-prone.  E.g.
(The rest looks OK)
