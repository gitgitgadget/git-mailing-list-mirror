From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/2] update-index: list supported idx versions and their
 features
Date: Sat, 23 Feb 2013 13:53:19 -0800
Message-ID: <20130223215319.GF3222@elie.Belkin>
References: <1361534964-4232-2-git-send-email-pclouds@gmail.com>
 <1361584468-11820-1-git-send-email-pclouds@gmail.com>
 <20130223205356.GC3222@elie.Belkin>
 <7vk3py7mi5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 22:54:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9N2Y-0005zE-Uz
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 22:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759241Ab3BWVx0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Feb 2013 16:53:26 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:56308 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759069Ab3BWVxZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Feb 2013 16:53:25 -0500
Received: by mail-pa0-f41.google.com with SMTP id fb11so1096029pad.28
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 13:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=LVOMMtjTTC/ELZZFBqmWp29CPKVlmw/AGhwMTW00tMs=;
        b=yIE/KlYS/01IFmdI9rVr0sGrwtKfnLXk/86SnRIu1H8KJozcMLtTFlGzXJrlD1B4WA
         WZ9l2F+dwKzvGLPMOZdjA00Jn9Oo0g82yu5PQTbXdfBJ28FJuhAv0sibu0AgU7/RgkM+
         ES74S/cGsUmPGLzxjhbaFTxZxgVvLSxs6icNpCkIhdqQCaQ6kphQPQy2gtEreebMVJAF
         oWbvaHCufYPf563xYe+6fhDCwER69lUQSYryAJoj76KJIdXfv8Twt3VoOnLHvROvQ9mW
         ZOUynuD+xYqgClLM1+CJBHkj7gg+ZvWzwpHOjD0Qvbn1pfZk6Tyxedlz13RrQsq2Rtrq
         v3FQ==
X-Received: by 10.66.251.39 with SMTP id zh7mr11383592pac.169.1361656404969;
        Sat, 23 Feb 2013 13:53:24 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id rl3sm7111604pbb.28.2013.02.23.13.53.22
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 13:53:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vk3py7mi5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216919>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

>>> +	Version 4 performs a simple pathname compression that could
>>> +	reduce index size by 30%-50% on large repositories, which
>>> +	results in faster load time. Version 4 is relatively young
>>> +	(first released in 1.8.0 in October 2012). Other Git
>>> +	implementations may not support it yet.
>>
>> Usage nit: s/could/can/
>
> I think s/could reduce/reduces/ is even simpler.

Yes, true.  Thanks.
