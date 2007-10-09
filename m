From: Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no>
Subject: Re: Proposed command: git-sync
Date: Tue, 9 Oct 2007 21:50:44 +0200
Message-ID: <54B911B7-4130-4374-B555-FC23E881BD0A@orakel.ntnu.no>
References: <470BD5CF.9050201@imendio.com>
Mime-Version: 1.0 (Apple Message framework v907)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sven Herzberg <sven@imendio.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 21:51:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfL6V-0002b4-2A
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 21:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbXJITuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 15:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865AbXJITuq
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 15:50:46 -0400
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:54887 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738AbXJITup (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 15:50:45 -0400
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Oct 2007 15:50:45 EDT
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.223])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id 839CA607DB4;
	Tue,  9 Oct 2007 21:50:44 +0200 (CEST)
In-Reply-To: <470BD5CF.9050201@imendio.com>
X-Mailer: Apple Mail (2.907)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60433>

On 9. okt.. 2007, at 21.26, Sven Herzberg wrote:

> I really regularly find myself typing git pull directly after git  
> push.
> That's why I write a small shell script that might be added to the  
> stock
> git distribution.
>
> Regards,
>  Sven
>
> PS: Please add me to the CC of your replies, I don't read this list.
> #!/bin/bash
>
> git push && git pull


I know this isn't really helpful, but you can accomplish the same  
thing by putting the following in your ~/.gitconfig:

[alias]
	sync = "! git push && git pull"

Eyvind Bernhardsen
