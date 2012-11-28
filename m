From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Tue, 27 Nov 2012 22:08:24 -0700
Message-ID: <50B59C48.5000100@workspacewhiz.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com> <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com> <50B1F684.5020805@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Nov 28 06:15:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdZzx-0005GL-6C
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 06:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354Ab2K1FPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 00:15:11 -0500
Received: from hsmail.qwknetllc.com ([208.71.137.138]:54919 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab2K1FPH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 00:15:07 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Nov 2012 00:15:07 EST
Received: (qmail 9705 invoked by uid 399); 27 Nov 2012 22:08:26 -0700
Received: from unknown (HELO SlamDunk) (jjensen@workspacewhiz.com@76.23.33.208)
  by hsmail.qwknetllc.com with ESMTPAM; 27 Nov 2012 22:08:26 -0700
X-Originating-IP: 76.23.33.208
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50B1F684.5020805@alum.mit.edu>
X-Antivirus: avast! (VPS 121127-1, 11/27/2012), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210703>

----- Original Message -----
From: Michael Haggerty
Date: 11/25/2012 3:44 AM
> * Startup time: Is the time to start the "X" interpreter prohibitive?
>    (On my computer, "python -c pass", which starts the Python
>    interpreter and does nothing, takes about 24ms.)  This overhead would
>    be incurred by every command that is not pure C.
FWIW, on Windows 7 running on a Core i7 1.6GHz quad core processor, a 
cold run of "python -c pass" after a reboot results in 0.74 seconds.  
The second run takes 0.13 seconds.

Because Lua was mentioned in another message of this thread, I'll 
provide the following:

* A cold run of 'lua5.1 -e ""' takes 0.4 seconds.  The second run takes 
0.03 seconds.
* A cold run of LuaJIT takes the same.

-Josh
