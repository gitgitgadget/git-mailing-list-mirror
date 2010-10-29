From: Markus Duft <mduft@gentoo.org>
Subject: Re: [PATCH 1/2] add support for the SUA layer (interix; windows)
Date: Fri, 29 Oct 2010 07:27:44 +0200
Message-ID: <4CCA5B50.2040208@gentoo.org>
References: <1288168793-11159-1-git-send-email-markus.duft@salomon.at> <1288168793-11159-2-git-send-email-markus.duft@salomon.at> <7veib99608.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 07:51:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBhsR-0002kl-Av
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 07:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409Ab0J2Fvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 01:51:42 -0400
Received: from smtp.salomon.at ([193.186.16.13]:50645 "EHLO sauxb.salomon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752484Ab0J2Fvl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 01:51:41 -0400
X-Greylist: delayed 1308 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Oct 2010 01:51:40 EDT
Received: from servex01.wamas.com (servex01.salomon.at [172.28.2.2])
	by sauxb.salomon.at (8.12.10/8.12.10) with ESMTP id o9T5Smh9029785;
	Fri, 29 Oct 2010 07:28:48 +0200 (METDST)
Received: from [172.28.8.166] ([172.28.8.166]) by servex01.wamas.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Fri, 29 Oct 2010 07:28:48 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.9) Gecko/20100913 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <7veib99608.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 29 Oct 2010 05:28:48.0351 (UTC) FILETIME=[29C836F0:01CB772A]
X-Scanned-By: MIMEDefang 2.54 on 172.28.2.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160266>

On 10/29/2010 02:50 AM, Junio C Hamano wrote:
> mduft@s01en22.salomon.at writes:
[snip]
> 
> It would be much nicer to do this:
> 
>         #ifdef NO_INITGROUPS
>         #define initgroups(x,y) (0) /* nothing */
>         #endif
> 
> near the beginning of the file.  That would make life of people who have
> changes in flight that would touch the same area of the code a lot easier.

ok, i see the point, thanks for your suggestion! I'll change this.

may i ask where i should send v3 of the patch so it gets processed further?
just the ml again, or is there a specific maintainer i should send this to?

regards,
thanks for the help :)
Markus
