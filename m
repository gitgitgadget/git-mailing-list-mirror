From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: git-archive ignores submodules
Date: Thu, 16 Apr 2015 19:56:23 +0200
Message-ID: <20150416175623.GJ21868@paksenarrion.iveqy.com>
References: <CAL1ZDKZs++NkLoHZ_w_YebQuZYG3rgAiH5SsaQfTmb9MPHjR3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pedro Rodrigues <prodrigues1990@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 19:56:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yio1f-000865-U5
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 19:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbbDPR42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 13:56:28 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:35119 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbbDPR40 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 13:56:26 -0400
Received: by labbd9 with SMTP id bd9so62730978lab.2
        for <git@vger.kernel.org>; Thu, 16 Apr 2015 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zZvY3T4xWfwPJmwPCSfi6qYii/FlddvBITTaJ48ykss=;
        b=AJ5qKGfwIcDKsT9m51ddFF2rmJc99VU3H/iFO1hs/6CE4ol3vHd+Qedmfdy2ExCMIY
         TIw6wSkqYyH4B0uKA4KIy75YbD7QW5rKAdARd8SXDLZ8gruJFt1wrN5be7umY1Z/NaHS
         R/qliWOkEoWNlrHcvmB97EUZS2UswRITL4Tj0jHvUQhuao6ZocG0LAoKc76PcMCF/IT3
         G14V6EG17zgignoMa/RZo9oTORu39vbxoH3LyMAju7tyKEdUlp4hjgCho7KQhTzOb9ES
         KxO8fwXs3R52+AFWs8IY746NF7Dtfyf0fYK3lOF9eWtiMoPcLxsRazbC+3T+2duDPaMC
         cj7Q==
X-Received: by 10.112.125.193 with SMTP id ms1mr30052836lbb.31.1429206985284;
        Thu, 16 Apr 2015 10:56:25 -0700 (PDT)
Received: from paksenarrion.paks.iveqy.com (c83-249-10-52.bredband.comhem.se. [83.249.10.52])
        by mx.google.com with ESMTPSA id x7sm1844573lag.3.2015.04.16.10.56.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2015 10:56:24 -0700 (PDT)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Yio1X-00029E-Dm; Thu, 16 Apr 2015 19:56:23 +0200
Content-Disposition: inline
In-Reply-To: <CAL1ZDKZs++NkLoHZ_w_YebQuZYG3rgAiH5SsaQfTmb9MPHjR3w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267317>

On Thu, Apr 16, 2015 at 06:35:38PM +0100, Pedro Rodrigues wrote:
> I've been using git-archive as my main way of deploying to production
> servers, but today I've come across a git repo with submodules and
> found out that git archive has no option to include submodules on the
> output archive.

As far as I know this is an known limitation that's just waiting for
someone to solve. Thanks for bringing attention to it.

> This simply makes git-archive unusable on this scenario.

Not completely. There's a simple workaround. Combine git submodule
foreach with git archive and make an archive for each submodule.

Not as simple as if git archive --recurse-submodule would have been
implementet, but hopefully it can make things work for you at the
moment.

-- 
Fredrik Gustafsson

phone: +46 733-608274
e-mail: iveqy@iveqy.com
website: http://www.iveqy.com
