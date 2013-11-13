From: Andreas Ericsson <ae@op5.se>
Subject: Re: htonll, ntohll
Date: Wed, 13 Nov 2013 13:20:20 +0100
Message-ID: <52836E84.3020901@op5.se>
References: <xmqqr4b5dwke.fsf@gitster.dls.corp.google.com> <5271392E.8020003@web.de> <CAFFjANT=-mQoKUU2KsPHo3Hcq7RAuyM1t4kvJu4OfiNeHrA+Ng@mail.gmail.com> <52713E67.3000202@web.de> <527158AF.3070204@ramsay1.demon.co.uk> <52716C58.3090507@web.de> <5271750D.5010801@ramsay1.demon.co.uk> <52725A05.1050805@web.de> <52783518.1030908@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?VmljZW50IE1hcnTDrQ==?= <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?B?VG9yc3RlbiBCw7Zn?= =?UTF-8?B?ZXJzaGF1c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 13 13:20:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgZQu-000349-Ll
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 13:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759099Ab3KMMU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 07:20:26 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:46996 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758907Ab3KMMUY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 07:20:24 -0500
Received: by mail-la0-f54.google.com with SMTP id ev20so264222lab.41
        for <git@vger.kernel.org>; Wed, 13 Nov 2013 04:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=aoSKz4rMMTwfz7Edo8zq+Z6qjc0RFYDydosNBckaZaw=;
        b=LjFqjqjX0mwS45ffRgPBFXexCOttFZB9CgmBavOqCcD6Xja/hShT8jaaIukdBP8+K8
         HUchUcMVSylaCmIGZW0YMVkkHeITqm0ToPZOQqIZXR6LF0pnoRBgN+bp3DvAPG9zeRaX
         pVx/R3zX1+IN8NtAXu/KIZs2ZQGQLm3id5Hl1NpnOaqFvGYGRl5cBiW2qUC7zW+VNJZ1
         qwcVytuFb5vl+WmfzwXJE4RRiU26DMHWslbgrxiEglD/+vXy8NRedYyUZLuWryiCBzNz
         upRK2jWzITWEqX/tcZ7xwXCB/wBHbiqraMSqkVmYYBLekhLleB+a+GtF6NBoXb0tw+6L
         /Azg==
X-Gm-Message-State: ALoCoQlmpl2jpmce1yMTn4V16rTm2c7kIM5wRr5JBx6WeRsjWd9fG1IGu2ue/+0fzy3DdtzbtdgL
X-Received: by 10.112.128.166 with SMTP id np6mr30689786lbb.7.1384345223568;
        Wed, 13 Nov 2013 04:20:23 -0800 (PST)
Received: from lenix.dev.op5.com. (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPSA id ys4sm32326386lab.4.2013.11.13.04.20.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Nov 2013 04:20:22 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <52783518.1030908@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237788>

On 2013-11-05 01:00, Ramsay Jones wrote:
>
> [Note: I have never particularly liked htons, htonl et.al., so adding
> these htonll/ntohll functions doesn't thrill me! :-D For example see
> this post[1], which echo's my sentiments exactly.]
>

That post actually contradicts your statement, as it clearly states
that "someone at Adobe figured out about byte order and there would
have been no problems transferring files between (big-endian and
little-endian) machines... if the people at Adobe wrote proper code
to encode and decode their files".

htonl(), ntohl(), htons(), ntohs() are those "encode" and "decode"
functions. If you or the author of the post you linked think otherwise,
you're misinformed and need to learn what encoding and decoding means.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
