From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Sun, 21 Mar 2010 09:19:53 -0400
Message-ID: <4BA61CF9.7040104@gmail.com>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>	 <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>	 <4BA544FC.7050007@gmail.com> <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 14:20:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtL4U-0002pS-FQ
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 14:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256Ab0CUNT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 09:19:57 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:64815 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824Ab0CUNT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 09:19:56 -0400
Received: by ywh2 with SMTP id 2so1369685ywh.33
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=LLFKG3TxcWl3i8a/wtnAt8zzJWM1+XXZGzbAC14hh7Y=;
        b=dtsBnpLdA/6vwnX2AGbLXNU+C3v7Cpbf3i3t4chkYU0Qu9xQv6/oVQPbtzMo2KPz/l
         HybaYq7ZpogYDz3rhjXnkV3PpX/8+zDm4U5K7mzV1/L5a/VPCVNcx/2l7L0xdBhlPhM9
         BwflZJsWK/TCdTB6NZR/hcf9cO8UtIw9u49n4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=PqJxCGx0y7dN94cmZrshlBYSIosC+cLVC6Odka7q/7ZsXGbb9VgWoGd9hS0p+eGV9+
         rCSKWwulUOb4I2XEjgA3yR5p2iSxQ9aHNbqN1kYb27sUAhxGDPdaPpQvaRNll4uOm3GR
         +lAHW+UARuO7IhAHmtQYXpG1dlreQf82tnZ6I=
Received: by 10.101.93.11 with SMTP id v11mr3210095anl.18.1269177595439;
        Sun, 21 Mar 2010 06:19:55 -0700 (PDT)
Received: from [10.0.0.6] (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 20sm1231147ywh.48.2010.03.21.06.19.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 06:19:54 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142825>

Bo Yang wrote:
[...]
> For multiple ranges stuff, I don't think it is very useful to support
> it for a history browser. Anyway, our users can only focus on one line
> of thread history. I am very willing to listen what is your use case
> for a multiple ranges?

More than one line range can be related and of interest to a 
forensics/archeology task.

In a simple multi range case, you'd have 2 line ranges in the same file 
that you want to see the history and graph of. Such as 2 related macro 
definitions in a header file.

In a complex multi range case, you'd have many line ranges spread over 
multiple blobs and some of the blobs have disjoint commit graphs.

The complex multi range case may be too much for a GSOC project, and the 
simple multi range case may be also. However, the command syntax should 
be general enough to handle them without being too ugly so that the 
implementation could be improved and expanded later.
