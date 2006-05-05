From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] binary patch.
Date: Thu, 04 May 2006 22:47:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605042241240.28543@localhost.localdomain>
References: <7vodyd2vqn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 04:47:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbqM1-00030h-4s
	for gcvg-git@gmane.org; Fri, 05 May 2006 04:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWEECrb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 22:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWEECrb
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 22:47:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58349 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932431AbWEECrb
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 4 May 2006 22:47:31 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IYR003W8UF5T780@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 04 May 2006 22:47:30 -0400 (EDT)
In-reply-to: <7vodyd2vqn.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19596>

On Thu, 4 May 2006, Junio C Hamano wrote:

> This adds "binary patch" to the diff output and teaches apply
> what to do with them.

This is nice.

However I'd deflate the delta data before encoding it with base85.


Nicolas
