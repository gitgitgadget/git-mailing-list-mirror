From: Robert Shearman <rob@codeweavers.com>
Subject: Re: [PATCH] git-sh-setup: Fail if the git directory was not found.
Date: Sun, 13 Aug 2006 12:52:36 +0100
Organization: CodeWeavers
Message-ID: <44DF1284.5080406@codeweavers.com>
References: <44DC4C92.5060009@codeweavers.com>	<7vfyg2sxrk.fsf@assigned-by-dhcp.cox.net> <7vlkpuragp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 13 13:53:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCEX5-0007RK-FR
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 13:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWHMLxO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 07:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWHMLxO
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 07:53:14 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:15503 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751002AbWHMLxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 07:53:13 -0400
Received: from host86-139-253-196.range86-139.btcentralplus.com ([86.139.253.196] helo=[172.16.0.10])
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GCEWi-0005yk-Sp; Sun, 13 Aug 2006 06:53:09 -0500
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060725)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkpuragp.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25281>

Junio C Hamano wrote:

>Junio C Hamano <junkio@cox.net> writes:
>
>  
>
>>Moving the assignment of GIT_OBJECT_DIRECTORY is fine, but
>>changing it to an unconditional assignment is wrong.  The user
>>can have a GIT_OBJECT_DIRECTORY set independently from GIT_DIR
>>(or ../some/where/.git that is detected).
>>    
>>

I'm not an expert in shell scripting so I didn't notice that it was a 
conditional assignment.

>How about this as a replacement?
>  
>

Looks good.

Thanks,

-- 
Rob Shearman
