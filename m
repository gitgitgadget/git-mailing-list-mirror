From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] fix portability issues with $ in double quotes
Date: Wed, 27 Jan 2010 10:47:24 -0800
Message-ID: <4B608A3C.7090106@gmail.com>
References: <1264547311-25251-1-git-send-email-bebarino@gmail.com> <4B5FF106.3070604@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 27 19:47:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaCvT-0001qy-Jm
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 19:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165Ab0A0Sre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 13:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754591Ab0A0Sre
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 13:47:34 -0500
Received: from gv-out-0910.google.com ([216.239.58.188]:7984 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475Ab0A0Src (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 13:47:32 -0500
Received: by gv-out-0910.google.com with SMTP id n8so449905gve.37
        for <git@vger.kernel.org>; Wed, 27 Jan 2010 10:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=2iAYeupZ/RTcbJL9iOUCPNZRnmp4zolQ2FzvyxCwuAE=;
        b=gdIrRqxk8W7FJis34SyTs64r+mWbj+bPizHdha3kwBFHKGA1WXv0m2QflIzeU/bxqc
         517y8kXAoprn9uev0cN81O/dYM9ALuIFKkHU8XDP2/+bkONIYIQCBWD6A7/R8hICTSx1
         MyoAc7f2Ebzyy2uf2St40B/DUI+OFup2hQ3po=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=M0pfcS3n0ymE6NtnFkhp0Ey+fqHvXoq3VxchsX2Zm7EnPL609jGAP7ye4fHWsOHVfe
         Nbtj4ggzMHjG/HatWN+YzOXr/50yV2dtREI/OIsjQf0hHlQsyUCpAX7brE+swec8jmuQ
         HcIL82d5bsLuQ8wmJMp4S2WS65+WI0M+1c1LI=
Received: by 10.103.85.24 with SMTP id n24mr5040894mul.6.1264618051075;
        Wed, 27 Jan 2010 10:47:31 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id j6sm809991mue.35.2010.01.27.10.47.26
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 27 Jan 2010 10:47:28 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <4B5FF106.3070604@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138181>

On 01/26/2010 11:53 PM, Johannes Sixt wrote:
> The instances you changed look good. I didn't check whether you missed
> some. Was this some sort of mechanical change?

Not really mechanical. I just grepped for sed and grep expressions and 
then went through the results by hand looking for unescaped dollar signs.
