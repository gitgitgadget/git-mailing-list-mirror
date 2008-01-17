From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] git-gui/Makefile - Don't convert gg_libdir on Cygwin
Date: Wed, 16 Jan 2008 20:09:33 -0500
Message-ID: <478EAACD.80100@verizon.net>
References: <1199572355-2720-1-git-send-email-mdl123@verizon.net>
 <20080116064012.GO24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 02:10:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFJGn-00074e-On
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 02:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbYAQBJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 20:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbYAQBJo
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 20:09:44 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:54008 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbYAQBJn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 20:09:43 -0500
Received: from [192.168.1.117] ([71.163.17.196]) by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JUR0040KJZQU8H6@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 16 Jan 2008 18:57:27 -0600 (CST)
In-reply-to: <20080116064012.GO24004@spearce.org>
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70797>

Shawn O. Pearce wrote:
> I guess I'm willing to apply your patch and carry the reverse of your
> patch as a local-only hack for my needs, but I wonder if anyone else
> is also using git-gui on Cygwin with a pure Win32 Tcl/Tk build...
>   
Um, well, I would like to as the Cygwin tcl/tk is *never* going to be 
update. Drats. There has to be another way? Perhaps have a separate 
variable for where to install vs. where to look for libraries?

Mark
