From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [BUG?] git rebase -i
Date: Mon, 17 Dec 2007 17:04:58 +0100
Message-ID: <9CC305E7-3325-4D17-A43E-0A2072F52084@ai.rug.nl>
References: <2791F15A-EB72-4FE4-8DB3-7A4B4DCB07B3@frim.nl> <47623129.2030303@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 17:06:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4ITV-0008VG-5U
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 17:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbXLQQFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 11:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbXLQQFT
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 11:05:19 -0500
Received: from smtp-3.orange.nl ([193.252.22.243]:9978 "EHLO smtp-3.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758987AbXLQQFS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 11:05:18 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6203.orange.nl (SMTP Server) with ESMTP id C8CEA1C000A5
	for <git@vger.kernel.org>; Mon, 17 Dec 2007 17:05:13 +0100 (CET)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6203.orange.nl (SMTP Server) with ESMTP id 232DC1C0009A;
	Mon, 17 Dec 2007 17:04:59 +0100 (CET)
X-ME-UUID: 20071217160502144.232DC1C0009A@mwinf6203.orange.nl
In-Reply-To: <47623129.2030303@viscovery.net>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68573>

Hi,

On Dec 14, 2007, at 8:30 AM, Johannes Sixt wrote:
> Pieter de Bie schrieb:
>> Another thing to note is
>> that the 1.5.4.rc0 tries to apply 215 patches, while the 1.5.3.5  
>> tries
>> to apply 206 patches.
>
> This is to be expected: 1.5.3.5 counts the comment lines at the top  
> of the
> action file, of which there are exactly 9, 1.5.4.rc0 does not count  
> them.
>

Ok, but what about the error in the rebase?

On Dec 14, 2007, at 2:21 AM, Pieter de Bie wrote:
> Tirana:~/git pieter$ time git rebase -p -i HEAD~100
> cat: /Users/pieter/git/.git/.dotest-merge/rewritten/ 
> 1e8df762b38e01685f3aa3613e2d61f73346fcbe: No such file or directory


- Pieter
