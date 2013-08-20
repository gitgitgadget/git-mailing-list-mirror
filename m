From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCHv4] repack: rewrite the shell script in C.
Date: Tue, 20 Aug 2013 15:46:36 -0700
Message-ID: <20130820224635.GK4110@google.com>
References: <1376864786-21367-1-git-send-email-stefanbeller@googlemail.com>
 <1376954619-24314-1-git-send-email-stefanbeller@googlemail.com>
 <52136F9C.6030308@kdbg.org>
 <52138686.1070304@googlemail.com>
 <5213BC0C.6090901@web.de>
 <5213EF74.7020408@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	gitster@pobox.com, mackyle@gmail.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 00:46:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBuhI-0006YE-Nq
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 00:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525Ab3HTWqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 18:46:40 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:58591 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3HTWqk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 18:46:40 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so1004541pdj.30
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 15:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PppDAe7z33GBWjGAV+hV0wRkI+x+Kr31CylX9A6yNAA=;
        b=f1dn6NJNqpOcnjPIx0CJIn/KZokZANi5XitOr2BarXJJnbAoA4LKB9LWdIeP6Xv+Wk
         0C8n6+9E3ZZPElmranHAsmd95atiOB21hwSs5k5NcUi4YNtXrBIlGj3is09q4sTXxOrP
         QwNs2maUy36Y8ggSOZPKXpWcdyn59xsCVpj3BbEbMyI49u5+AW9e2EkXXvnapQ+yXT3O
         RU2798cS7nccVUEyBiZmLsN1heBLck+5mW/5xPIY0phXvsHZXZ2S2y8vuI3G8SQeTdZ/
         oUCBNwDXqEzZQQnR01VyTZDC5PngFH/TlQLJWGL9N0N4vYAzRiAOXYhNOVl/+eZrwtrE
         WcUw==
X-Received: by 10.68.134.202 with SMTP id pm10mr4591525pbb.2.1377038799672;
        Tue, 20 Aug 2013 15:46:39 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id in2sm4302454pbc.37.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 15:46:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5213EF74.7020408@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232662>

Stefan Beller wrote:

> I think I got all the suggestions except the
> use of git_path/mkpathdup.
> I replaced mkpathdup by mkpath where possible,
> but it's still not perfect.

No, mkpathdup is generally better unless you know what you're doing.

> I'll wait for the dokumentation patch of Jonathan, 

I never promised to write one. :)  I would have preferred to have a
rough draft with the results of your investigations so far to start
from.

Oh well.  I'll look into it tonight.

Thanks,
Jonathan
