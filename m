From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 3/3] base85: Make the code more obvious instead of explaining
 the non-obvious
Date: Fri, 08 Jan 2010 18:15:40 -0500
Message-ID: <4B47BC9C.1020807@gmail.com>
References: <alpine.LFD.2.00.1001071253400.21025@xanadu.home> <1262958000-27181-3-git-send-email-agruen@suse.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Sat Jan 09 00:15:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTO3f-0006f8-KL
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 00:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945Ab0AHXPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 18:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161Ab0AHXPv
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 18:15:51 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:40207 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab0AHXPu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 18:15:50 -0500
Received: by yxe26 with SMTP id 26so19167881yxe.4
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 15:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=0ydL0bOXh6U73OBm1+qvQOMzY+bAwLMth38O/ocL1xI=;
        b=rwsM6w8/oRbOi+0ihQl/K/BMUtieAPNLYgMXQgz0E6/BtsOzEI0Yxi0K6o4wzKg1US
         Zx+cBkCdyOcW2nIrfq6jod+Chy4G68rybr0O1HO+zplkUSL9dp7tdRugBnkr+lw1i2lz
         UCPv8rv2W8SQRRYwNpYOj0m0NRHz7oHmCIZGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=LEDntiJiDJ6GEBIzMjv8ya+2TQLUSEVWjCtUrGWInEb5yk2hZFYv1++EtBITb31NWh
         yQPCweARpA0Fybx60hsTl0rgmcKT4Ce2JlH7DqfmEvCLffcnC3Be789W0aXLl6igwTcJ
         SO+Dat8XTTNoCAaNnpVZFbYaGvH4GBifkU4to=
Received: by 10.150.29.30 with SMTP id c30mr8640345ybc.246.1262992547519;
        Fri, 08 Jan 2010 15:15:47 -0800 (PST)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 36sm9448081yxh.67.2010.01.08.15.15.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Jan 2010 15:15:46 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <1262958000-27181-3-git-send-email-agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136491>

Andreas Gruenbacher wrote:
> Here is another cleanup ...
> 

I LOVE the subject line of this commit!
