From: Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH] add: add --chmod=+x / --chmod=-x options
Date: Tue, 7 Jun 2016 15:59:23 -0700
Message-ID: <20160607225923.GA66447@zoidberg>
References: <20160531220818.GB46739@zoidberg>
 <xmqqtwhd3lht.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1606010919360.5761@virtualbox>
 <xmqqwpm8zyot.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 00:59:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAPyC-0005hF-FY
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 00:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbcFGW7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 18:59:32 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36330 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbcFGW7b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 18:59:31 -0400
Received: by mail-pf0-f171.google.com with SMTP id t190so8278006pfb.3
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 15:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bEsVYapm2PLQ2iOepL+iYG47a/OyVIeqAMkH8SvIQws=;
        b=jJPGunb4Yh1XhcE3wjqMt/ogtKbYK9WeuEX1oEMh8pa+M4m4OPU9vcuqKtexc9HaZD
         /sQQY0oCty5nTRl3IWJmrjLUZg7mpsVhAPhQ+11Z7CiEUMCo6gxP+D66Idg3h1X6vdNg
         /UKMdxSHL/j9sv1u0lUl6HZfaNxH7oZFtn3UN7shc0vBcpIyl5TZsG/Qom2J60cukcbP
         FkYXat6I+C8Co1tHeC2WEmNF3vs8x1tZwLnLsc8v3WEkuYLQDmNpWkAJ3QtvquMp3Wv/
         H46o8l0jnCpVJ7cQUsD/WERhCH77z3kGmMloVnyxVtxOc4m+W+L1VC/pweJRlGt/YATx
         Q2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bEsVYapm2PLQ2iOepL+iYG47a/OyVIeqAMkH8SvIQws=;
        b=PN8KwBcNC+xVH5xG0eQ4YOlkfkPpDOsOX+fViBVPmWnvKF2AgkRjsKjxF8+60VTujZ
         Az4VcEGd3ZJzxemKDoPo/ZQUyd9zSSpaiJ4IqMTSy4rtmX3zcQ/l2N7znIhZJc6p/IqA
         CkrpITKkiTU0v4Mqri5c30sjfIgCTqfV3FW9t2uS0YzF/bx7uRvxGijBH+5z6LEkZv8D
         g+gSCjbIHUwDo3UKimu7i3woxW4a8lEwv/HXXrD8eMz7voWPGHfJzW+cE3Yfsz5USiYi
         RLT7VQgiUs4KnVMXPuzEwZYHp92Hwu2Fi07n1BGmdhcs29TKrWsDMJ45KwGafuIoUulg
         8yBQ==
X-Gm-Message-State: ALyK8tKELB6KiiCRsVxRKcFfEnpD2nodwrNjzxXBkHmQz/pKcIRaV31tDgNlUuT6Kh3vJg==
X-Received: by 10.98.4.195 with SMTP id 186mr1987619pfe.98.1465340370312;
        Tue, 07 Jun 2016 15:59:30 -0700 (PDT)
Received: from zoidberg (ip-64-134-222-169.public.wayport.net. [64.134.222.169])
        by smtp.gmail.com with ESMTPSA id v184sm37689750pfb.24.2016.06.07.15.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jun 2016 15:59:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqwpm8zyot.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296748>

On Wed, Jun 01, 2016 at 09:00:34AM -0700, Junio C Hamano wrote:
> 
> Unlike the "something like this" we saw earlier, this draws the
> boundary of responsibility between the caller and the API at a much
> more sensible place.

This makes sense to me - Junio, are you taking (or have you already
taken) dscho's patch, or would you like me to squash it and resend?

Thanks-
-ed
