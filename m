From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: Git performance on OS X
Date: Sun, 20 Apr 2008 01:57:41 +0200
Message-ID: <AAECC98F-2B6A-4785-8BED-BB4B86F2F2D6@ai.rug.nl>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org> <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl> <m3od85qxcl.fsf@localhost.localdomain> <alpine.LFD.1.10.0804191547320.2779@woody.linux-foundation.org> <alpine.LFD.1.10.0804191551540.2779@woody.linux-foundation.org> <0BE9BBE3-EA9D-4A66-A086-A2A1B289B0DD@ai.rug.nl> <alpine.LFD.1.10.0804191619240.2779@woody.linux-foundation.org> <A07C1A99-084B-4DFC-90CB-B8BDAF7E72EF@sun.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Roman Shaposhnik <rvs@Sun.COM>
X-From: git-owner@vger.kernel.org Sun Apr 20 01:58:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnMwy-0003bw-Qy
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 01:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbYDSX5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 19:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753300AbYDSX5r
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 19:57:47 -0400
Received: from smtp-2.orange.nl ([193.252.22.242]:25352 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753224AbYDSX5r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 19:57:47 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6103.orange.nl (SMTP Server) with ESMTP id 473721C00085;
	Sun, 20 Apr 2008 01:57:46 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6103.orange.nl (SMTP Server) with ESMTP id F18051C00084;
	Sun, 20 Apr 2008 01:57:41 +0200 (CEST)
X-ME-UUID: 20080419235745989.F18051C00084@mwinf6103.orange.nl
In-Reply-To: <A07C1A99-084B-4DFC-90CB-B8BDAF7E72EF@sun.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79938>


On 20 apr 2008, at 01:35, Roman Shaposhnik wrote:
> If it happens on Leopard, DTrace would be a perfect way to query the  
> system:
>
>  $ dtrace -n 'syscall::*:entry /pid==$target/ { @[probefunc] =  
> count(); }' -c "git <do stuff>"

Yes, but this only shows syscalls and only entries. If you have enough  
dtrace-fu to create a script that samples all functions (and thus  
shows which functions are being active most of the time), I will  
gladly run it.

- Pieter
