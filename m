From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] Introduce the function strip_path_suffix()
Date: Wed, 18 Feb 2009 23:27:16 +0100
Message-ID: <499C8B44.1020106@kdbg.org>
References: <cover.1234969572u.git.johannes.schindelin@gmx.de> <7b5ee74d497bbb7144b8683725cd83c8bbd33f9a.1234969572u.git.johannes.schindelin@gmx.de> <499C63E7.5040306@kdbg.org> <alpine.DEB.1.00.0902182211550.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 18 23:29:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZuus-0004Uw-8c
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 23:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242AbZBRW1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 17:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752440AbZBRW13
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 17:27:29 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:22650 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992AbZBRW13 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 17:27:29 -0500
Received: from [77.117.243.175] (77.117.243.175.wireless.dyn.drei.com [77.117.243.175])
	by bsmtp.bon.at (Postfix) with ESMTP id 2BDC02C4007;
	Wed, 18 Feb 2009 23:27:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <alpine.DEB.1.00.0902182211550.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110588>

Johannes Schindelin schrieb:
> On Wed, 18 Feb 2009, Johannes Sixt wrote:
>> Johannes Schindelin schrieb:
>>>  strip_path_suffix("C:\\msysgit/\\libexec\\git-core",
>>>   "libexec///git-core", &prefix)
>>>
>>> will set prefix to "C:\\msysgit" and return 0.
>> But you implemented it so that prefix is actually "C:\\msysgit/\\" 
>> (unless, of course, I'm reading the code wrong).
> 
> This is supposed to handle that case:
> 
> 	*prefix = xstrndup(path, chomp_trailing_dir_sep(path, path_len));

Ah, I missed that final call of chomp_trailing_dir_sep.

-- Hannes
