From: Christian Biesinger <cbiesinger@web.de>
Subject: Re: [RFC] So... are people happy with commit/status -v?
Date: Sun, 19 Feb 2006 16:18:59 +0100
Message-ID: <43F88C63.3020100@web.de>
References: <7vvevhj6x4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 16:19:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAqLE-0001i4-Rt
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 16:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWBSPTG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 10:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWBSPTG
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 10:19:06 -0500
Received: from smtp08.web.de ([217.72.192.226]:37828 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S1750837AbWBSPTE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Feb 2006 10:19:04 -0500
Received: from [85.124.21.143] (helo=[192.168.1.42])
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.105 #340)
	id 1FAqKy-00056w-00; Sun, 19 Feb 2006 16:19:00 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.9a1) Gecko/20051213 SeaMonkey/1.5a
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvevhj6x4.fsf@assigned-by-dhcp.cox.net>
X-Sender: cbiesinger@web.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16440>

Junio C Hamano wrote:
> I usually never do commits from a subdirectory, also I rarely do
> partial commits, so this is not a big issue to me, but are
> people happy with the current commit/status?

The part that annoyed me most was that "git-status --only ." completely 
ignores the specified path and tells me about the whole tree, rather 
than just the current directory and subdirectories. While I think I'd 
prefer it if the commands limited themselves to the current directory by 
default, I don't mind the current behaviour, as long as I still have the 
possibility to limit to the subdirectory.
