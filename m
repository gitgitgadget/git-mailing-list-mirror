From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: gitignore broken in git 1.7.0.1: slash checks leading dirs
Date: Fri, 05 Mar 2010 10:16:21 +0100
Message-ID: <4B90CBE5.9090102@viscovery.net>
References: <4B90C701.3070308@gmail.com> <4B90C974.2050405@viscovery.net> <4B90C9BE.1030407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Jiri Slaby <jirislaby@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Fri Mar 05 10:16:49 2010
connect(): Connection refused
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1NnTeK-00058x-El
	for glk-linux-kernel-3@lo.gmane.org; Fri, 05 Mar 2010 10:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725Ab0CEJQ0 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 5 Mar 2010 04:16:26 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8709 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751505Ab0CEJQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2010 04:16:24 -0500
X-Greylist: delayed 624 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Mar 2010 04:16:24 EST
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NnTdv-0005V9-0U; Fri, 05 Mar 2010 10:16:23 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2F7DC1660F;
	Fri,  5 Mar 2010 10:16:22 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B90C9BE.1030407@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.0 (-)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141568>

Jiri Slaby schrieb:
> On 03/05/2010 10:05 AM, Johannes Sixt wrote:
>> Jiri Slaby schrieb:
>>> ***
>>> If the pattern does not contain a slash /, git treats it as a shell
>>> glob pattern and checks for a match against the pathname without
>>> leading directories.
>>> ***
>> and this citation confirms my expectation. Note that it says "pathname",
>> not "filename". 'include/linux' is a "pathname".
> 
> What are 'leading directories' then?

'include/' is the leading directory of 'include/linux'.

The cited sentence says that the particular check considers only the last
path component of the pathname.

-- Hannes
