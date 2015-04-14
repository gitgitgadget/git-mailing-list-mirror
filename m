From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2] reduce progress updates in background
Date: Tue, 14 Apr 2015 11:16:49 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1504141116260.5619@knanqh.ubzr>
References: <20150413134850.GC23475@mewburn.net>
 <alpine.LFD.2.11.1504130954420.5619@knanqh.ubzr>
 <20150413144039.GD23475@mewburn.net>
 <alpine.LFD.2.11.1504131052090.5619@knanqh.ubzr>
 <20150414110312.GE23475@mewburn.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Luke Mewburn <luke@mewburn.net>
X-From: git-owner@vger.kernel.org Tue Apr 14 17:16:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi2a7-0007Aw-CQ
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 17:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227AbbDNPQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 11:16:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20909 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471AbbDNPQu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 11:16:50 -0400
Received: from yoda.home ([66.131.180.142]) by VL-VM-MR002.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0NMS00BUIYG17NC0@VL-VM-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 14 Apr 2015 11:16:49 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 8E1932DA05A3; Tue, 14 Apr 2015 11:16:49 -0400 (EDT)
In-reply-to: <20150414110312.GE23475@mewburn.net>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267142>

On Tue, 14 Apr 2015, Luke Mewburn wrote:

> Updated patch where is_foreground_fd() is only called in display()
> just before the output is to be displayed.

Acked-by: Nicolas Pitre <nico@fluxnic.net>


> 
