From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v2 1/3] Documentation: Move variables from config.txt to separate file
Date: Fri, 22 Oct 2010 10:18:11 +0200
Message-ID: <201010221018.12558.jnareb@gmail.com>
References: <cover.1287690696.git.trast@student.ethz.ch> <c3f621cd062b2c4f80aa2e8dadcfddbc042aefaa.1287690696.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 22 10:18:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Cpd-0000z3-KZ
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 10:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755551Ab0JVISZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 04:18:25 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61530 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793Ab0JVISY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 04:18:24 -0400
Received: by wyf28 with SMTP id 28so522366wyf.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 01:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=t3gsVt2RbY/8i99TLyF47rjFL+56nclCeIeWYyheRb0=;
        b=bwuxzOl3PUhJp3tgjUb/TVVNThITcpRmbviJmDX9bZQ5ifC/oqxdCOG556aUtOV4rl
         TYG4QnS2kW9Yru0oIVSVPZx6EsYwvx7xVRMzWoiKOtbcPlpT7pWZ5vLgibrGaWtUqGOc
         qhfGAHmH63UiYz5mIA/eGTW0NoqwOhhiHXuUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=NvSAWkk7P0e1sZfub0qRsaiOUWkT0RVmHmrpmfihZ7ZeQm+KiLP9XYDSAmhNJNkppo
         WXXQnpt4l+eclbNdtP61gbKs9tTJINwm34LbJn4kLshpBYQG06OHT+fOR5WvJpUoyGRW
         /zLHT5irFLCpz3/y93Zl7YpSFy999pawm0lZE=
Received: by 10.227.148.2 with SMTP id n2mr2202040wbv.216.1287735502994;
        Fri, 22 Oct 2010 01:18:22 -0700 (PDT)
Received: from [192.168.1.13] (abwn200.neoplus.adsl.tpnet.pl [83.8.237.200])
        by mx.google.com with ESMTPS id a17sm2228905wbe.12.2010.10.22.01.18.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 01:18:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <c3f621cd062b2c4f80aa2e8dadcfddbc042aefaa.1287690696.git.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159662>

On Fri, 22 Oct 2010, Thomas Rast wrote:

> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  Documentation/config-vars.txt | 1747 ++++++++++++++++++++++++++++++++++++++++
>  Documentation/config.txt      | 1748 +----------------------------------------
>  2 files changed, 1748 insertions(+), 1747 deletions(-)
>  create mode 100644 Documentation/config-vars.txt

I like it, even if the rest of this series would not get accepted.

-- 
Jakub Narebski
Poland
