From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/4] fast-export: don't handle uninteresting refs
Date: Tue, 30 Oct 2012 18:08:23 -0700
Message-ID: <20121031010823.GX15167@elie.Belkin>
References: <1351617089-13036-4-git-send-email-felipe.contreras@gmail.com>
 <20121030185914.GI15167@elie.Belkin>
 <CAMP44s3LP65XOYFg-tBe_rzT1+gXp=714C-u14mkwxY26r4b=g@mail.gmail.com>
 <CAMP44s1tFhh3Xqe9tqoDAdtwnGc=kFT6OmAreeP1nbTstweaQQ@mail.gmail.com>
 <20121030214531.GN15167@elie.Belkin>
 <CAMP44s1b+E8a0kdSgREbGzRTFy+nCw4VcjHadd3soQAXRkNzZw@mail.gmail.com>
 <20121030220717.GO15167@elie.Belkin>
 <CAMP44s3ArAQXH+-EbH4MHYaV6fTAWdwGzBdZwzn_qtCABHyonQ@mail.gmail.com>
 <20121030235506.GT15167@elie.Belkin>
 <CAMP44s1ftDijYpZW_Reu5qNi1T_L52_353ngNaRW3W1gz+k9jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 02:08:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTMnW-0002Xy-Va
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 02:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934855Ab2JaBIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 21:08:34 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:42464 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933152Ab2JaBId (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 21:08:33 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so567522pad.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 18:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PJ6thUj8aoNtGJRjcWKhmCCAG8d6tEfZ/hXcyT4iYgE=;
        b=LmQp1C5oUDcTQSJ1wHHvHFPnsurmOXlAgjxsCVSFQMoyPVuU3bKny7LVItPw7nxFoN
         gQ4KDMOTEJZAwTB3jqYBZQGzKy5IY4giN8YD+aCrQ2zpSV6MShlQiDIdOE3Q4aRHW+qP
         n/0wSisWcRr+szmMX+XlqAdcuNVCbcJckKPWxSx6Nbh6V5MmzGeEdc3Z7Gfsj5yShlSa
         R7dLMlflVG3HQf7jjkkFGpCe+IIiSzz/9kPAxOgRoc3BL1SQHkxSBR4hrV2tZoRf7+T8
         JniyFkK06n3E6DpmwyEcE2bJV1atN7RVsKXVqo7sPf5f2KaVIJd1BxvcJ/Ra/vSMzC5G
         uFfw==
Received: by 10.68.137.228 with SMTP id ql4mr108479883pbb.125.1351645713093;
        Tue, 30 Oct 2012 18:08:33 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id c1sm1233930pav.23.2012.10.30.18.08.31
        (version=SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 18:08:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s1ftDijYpZW_Reu5qNi1T_L52_353ngNaRW3W1gz+k9jw@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208776>

Felipe Contreras wrote:

> I don't think it's my job to explain to you how 'git fast-export'
> works.

Actually, if you are submitting a patch for inclusion, it is your job
to explain to future readers what the patch does.  Yes, the reader
might not be deeply familiar with the part of fast-export you are
modifying.  It might have even been modified since then, by the time
the reader is looking at the change!

Sad but true.

Thanks,
Jonathan
