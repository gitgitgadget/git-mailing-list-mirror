From: David Turner <dturner@twopensource.com>
Subject: Re: Signing off, for now
Date: Fri, 03 Jun 2016 14:11:06 -0400
Organization: Twitter
Message-ID: <1464977466.3988.16.camel@twopensource.com>
References: <1464117750.24478.104.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 20:16:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8tdv-0001e3-7G
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 20:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbcFCSQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 14:16:19 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:36239 "EHLO
	mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbcFCSQS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 14:16:18 -0400
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Jun 2016 14:16:18 EDT
Received: by mail-qt0-f175.google.com with SMTP id t13so114680qtc.3
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 11:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :mime-version:content-transfer-encoding;
        bh=ZYlbf5VVlzh8eutG5e5oexDim8yf4SP0Fq1ehAYKD04=;
        b=xhzZXSoLDD55SMJRe9nokq/TYBFoopRbX2OkfSk5AoUziJpRy7t6ClhlY5Ra/JGfdR
         ZtLUB4UzPm1+JQ0EjRF09N1goZ2EZmiCpt6/0JLJ43nGF6tIDHXJWwwtipHVZKrruh7k
         6sY9J/Dav1/Oa8dxBz5jtscuqLiZwMPb7gZn32HAs6Cwz5oRX664q/nWXwbqOlApmcr1
         3r9cxfi47say2aaaskY2cyFP4wO1jNYXBL9xu/7b0HRC35MpG/LqSVm7q0JjKltSs2zq
         2J44mas0HPekhntZ0WvaU8FP6rdU0YY2f6wJfjRtKeR5xmg3cMQ9jIsNNnstUNrisvgy
         B1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ZYlbf5VVlzh8eutG5e5oexDim8yf4SP0Fq1ehAYKD04=;
        b=JawAvvTT+PDRz12Y/yShadPbPE0Q/IWmltW4uwP/6ldZbk/pQzF670Zd3JoixMXHny
         AReOaYruRUnNeZ49L5eHYzqKN8bXlaXSJA6p6hb72pm/xMZd8bzD2UyXv/SH6Sii7XDt
         wKaiR+zzW/m4UpgSZTON6jbcoZvUY8hygr6SHUfVKZSfM30yGNn1/WIsnbEc7xCPhmNW
         zab4ekgePUeb94MglR5Bz06MrZUhgdea+z0NCv4FcDfFJSFBskqtWnNTlfWUTwqsz81G
         chpqKpBgRf2kBQHQw8jPZvrdTQvNpIj/2eJbJ7X1PF658Ck2qCUH4VdWilY/NtUhjDNk
         idGQ==
X-Gm-Message-State: ALyK8tJOkUg2KRlYfYQ39vp3PcyO1ysNtqRWKbOWmbZVnywfRGzqA76Da4gIr/38QuOz/w==
X-Received: by 10.237.52.134 with SMTP id x6mr4599583qtd.27.1464977468050;
        Fri, 03 Jun 2016 11:11:08 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 8sm1821816qhi.35.2016.06.03.11.11.07
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Jun 2016 11:11:07 -0700 (PDT)
In-Reply-To: <1464117750.24478.104.camel@twopensource.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296361>

On Tue, 2016-05-24 at 15:22 -0400, David Turner wrote:
> - Protocol v2: I would like to get a new draft of Stefan's series out
> before I leave, but no promises.  It's turned out to be a bit more
> complicated than I expected to support HTTP.  At worst, I'll toss my
> WIP on github and send a link to the list.  

I didn't get a new draft out, but my WIP (just a few fixes to Stefan's
code plus a couple other cleanup patches) is at 
https://github.com/dturner-tw/git/tree/dturner/protocol-v2
