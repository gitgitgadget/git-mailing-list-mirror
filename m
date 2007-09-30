From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] rebase: add --signoff option
Date: Sun, 30 Sep 2007 23:38:27 +0200
Message-ID: <C94CC989-096D-43B5-BA16-DBD4D84038C0@zib.de>
References: <11911689111797-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0709302229320.28395@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 30 23:37:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic6TH-0000CS-21
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 23:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbXI3Vgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 17:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbXI3Vgz
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 17:36:55 -0400
Received: from mailer.zib.de ([130.73.108.11]:38145 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbXI3Vgz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 17:36:55 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l8ULarf4024047;
	Sun, 30 Sep 2007 23:36:53 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1102d.pool.einsundeins.de [77.177.16.45])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l8ULapmA011799
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 30 Sep 2007 23:36:52 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0709302229320.28395@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59573>


On Sep 30, 2007, at 11:30 PM, Johannes Schindelin wrote:

> On Sun, 30 Sep 2007, Steffen Prohaska wrote:
>
>> When preparing a series of commits for upstream you may
>> need to signoff commits if you forgot to do so earlier.
>
> Why not use format-patch's --signoff option for that?

format-patch is fine for mail. But if I either push the commits
to a shared repo (like msysgit's mob) or ask upstream to pull
from my public repo format-patch doesn't help directly.

	Steffen
