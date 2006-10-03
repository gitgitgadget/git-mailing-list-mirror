From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] escape tilde in Documentation/git-rev-parse.txt
Date: Tue, 03 Oct 2006 09:31:14 +0200
Message-ID: <452211C2.8020402@s5r6.in-berlin.de>
References: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de> <7vhcymt07a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 09:33:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUemr-0008TT-EZ
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 09:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWJCHdy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 03:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWJCHdy
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 03:33:54 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:56813 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030197AbWJCHdy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 03:33:54 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from [192.168.0.41] ([83.221.230.151])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id k937XhFi016299
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 3 Oct 2006 09:33:46 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhcymt07a.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.1.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28249>

Junio C Hamano wrote:
...
> This works for me on 7.1; is your 8.0 happy with it?
...
> +tilde=&#126;
...
> -* A suffix '~<n>' to a revision parameter means the commit
> +* A suffix '{tilde}<n>' to a revision parameter means the commit
...

Yes, this works as intended. Thanks,
-- 
Stefan Richter
-=====-=-==- =-=- ---==
http://arcgraph.de/sr/
