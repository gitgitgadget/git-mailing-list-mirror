From: Timur Tabi <timur@freescale.com>
Subject: Re: How do I get git-format-patch to ignore changes that remove spaces
 from the end of the line?
Date: Tue, 13 Feb 2007 16:36:24 -0600
Organization: Freescale
Message-ID: <45D23D68.6040004@freescale.com>
References: <45D234C5.5090005@freescale.com> <7vhctpwvam.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 23:36:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH6GH-0004Ec-B1
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 23:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbXBMWga (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 17:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbXBMWga
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 17:36:30 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:62664 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbXBMWg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 17:36:29 -0500
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l1DMaPkj006893;
	Tue, 13 Feb 2007 15:36:25 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l1DMaOWl001128;
	Tue, 13 Feb 2007 16:36:24 -0600 (CST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1.2pre) Gecko/20070111 SeaMonkey/1.1
In-Reply-To: <7vhctpwvam.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39593>

Junio C Hamano wrote:

> You could revert the change to the editor configuration and rely
> on "git diff" before committing to point out the whitespace
> breakage that you newly introduced to the file.  Then you would
> be sending out exactly what you changed.

Thanks, but I was hoping that git would make my life easier, not more difficult.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
