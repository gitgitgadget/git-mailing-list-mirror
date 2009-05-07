From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH/RFC] daemon.c: replace inet_ntop with getnameinfo
Date: Thu, 07 May 2009 14:41:47 +0200
Message-ID: <4A02D70B.6090305@op5.se>
References: <4A02D288.6040804@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	jdl@jdl.com
To: Benjamin Kramer <benny.kra@googlemail.com>
X-From: git-owner@vger.kernel.org Thu May 07 14:42:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M22vJ-0008Ii-A1
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 14:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569AbZEGMly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 08:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752193AbZEGMlx
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 08:41:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:58011 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbZEGMlx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 08:41:53 -0400
Received: by fg-out-1718.google.com with SMTP id 16so261129fgg.17
        for <git@vger.kernel.org>; Thu, 07 May 2009 05:41:49 -0700 (PDT)
Received: by 10.86.33.9 with SMTP id g9mr2453996fgg.66.1241700108961;
        Thu, 07 May 2009 05:41:48 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 12sm45522fgg.5.2009.05.07.05.41.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 May 2009 05:41:48 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <4A02D288.6040804@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118472>

Benjamin Kramer wrote:
> git daemon's interpolated paths didn't support IPv6.
> Every IPv6 address was being converted to `0.0.0.0'.
> 
> Fix this by replacing inet_ntop(3) with the protocol
> agnostic getnameinfo(3) API.
> 
> Signed-off-by: Benjamin Kramer <benny.kra@googlemail.com>
> ---
> 
> With this patch we'll have colons in the per-IP directories
> for IPv6 addresses. Creating files with a : in the name fails
> on some OSes (e.g. Windows).
> 

What per-IP directories are you talking about?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
